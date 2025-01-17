FROM ghcr.io/datadog/images-rb/engines/ruby:3.0-centos-gcc

RUN gem install rails -v 7.1.5.1
RUN rails new app --minimal -GMOCAJT --skip-bundle

WORKDIR /app

RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
