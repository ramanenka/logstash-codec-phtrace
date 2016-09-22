Gem::Specification.new do |s|

  s.name            = 'logstash-codec-phtrace'
  s.version         = '1.0.0'
  s.licenses        = ['MIT']
  s.summary         = "Read events from the phtrace binary protocol"
  s.description     = "This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program"
  s.authors         = ["Vadzim Ramanenka"]
  s.email			= 'vadromanenko@gmail.com'
  s.homepage		= 'https://github.com/vadd/logstash-codec-phtrace'
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "codec" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60.0", "< 2.0.0"
  s.add_development_dependency "logstash-devutils", ">= 0.0.22", "< 1.0.0"
end
