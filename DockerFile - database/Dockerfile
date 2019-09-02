FROM postgres:10.9-alpine
LABEL maintainer="martinhuacho@hotmail.com"
ENV POSTGRES_PASSWORD=123
ENV POSTGRES_DB=cineapp
ENV POSTGRES_USER=postgres
EXPOSE 5432
COPY ./scripts/ /docker-entrypoint-initdb.d/
CMD ["postgres"]
