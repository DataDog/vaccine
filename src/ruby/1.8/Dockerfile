FROM ghcr.io/datadog/images-rb/engines/ruby:1.8-centos-gcc

WORKDIR /app

COPY <<RUBY Gemfile
source 'https://rubygems.org'

gem 'rack', '1.6.13'
gem 'tilt', '2.0.11'
gem 'sinatra', '~> 1.0'
gem 'json', '1.8.6'
RUBY

RUN bundle install

COPY <<RUBY hello.rb
require 'rubygems'
require 'sinatra/base'
require 'json'

class App < Sinatra::Base
  get '/' do
    status 200
    content_type :json
    body JSON.dump({ :hello => 'world' })
  end
end

Rack::Server.new(:app => App, :Host => '0.0.0.0', :Port => 3000).start
RUBY

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bundle exec ruby hello.rb" ]
