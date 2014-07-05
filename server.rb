require 'goliath'
require 'grape'

require_relative 'app/apis/phrases'

class Application < Goliath::API
  def response(env)
    ::Phrases::API.call(env)
  end
end