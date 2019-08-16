require 'minitest/autorun'
require './lib/data/formatter'

class FormatterTest < Minitest::Test
  def test_format_successfull
    length = 4
    formatter = Formatter.new(4)
    value = formatter.format(1)
    assert value != nil
    assert value.length == length
    assert value === '000B'
  end
  def test_format_failed
    length = 4
    formatter = Formatter.new(2)
    assert_raises ArgumentError do
        formatter.format(999999)
      end
  end
  def test_parse_successfull
    formatter = Formatter.new(4)
    value = formatter.parse('000C')
    assert value != nil
    assert value === 2
  end
  def test_parse_failed
    length = 4
    formatter = Formatter.new(2)
    assert_raises ArgumentError do
        formatter.parse('AAA')
      end
  end  

end

