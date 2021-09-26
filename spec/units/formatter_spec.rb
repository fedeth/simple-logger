# frozen_string_literal: true

require_relative './../../lib/formatter'

RSpec.describe 'A formatter' do
  let(:formatter) { Formatter.new }

  context 'initialized with no arguments' do
    it 'should format args with the default style' do
      expect(formatter.format('', '')).to eq("   >>>   \n ")
    end

    it "shouldn't add any spacer element when only one arg is provided" do
      expect(formatter.format('only_one')).to eq("only_one\n ")
    end

    it 'should behave consistently with more than two args' do
      expect(formatter.format('A', 'B', 'C', 'D')).to eq("A   >>>   B   >>>   C   >>>   D\n ")
    end
  end

  context 'when their properties has been modified' do
    it 'should change its separator' do
      formatter.separator = '---'
      expect(formatter.format('', '')).to eq("   ---   \n ")
    end

    it 'should change its tab_size' do
      formatter.tab_size = 2
      expect(formatter.format('', '')).to eq("  >>>  \n ")
    end

    it 'should change the nuber of emptylines left after' do
      formatter.empty_lines = 4
      expect(formatter.format('', '')).to eq("   >>>   \n\n\n\n ")
    end
  end
end
