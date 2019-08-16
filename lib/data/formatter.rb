require 'base_x'

class Formatter

    def initialize(size=6)
        @size = size
      end
    
    def format(value)
        text = BaseX::URLBase64.integer_to_string(value)
        if text.length > @size 
            raise ArgumentError.new('Number too large: ' + value.to_s)
        end
        text.rjust(@size, "0")
    end

    def parse(text)
        if text.length != @size
            raise ArgumentError.new('Invalid size: ' + text)
        end
        value = BaseX::URLBase64.string_to_integer(text.sub!(/^0*/, ''))
        value
    end
end