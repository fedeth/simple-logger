# frozen_string_literal: true

require_relative './../../lib/log_parser'

RSpec.describe 'A parser object' do
  let(:parser) { LogParser.new('spec/support/sample.log') }
  context 'when initialized badly' do
    it 'should raise an error if the file does not exist' do
      expect { LogParser.new('no_file.log') }.to raise_error(MissingFileError)
    end
  end

  context 'when initialized correctly' do
    it 'should have entries' do
      expect(parser.entries.count).to eq(6)
    end
  end

  context 'when calling sorting methods' do
    let(:mock_link_instance) { instance_double('Links', sort_by_views: [], sort_by_unique_ip: []) }
    let(:mock_link_class) { class_double('Links') }

    it 'should delegate sort_by_views message' do
      allow(mock_link_class).to receive(:new).and_return(mock_link_instance)
      allow(mock_link_instance).to receive(:sort_by_views)

      LogParser.new('spec/support/sample.log', entries_class: mock_link_class).sort_by_views

      expect(mock_link_instance).to have_received(:sort_by_views)
    end

    it 'should delegate sort_by_unique_ip message' do
      allow(mock_link_class).to receive(:new).and_return(mock_link_instance)
      allow(mock_link_instance).to receive(:sort_by_unique_ip)

      LogParser.new('spec/support/sample.log', entries_class: mock_link_class).sort_by_unique_ip

      expect(mock_link_instance).to have_received(:sort_by_unique_ip)
    end
  end
end
