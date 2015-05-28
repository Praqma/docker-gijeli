FROM debian:8.0

MAINTAINER Jan Sorensen <jas@praqma.net>

RUN apt-get update && \
	apt-get install -y curl gcc && \
	curl -sL https://deb.nodesource.com/setup | bash - && \
	apt-get install -y ruby ruby-dev make nodejs && \
	gem install jekyll http json rdiscount --no-ri --no-rdoc

WORKDIR /data

EXPOSE 4000

ENTRYPOINT ["jekyll"]
