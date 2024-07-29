FROM ghcr.io/datadog/images-rb/engines/ruby:3.0

RUN gem install rails
RUN rails new weblog --minimal -GMOCAJT

RUN cd weblog && bundle check

WORKDIR /weblog

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
