require "magus/version"

module Magento
  class << self
    attr_accessor :endpoint, :username, :api_key
  end

  def self.configure
    yield self if block_given?
  end
end
