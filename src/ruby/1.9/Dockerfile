FROM ghcr.io/datadog/images-rb/engines/ruby:1.9-centos-gcc

RUN gem install minitest -v 5.12.0
RUN gem install concurrent-ruby -v 1.1.9
RUN gem install racc -v 1.4.16
RUN gem install rails -v '~> 4.2.0'
RUN rails new weblog --minimal -GMOCAJT

WORKDIR /weblog

RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
