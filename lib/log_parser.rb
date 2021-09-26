# frozen_string_literal: true

require_relative './log_line'
require_relative './links'

class MissingFileError < StandardError
end

class LogParser
  attr_reader :log_line_class, :entries_class
  attr_accessor :entries

  def initialize(file_path, entries_class: Links, log_line_class: LogLine)
    raise MissingFileError unless File.file?(file_path)

    log_lines = []
    File.foreach(file_path) do |line|
      next if /^\s*$/.match?(line) # skip empty lines

      # Maybe I could rescue MalformedLogLineError lines by skipping them and print an alert?
      log_lines.push(log_line_class.new(line))
    end
    @log_line_class = log_line_class
    @entries_class = entries_class
    @entries = entries_class.new(log_lines)
  end

  def sort_by_views
    entries.sort_by_views
  end

  def sort_by_unique_ip
    entries.sort_by_unique_ip
  end
end
