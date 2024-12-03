FROM ghcr.io/datadog/images-rb/engines/ruby:2.5-centos-gcc

RUN gem install rails
RUN rails new app --minimal -GMOCAJT

WORKDIR /app

RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
