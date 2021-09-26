# frozen_string_literal: true

require 'set'

class Link
  attr_reader :url, :views, :unique_ips

  def initialize(url, ip)
    @url = url
    @views = 1
    @unique_ips = Set.new([ip])
  end

  def add_ip(ip)
    @views += 1
    @unique_ips.add(ip) unless @unique_ips.include?(ip)
    self
  end
end

class Links
  include Enumerable

  attr_reader :link_class

  def initialize(elements = [], link_class: Link)
    @links = {}
    @link_class = link_class
    elements.each do |elem|
      add_element(elem)
    end
  end

  def add_element(element)
    if @links[element.url]
      @links[element.url].add_ip(element.ip)
    else
      @links[element.url] = @link_class.new(element.url, element.ip)
    end
  end

  def add_elements(ele)
    ele.each { |elem| add_element(elem) }
  end

  def each(&block)
    @links.each do |_url, link|
      block.call(link)
    end
  end

  def sort_by_views
    sort_by(&:views).reverse! # fastest way? https://stackoverflow.com/questions/2642182/how-to-sort-an-array-in-descending-order-in-ruby
  end

  def sort_by_unique_ip
    sort_by { |link| link.unique_ips.count }.reverse!
  end
end
