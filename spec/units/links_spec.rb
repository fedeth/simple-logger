# frozen_string_literal: true

require_relative './../../lib/links'

RSpec.describe 'A new links object' do
  links = Links.new
  let(:log1) { double('LogLine') }
  let(:log2) { double('LogLine') }

  context 'that has just been initialised' do
    it 'should be an enumerable' do
      expect(links).to be_a(Enumerable)
    end

    it 'should return an istance of link_class of the element added' do
      allow(log1).to receive(:url).and_return('/home')
      allow(log1).to receive(:ip).and_return('192.168.0.1')

      expect(links.add_element(log1)).to be_a(links.link_class)
    end

    it 'should have an element' do
      expect(links.count).to eq(1)
    end
  end

  context 'filled with other some elements' do
    it 'should allow to add more elements at time' do
      allow(log1).to receive(:url).and_return('/careers')
      allow(log1).to receive(:ip).and_return('192.168.0.1')

      allow(log2).to receive(:url).and_return('/contact_us')
      allow(log2).to receive(:ip).and_return('192.168.0.1')

      links.add_elements([log1, log1, log1, log1, log2])

      expect(links.count).to eq(3)
    end

    it 'should sort elements by_views' do
      allow(log1).to receive(:url).and_return('/contact_us')
      allow(log1).to receive(:ip).and_return('127.0.0.1')

      allow(log2).to receive(:url).and_return('/contact_us')
      allow(log2).to receive(:ip).and_return('8.8.8.8')

      links.add_elements([log1, log2])
      sorted_by_views = links.sort_by_views.map { |link| "#{link.url}##{link.views}" }

      expect(sorted_by_views).to eq(['/careers#4', '/contact_us#3', '/home#1'])
    end

    it 'should sort elements by_unique_ip' do
      allow(log1).to receive(:url).and_return('/careers')
      allow(log1).to receive(:ip).and_return('127.0.0.1')

      links.add_element(log1)

      sorted_by_unique_ip = links.sort_by_unique_ip.map { |link| "#{link.url}##{link.unique_ips.count}" }

      expect(sorted_by_unique_ip).to eq(['/contact_us#3', '/careers#2', '/home#1'])
    end
  end
end
