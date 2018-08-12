FROM node:8-alpine
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash git openssh
EXPOSE 3089
WORKDIR /home/node
COPY --chown=node:node . .
USER node:node
ENV PORT=3089 NODE_ENV=production
RUN mkdir dist && \
    git submodule init && \
    git submodule update && \
    mkdir -p dist/dep/normalize.css/ && \
    cp dep/normalize.css/normalize.css dist/dep/normalize.css/normalize.css && \
    cp resume.html dist/index.html && \
    cp style.css dist/style.css && \
    yarn install
CMD npx serve -s dist -p $PORT