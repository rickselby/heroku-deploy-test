require 'bundler'

Bundler.require

get '/' do
  "TEST_CONFIG_VAR = #{ENV.fetch("TEST_CONFIG_VAR")} || #{p ENV}"
end
