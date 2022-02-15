FROM node:alpine AS builder

RUN apk --no-cache add git
WORKDIR /src

FROM builder AS root_builder
COPY ./minetower.github.io/package.json ./minetower.github.io/yarn.lock ./
RUN yarn install --frozen-lockfile
COPY ./minetower.github.io ./
RUN yarn build

FROM builder AS packs_builder
COPY ./packs/package.json ./packs/yarn.lock ./
RUN yarn install --frozen-lockfile
COPY ./packs ./
RUN yarn build

FROM builder AS minecraft_tweaks_builder
COPY ./minecraft-tweaks/package.json ./minecraft-tweaks/yarn.lock ./
RUN yarn install --frozen-lockfile
COPY ./minecraft-tweaks ./
RUN yarn build

FROM nginx:1.21-alpine
ARG NGINX_ROOT='/usr/share/nginx/html'
COPY --from=root_builder /src/build/ ${NGINX_ROOT}/
COPY ./assets ${NGINX_ROOT}/assets/
COPY --from=packs_builder /src/build/ ${NGINX_ROOT}/packs/
COPY --from=minecraft_tweaks_builder /src/build/ ${NGINX_ROOT}/minecraft-tweaks/
