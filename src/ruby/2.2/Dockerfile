FROM ghcr.io/datadog/images-rb/engines/ruby:2.2-centos-gcc

RUN gem install io-console -v 0.5.4
RUN gem install concurrent-ruby -v 1.1.10
RUN gem install i18n -v 1.5.1
RUN gem install racc -v 1.5.2
RUN gem install nokogiri -v 1.9.1
RUN gem install rails -v '~> 5.2.0'
RUN rails new weblog --minimal -GMOCAJT

WORKDIR /weblog

RUN bundle add loofah --version 2.19.0
RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
