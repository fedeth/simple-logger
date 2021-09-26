# frozen_string_literal: true

require_relative './../../lib/log_line'

RSpec.describe 'A logline object' do
  context 'with a bad initialization' do
    it 'should be fail' do
      expect { LogLine.new('/about 235.313.352.') }.to raise_error(MalformedLogLineError)
    end
  end

  let(:logline) { LogLine.new('/about 235.313.352.950') }

  context 'with a correct initialization' do
    it 'has the original log line' do
      expect(logline.line).to eq('/about 235.313.352.950')
    end

    it 'has the right url' do
      expect(logline.url).to eq('/about')
    end

    it 'has the right ip address' do
      expect(logline.ip).to eq('235.313.352.950')
    end
  end
end
