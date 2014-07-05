require_relative 'phrases/v1'

module Phrases
  class API < Grape::API
    mount ::Phrases::V1
  end
end