FROM ghcr.io/datadog/images-rb/engines/ruby:2.6-centos-gcc

RUN gem install rails --no-document
# see: https://github.com/rails/rails/issues/54263
RUN gem uninstall concurrent-ruby --ignore-dependencies && gem install concurrent-ruby -v 1.3.4 --no-document
RUN rails new app --minimal -GMOCAJT --skip-bundle

WORKDIR /app

# Force ruby platform to avoid prebuilt nokogiri binary which needs glibc 2.28
RUN echo 'gem "nokogiri", force_ruby_platform: true' >> Gemfile
# Force ruby platform to avoid prebuilt ffi binary which needs glibc 2.27
RUN echo 'gem "ffi", force_ruby_platform: true' >> Gemfile

RUN echo 'gem "concurrent-ruby", "= 1.3.4"' >> Gemfile

RUN bundle check || bundle install

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
