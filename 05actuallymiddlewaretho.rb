require "rack"
require "rack/server"

class ParamScrambler
  def initialize(app)
    @app = app
  end

  def call(env)
    queries = env["QUERY_STRING"].split("&")
    queries.map! do |query|
      key = query.split("=")[0]
      value = query.split("=")[1].split("+").shuffle.join("+")
      "#{key}=#{value}"
    end
    env["QUERY_STRING"] = queries.join("&")

    @app.call(env)
  end
end

class Timer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, body = @app.call(env)

    duration = Time.now - start_time
    body.write("\n\n duration of execution: #{duration}s")

    [ status, headers, body ]
  end
end

class TakesSooooLong
  def initialize(app)
    @app = app
  end

  def call(env)
    20_000_000.times do |i|
      Math.sqrt(5)
    end
    @app.call(env)
  end
end

class GoAheadThen
  def self.call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    response.status = 200
    response.write(request.params.inspect)
    response.finish
  end
end

app = Rack::Builder.new do
  use Timer
  use ParamScrambler
  use TakesSooooLong
  run GoAheadThen
end

Rack::Server.start(app: app)
