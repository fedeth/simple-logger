# frozen_string_literal: true

require_relative './lib/log_parser'
require_relative './lib/formatter'

raise ArgumentError, 'Missing expected argument' unless ARGV[0]

parser = LogParser.new(ARGV[0])
formatter = Formatter.new(tab_size: 5, separator: '>>>', empty_lines: 1)

puts formatter.format('url', '# pages')
parser.sort_by_views.each do |entry|
  puts formatter.format(entry.url, entry.views)
end

puts "-------------------\n\n"

puts formatter.format('url', '# unique ips')
parser.sort_by_unique_ip.each do |entry|
  puts formatter.format(entry.url, entry.unique_ips.count)
end
