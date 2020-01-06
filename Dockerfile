FROM node:12-alpine as builder

WORKDIR /app
ENV NODE_ENV=production

ADD ./ ./
RUN npm run build

FROM node:12-alpine
WORKDIR /app

ENV HOST 0.0.0.0
EXPOSE 3000

COPY --from=builder ./app/package.json ./
COPY --from=builder ./app/nuxt.config.js ./
COPY --from=builder ./app/node_modules ./node_modules/
COPY --from=builder ./app/.nuxt ./.nuxt/
COPY --from=builder ./app/static ./static/

EXPOSE 3000
CMD ["npm", "run", "start"]
