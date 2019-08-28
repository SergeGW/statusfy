FROM node:8-alpine AS builder

ENV STATUSFY_VERSION 0.4.3
ENV NODE_ENV production

WORKDIR /usr/src/app

RUN \
   set -x \
&& yarn install \
&& yarn add "statusfy@$STATUSFY_VERSION" \
&& npx statusfy build


FROM node:8-alpine

ENV NODE_ENV development
ENV HOST 0.0.0.0
ENV PORT 3000
ENV WORKDIR /usr/src/app

COPY --from=builder --chown=node:node /usr/src/app/ $WORKDIR

COPY ./scripts/docker-start.sh /start.sh
RUN chmod +x /start.sh
RUN \
    mkdir /usr/src/app/content 2> /dev/null && \
    rm -f /usr/src/app/package.json && \
    rm -f /usr/src/app/config.js && \
    rm -f /usr/src/app/node_modules/@statusfy/core/lib/new-incident.js && \
    rm -f /usr/src/app/node_modules/@statusfy/core/lib/update-incident.js && \
    rm -f /usr/src/app/node_modules/@statusfy/core/lib/content/database.js && \
    rm -f /usr/src/app/node_modules/@statusfy/core/client/helpers/statuses.js && \
    rm -f /usr/src/app/node_modules/@statusfy/core/client/assets/css/styles.css && \
    rm -f /usr/src/app/node_modules/@statusfy/core/client/locales/ru-default.json

COPY ./config/package.json /usr/src/app/package.json
COPY ./config/config.js /usr/src/app/config.js
COPY ./config/new-incident.js /usr/src/app/node_modules/@statusfy/core/lib/new-incident.js
COPY ./config/update-incident.js /usr/src/app/node_modules/@statusfy/core/lib/update-incident.js
COPY ./config/database.js /usr/src/app/node_modules/@statusfy/core/lib/content/database.js
COPY ./config/statuses.js /usr/src/app/node_modules/@statusfy/core/client/helpers/statuses.js
COPY ./config/styles.css /usr/src/app/node_modules/@statusfy/core/client/assets/css/styles.css
COPY ./config/ru-default.json /usr/src/app/node_modules/@statusfy/core/client/locales/ru-default.json

WORKDIR $WORKDIR
VOLUME $WORKDIR
EXPOSE $PORT

VOLUME ["/usr/src/app/content"]

CMD ["/start.sh"]
