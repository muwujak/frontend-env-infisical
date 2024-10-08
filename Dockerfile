# Build Stage
FROM node:16.18.0 as build
WORKDIR /app
COPY . .
RUN cp .env .env
RUN yarn
RUN yarn build
# production environment
FROM nginx:1.21
COPY --from=build /app/build /usr/share/nginx/html
# COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
