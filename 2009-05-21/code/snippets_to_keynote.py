from pygments import highlight
from pygments.lexers import get_lexer_for_filename
from keynote_formatter import KeynoteFormatter

filename = 'keynote_formatter.py'
snippet = '../snippets/%s/format' % filename

f = open(snippet, 'r')
code = f.read()
f.close()

styles = {'Paragraph':1907, 'Keyword':285, 'Operator':285,
          'Comment':287, 'Literal':286, 'Name.Function':288,
          'Name.Class':288}

formatter = KeynoteFormatter(styles)

lexer = get_lexer_for_filename(filename, stripall=True)
result = highlight(code, lexer, formatter)

print(result)
