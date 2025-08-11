FROM python:3.11-slim
ARG ENV=dev
WORKDIR /app
COPY . .
COPY config.${ENV}.json /app/config.json
EXPOSE 80
CMD ["python3", "-m", "http.server", "80"]
