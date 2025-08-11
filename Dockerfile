FROM ubuntu:20.04

ARG ENV
ENV APP_ENV=$ENV

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
