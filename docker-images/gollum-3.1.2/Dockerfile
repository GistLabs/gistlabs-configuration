FROM ubuntu:14.04

MAINTAINER Joshua Reynolds <josh@gistlabs.com>

# Derived from suttang/gollum

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y -q build-essential ruby1.9.3 python2.7 ruby-bundler libicu-dev libreadline-dev libssl-dev zlib1g-dev git-core
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install gollum
RUN gem install -v 3.1.2 gollum 
RUN gem install redcarpet github-markdown

# Initialize wiki data
RUN mkdir /root/wikidata
RUN git init /root/wikidata

# Expose default gollum port 4567
EXPOSE 4567

ENTRYPOINT ["/usr/local/bin/gollum", "/root/wikidata"]

