FROM ghcr.io/datadog/images-rb/engines/ruby:3.4-centos-gcc

RUN gem install rails -v 8.0.1 --no-document
RUN rails new app --minimal -GMOCAJT --skip-bundle

WORKDIR /app

# Force ruby platform to avoid prebuilt nokogiri binary which needs glibc 2.28
RUN echo 'gem "nokogiri", force_ruby_platform: true' >> Gemfile
RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
