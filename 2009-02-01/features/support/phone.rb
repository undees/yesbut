require 'enumerator'

module Phone
  class Dict
    def initialize(kvs)
      @kvs = kvs
    end

    def to_xpath
      conds = []
      @kvs.each_slice(2) do |k, v|
        c = "key[.='#{k}' and following-sibling::string[1]/.='#{v}']"
        c.gsub! "'", "&apos;"
        conds << c
      end

      "//dict[#{conds.join(' and ')}]"
    end
  end

  class Command
    def initialize(name, opts)
      @name = name
      @opts = opts
    end

    def to_xml
      keys = ''
      @opts.each_slice(2) do |k, v|
        keys << Command.entry_for(k, v)
      end

      return <<HERE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
	<dict>
		<key>command</key>
		<string>#{@name}</string>
#{keys.chomp}
	</dict>
</array>
</plist>
HERE
    end

    def self.entry_for(k, v)
      return <<HERE
      		<key>#{k}</key>
      		<string>#{v}</string>
HERE
    end

    def self.empty
      return <<HERE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
</array>
</plist>
HERE
    end
  end
end
