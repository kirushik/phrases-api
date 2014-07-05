module Phrases
  class V1 < Grape::API
    version 'v1', :using => :path
    format :json

    get '/' do
      :ok
    end
  end
end
