require_relative '../../models/phrase'

module Phrases
  class V1 < Grape::API
    version 'v1', :using => :path
    format :json

    namespace 'phrases' do
      get '/' do
        Phrase.count
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

      get 'random' do
        Phrase.random
      end

      params do
        requires :file
      end
      post 'bulk_upload' do
        filename = "#{Dir.pwd}/uploads/#{Time.now.to_i}_#{params[:file][:filename]}"
        FileUtils.copy(params[:file][:tempfile].path, filename) # To ensure all permissions are OK
        params[:file][:tempfile].unlink

        :ok
      end
    end
  end
end
