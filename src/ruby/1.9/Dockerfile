FROM ghcr.io/datadog/images-rb/engines/ruby:1.9-centos-gcc

RUN gem install rails
RUN rails new weblog --minimal -GMOCAJT

WORKDIR /weblog

RUN bundle add loofah --version 2.19.0
RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
