require_relative '../../models/phrase'

module Phrases
  class V1 < Grape::API
    version 'v1', :using => :path
    format :json

    get '/' do
      Phrase.count
    end
  end
end
