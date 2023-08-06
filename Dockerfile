FROM crystallang/crystal:latest
WORKDIR /usr/src/app
COPY shard.yml shard.lock ./
RUN shards install
COPY . .
RUN crystal build --release src/openai.cr
CMD ["./openai"]
