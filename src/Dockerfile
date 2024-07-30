ARG RUBY_BASE_IMAGE

FROM ghcr.io/datadog/images-rb/engines/${RUBY_BASE_IMAGE}

RUN gem install rails
RUN rails new weblog --minimal -GMOCAJT

RUN cd weblog && bundle check

WORKDIR /weblog

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["bin/rails server -b 0.0.0.0" ]
