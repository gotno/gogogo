require "rack"
require "rack/server"

class AbstractSomeMoreLikeWeDidLastSummer
  def self.call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    if (msg = request.params["msg"])
      response.status = 200
      response.write("WELCOME TO WEBSITE\n\n")
      response.write("thank you so much for saying \"#{msg}\" to me!")
    else
      response.status = 400
      response.body = [["what?", "huh?", "eh?"].sample]
    end

    response.finish
  end
end

Rack::Server.start(app: AbstractSomeMoreLikeWeDidLastSummer)
