require 'jwt'

class JwtAuth
  def initialize(app, options={}) # Options are required, but we want to throw more sensible error (with .fetch call)
    @app = app
    @secret = options.fetch(:secret) # Will raise an exception if no secret is passed — that's OK
  end
  
  # Slight modification of alexgenco's rack-jwt code
  def call(env)
    if authorization = env["HTTP_AUTHORIZATION"]
      claim = ::JWT.decode(authorization, @secret)
      #TODO Add token expiration check here
      env["rack.jwt.claim"] = claim

      @app.call(env)
    else
      unauthorized 'No JWT token provided'
    end
  rescue ::JWT::DecodeError
    unauthorized 'Incorrect token'
  end

  private
  def unauthorized reason
    [401, {}, reason]
  end
end