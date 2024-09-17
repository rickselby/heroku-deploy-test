require 'bundler'

Bundler.require

get '/' do
  "TEST_CONFIG_VAR = #{ENV.fetch("TEST_CONFIG_VAR")} || #{ENV.inspect}"
end
