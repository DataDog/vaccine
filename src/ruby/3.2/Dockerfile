FROM ghcr.io/datadog/images-rb/engines/ruby:3.2-centos-gcc

RUN gem install rails
RUN rails new weblog --minimal -GMOCAJT && cd weblog

RUN bundle check || bundle install

WORKDIR /weblog

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
