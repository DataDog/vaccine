FROM ghcr.io/datadog/images-rb/engines/ruby:2.2-centos-gcc

RUN gem install rack -v 1.6.13
RUN gem install sinatra -v '~> 1.0'

COPY <<RUBY /app/hello.rb
require 'sinatra/base'
require 'json'

class App < Sinatra::Base
  get '/' do
    status 200
    content_type :json
    body JSON.dump({ hello: 'world' })
  end
end

Rack::Server.new(app: App, Host: '0.0.0.0', Port: 3000).start
RUBY

WORKDIR /app

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["ruby hello.rb" ]
