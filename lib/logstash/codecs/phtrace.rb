# encoding: utf-8
require "logstash/codecs/base"

class HeaderError < LogStash::Error; end
class UnknownMessageError < LogStash::Error; end

# Read events from the phtrace binary protocol over the network via udp.
#
# Configuration in your Logstash configuration file can be as simple as:
# [source,ruby]
#     input {
#       tcp {
#         port => 19229
#         buffer_size => 1452
#         codec => phtrace { }
#       }
#     }
#
class LogStash::Codecs::Phtrace < LogStash::Codecs::Base
  config_name "phtrace"

  config :append, :validate => :string, :default => ', Hello World!'
  
  @current_request_uuid = false

  public
  def register
  end
  
  public
  def decode(data)
    pos = 0

    while pos < data.bytesize do
      type = data.byteslice(pos).unpack("C")[0]
      pos += 1
      
      payloadLength = data.byteslice(pos..pos + 4).unpack("V")[0];
      pos += 4

      raise(HeaderError) if pos + payloadLength > data.bytesize 
      
      case type
      when 1
        event = decode_msg_request_begin data, pos, payloadLength 
      when 2
        event = decode_msg_request_end data, pos, payloadLength
      else
        raise(UnknownMessageError)
      end
      
      pos += payloadLength
      yield event
    end
  end
  
  protected
  def decode_msg_request_begin(data, pos, payloadLength)
    @current_request_uuid = uuid_unpack data, pos
    pos += 16
    
    return LogStash::Event.new({
      "_id" => @current_request_uuid,
      "_type" => "request_begin"
    })
  end
  
  protected
  def decode_msg_request_end(data, pos, payloadLength)
    return LogStash::Event.new({
      "_id" => @current_request_uuid,
      "_type" => "request_end"
    })
  end
  
  protected
  def uuid_unpack(data, pos)
    return data.byteslice(pos..pos + 16).unpack("H8H4H4H4H12").join("-")
  end

end