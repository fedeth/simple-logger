# frozen_string_literal: true

class MalformedLogLineError < StandardError
end

class LogLine
  attr_accessor :line

  def initialize(line)
    @line = line
    raise MalformedLogLineError, "line doesn't respect the expected logline syntax" unless valid?
  end

  def ip
    %r{ .*$}.match(line).to_s.strip
  end

  def url
    %r{^.* }.match(line).to_s.strip
  end

  private

  def valid?
    %r{^/[a-z0-9/_]{1,} [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$}.match?(line)
  end
end
