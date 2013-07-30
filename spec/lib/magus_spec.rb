require 'spec_helper'

module Magento
  describe Magento, ".configure" do
    context "when a block is given" do
      it "yields the Magento module" do
        expect { |config| Magento.configure(&config) }.to yield_with_args Magento
      end
    end

    context "when no block is given" do
      it "returns nothing" do
        expect(Magento.configure).to eq nil
      end
    end
  end

  describe Magento, ".endpoint" do
    let(:url) { "http://www.example.com/api/soap" }

    it "can be set directly" do
      Magento.endpoint = url
      expect(Magento.endpoint).to eq url
    end

    it "can be set from the configuration block" do
      Magento.configure {|c| c.endpoint = url}
      expect(Magento.endpoint).to eq url
    end
  end

  describe Magento, ".username" do
    let(:user) { "jdoe" }

    it "can be set directly" do
      Magento.username = user
      expect(Magento.username).to eq user
    end

    it "can be set from the configuration block" do
      Magento.configure {|c| c.username = user}
      expect(Magento.username).to eq user
    end
  end

  describe Magento, ".api_key" do
    let(:api_key) { "password" }

    it "can be set directly" do
      Magento.api_key = api_key
      expect(Magento.api_key).to eq api_key
    end

    it "can be set from the configuration block" do
      Magento.configure {|c| c.api_key = api_key}
      expect(Magento.api_key).to eq api_key
    end
  end
end
