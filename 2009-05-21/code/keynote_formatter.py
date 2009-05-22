from pygments.formatter import Formatter
from pygments.token import Token
from cgi import escape

class KeynoteFormatter(Formatter):
    def __init__(self, styles):
        Formatter.__init__(self)

        def style_name(item):
            name, style = item
            if name == 'Paragraph':
                style = 'SFWPParagraphStyle-%s' % str(style)
            else:
                style = 'SFWPCharacterStyle-%s' % str(style)
            return (name, style)

        self.styles = dict(map(style_name, styles.items()))

    def style_for_ttype(self, ttype):
        parts = str(ttype).split('.')
        name = '.'.join(parts[1:])
        gen_name = parts[1]

        if name in self.styles:
            return self.styles[name]
        elif gen_name in self.styles:
            return self.styles[gen_name]
        else:
            return None

    def format(self, tokensource, outfile):
        outfile.write('<sf:p sf:style="%s" sf:list-level="1">'
                      % self.styles['Paragraph'])

        for ttype, value in tokensource:
            style = self.style_for_ttype(ttype)
            text = escape(value).replace('\n', '<sf:lnbr/>')

            if style:
                outfile.write('<sf:span sf:style="%s">%s</sf:span>'
                              % (style, text))
            else:
                outfile.write(text)

        outfile.write('</sf:p>')
