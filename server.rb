require 'goliath'
require 'grape'

class Application < Goliath::API
  def response(env)
    ::Phrases::V1.call(env)
  end
end

module Phrases
  class V1 < Grape::API
    version 'v1', :using => :path
    format :json

    get '/' do
      :ok
    end
  end
end