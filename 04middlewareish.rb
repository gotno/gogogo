require "rack"
require "rack/server"

class ParamsParser
  def call(env)
    request = Rack::Request.new env
    env['params'] = request.params
  end
end

class SuchDemonstration
  def self.call(env)
    parser = ParamsParser.new
    env = parser.call env

    [ 200, { }, [ env['params'].inspect ] ]
  end
end

Rack::Server.start(app: SuchDemonstration)
