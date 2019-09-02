### CREACION DEL COMPILADO ###
FROM node:12.2.0 as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY ./package.json /app/package.json

RUN npm install
RUN npm install -g @angular/cli@8.1.2
COPY . /app

RUN ng build --prod

### INSTALACION EN SERVIDOR ###
FROM nginx:1.16.0-alpine
#COPY --from=build /app/dist/service-bank-app /usr/local/apache2/htdocs/
COPY --from=build /app/dist/cineapp-frontend /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]