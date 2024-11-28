FROM ghcr.io/datadog/images-rb/engines/ruby:1.8-centos-gcc

RUN gem install rack -v 1.6.13
RUN gem install rack-cache -v 1.2
RUN gem install rails -v 3.2.0
RUN rails new weblog --minimal -GMOCAJT

WORKDIR /weblog

RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
