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
        begin
          phrase = Phrase.create(value: params[:value])
          [201, {}, phrase]
        rescue ActiveRecord::RecordNotUnique
          error! 'This phrase is already in the database', 409
        end
      end
    end
  end
end
