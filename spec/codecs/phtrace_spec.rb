require "logstash/devutils/rspec/spec_helper"
require "logstash/event"
require "logstash/codecs/phtrace"

describe LogStash::Codecs::Phtrace do
  context "Normal message handling" do
    subject do
      next LogStash::Codecs::Phtrace.new({})
    end

    it "should parse begin and end request events" do
      data = [
        "01" + "10000000" + "298fa6e55d4b43ddb1fa89b0c4e97ac2" +
        "02" + "00000000"
      ].pack('H*')
      
      counter = 0;
      subject.decode(data) do |event|
        case counter
        when 0
          expect(event.get("_id")).to eq("298fa6e5-5d4b-43dd-b1fa-89b0c4e97ac2")
          expect(event.get("_type")).to eq("request_begin")
        when 1
          expect(event.get("_id")).to eq("298fa6e5-5d4b-43dd-b1fa-89b0c4e97ac2")
          expect(event.get("_type")).to eq("request_end")
        end
        
        counter += 1
      end
      
      expect(counter).to eq(2)
    end
  end 
end
