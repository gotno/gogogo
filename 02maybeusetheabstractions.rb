require "rack"
require "rack/server"

class LetsAbstract
  def self.call(env)
    request = Rack::Request.new(env)

    # response = [
    #   "xhr? #{request.xhr?.inspect}",
    #   "post? #{request.post?.inspect}",
    #   "get? #{request.get?.inspect}",
    #   request.params.inspect,
    # ].join("\n")
    # [ 200, {}, [response] ]

    if (msg = request.params["msg"])
      response = "thank you so much for saying \"#{msg}\" to me!"
      [ 200, {}, [response] ]
    else
      response = ["what?", "huh?", "eh?"].sample
      [ 400, {}, [response] ]
    end
  end
end

Rack::Server.start(app: LetsAbstract)
