# frozen_string_literal: true

require_relative './../../lib/links'

RSpec.describe 'A link object' do
  let(:link) { Link.new('/federico-home-page', '127.0.0.1') }

  context 'that has just been initialised' do
    it 'should have the right url' do
      expect(link.url).to eq('/federico-home-page')
    end

    it 'should have the views counter set to initial state (1)' do
      expect(link.views).to eq(1)
    end

    it 'should have only one unique ip' do
      expect(link.unique_ips.count).to eq(1)
    end
  end

  context 'when an already present ip address is added' do
    it 'should increment the view counter' do
      link.add_ip('127.0.0.1')
      expect(link.views).to eq(2)
    end

    it 'shouldn\'t increment the number of unique ips' do
      link.add_ip('127.0.0.1')
      expect(link.unique_ips.count).to eq(1)
    end
  end

  context 'when an new ip address is added' do
    it 'should increment the view counter' do
      link.add_ip('2.37.238.231')
      expect(link.views).to eq(2)
    end

    it 'should increment the number of unique ips' do
      link.add_ip('2.37.238.231')
      expect(link.unique_ips.count).to eq(2)
    end

    it 'should contain the right unique ips' do
      link.add_ip('2.37.238.231')
      expect(link.unique_ips).to match_array(['2.37.238.231', '127.0.0.1'])
    end
  end
end
