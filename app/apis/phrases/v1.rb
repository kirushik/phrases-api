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

      params do
        requires :value, type: String
      end
      post '/' do
        phrase = Phrase.create(value: params[:value])
        [201, {}, phrase]
      end
    end
  end
end
