require_relative '../../models/phrase'

module Phrases
  class V1 < Grape::API
    version 'v1', :using => :path
    format :json

    namespace 'phrases' do
      get '/' do
        Phrase.count
      end

      get 'random' do
        Phrase.random
      end
    end
  end
end
