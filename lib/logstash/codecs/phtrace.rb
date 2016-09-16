# encoding: utf-8
require "logstash/codecs/base"

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

  public
  def register
  end
  
  public
  def decode(data)
      replace = { "message" => data.to_s + @append }
      yield LogStash::Event.new(replace)
  end

end