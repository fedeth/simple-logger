# frozen_string_literal: true

require_relative './lib/log_parser'
require_relative './lib/formatter'

raise ArgumentError, 'Missing expected argument, please provide a valid file' unless ARGV[0]

parser = LogParser.new(ARGV[0])
formatter = Formatter.new(tab_size: 3, separator: '>', empty_lines: 1)

parser.sort_by_views.each do |entry|
  puts formatter.format(entry.url, "#{entry.views} visits")
end

puts "-------------------\n\n"

parser.sort_by_unique_ip.each do |entry|
  puts formatter.format(entry.url, "#{entry.unique_ips.count} unique views")
end
