require "logstash/devutils/rspec/spec_helper"
require "logstash/event"
require "logstash/codecs/phtrace"

describe LogStash::Codecs::Phtrace do
  context "Normal message handling" do
    subject do
      next LogStash::Codecs::Phtrace.new({})
    end

    it "should parse a normal packet" do
      expect(28).to eq(28)
    end
  end 
end