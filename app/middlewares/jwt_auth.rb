require 'jwt'

class JwtAuth
  def initialize(app, options={}) # Options are required, but we want to throw more sensible error (with .fetch call)
    @app = app
    @secret = options.fetch(:secret) # Will raise an exception if no secret is passed — that's OK
  end
  
  def call(env)
    @app.call(env) # TODO Here should go our JWT validation code
  end
end