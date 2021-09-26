# frozen_string_literal: true

class Formatter
  attr_accessor :tab_size, :separator, :empty_lines

  def initialize(tab_size: 3, separator: '>>>', empty_lines: 1)
    @tab_size = tab_size
    @separator = separator
    @empty_lines = empty_lines
  end

  def format(*args)
    output_str = ''
    args.each_with_index do |arg, ind|
      output_str += "#{arg}#{build_spacer if ind < args.length - 1}"
    end
    "#{output_str}#{"\n" * empty_lines} "
  end

  private

  def build_spacer
    "#{' ' * tab_size}#{separator}#{' ' * tab_size}"
  end
end
