FROM node:alpine as test-env
RUN apk add --no-cache bash && mkdir -p /app
WORKDIR /app
COPY . /app
RUN npm install && npm run test

FROM alpine:edge
RUN apk add --no-cache curl
ENTRYPOINT ["/wait-for"]
CMD ["--help"]
COPY --from=test-env /app/wait-for /wait-for
