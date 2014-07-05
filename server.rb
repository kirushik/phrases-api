require 'goliath'
require 'grape'

require 'em-synchrony/activerecord'
db = YAML.load File.read('config/database.yml')
ActiveRecord::Base.establish_connection(db)


require_relative 'app/apis/phrases'
require_relative 'app/middlewares/jwt_auth'

class Application < Goliath::API
  use JwtAuth, secret: 'changeme'

  def response(env)
    ::Phrases::API.call(env)
  end
end