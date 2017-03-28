require "rack"
require "rack/server"

class ThingWhatResponds
  def self.call(env)
    [ 200, {}, [env.to_s.gsub(",", ",\n")] ]
  end
end

Rack::Server.start(app: ThingWhatResponds)
