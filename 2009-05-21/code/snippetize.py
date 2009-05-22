import os

# For old Python
def relative(src, target):
    common = os.path.commonprefix((src, target))
    rel = target[len(common):]
    depth = len(rel.split(os.path.sep))
    prefix = os.path.sep.join(['..'] * depth)

    return os.path.join(prefix, rel)

whitelist = ['.py', '.sh']

extracts = {'keynote_formatter.py':[['format', 'def format(', '</sf:p>']]}

for root, dirs, files in os.walk('.'):
    for name in files:
        _, ext = os.path.splitext(name)
        if ext in whitelist:
            base = os.path.join('..', 'snippets', name)

            if not os.path.exists(base):
                os.makedirs(base)

            target = os.path.join(os.path.abspath(base), 'all')
            src = os.path.abspath(name)

            rel = relative(target, src)

            if not os.path.lexists(target):
                os.symlink(rel, target)

            if name in extracts:
                f = open(name, 'r')
                lines = f.readlines()

                for extract in extracts[name]:
                    title, start, stop = extract

                    out_path = os.path.join(os.path.abspath(base), title)
                    out = None

                    for line in lines:
                        if start in line:
                            out = open(out_path, 'w')

                        if out:
                            out.write(line)

                        if stop in line:
                            out.close()
                            out = None

                f.close()
