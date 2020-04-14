FROM python:alpine

RUN apk add --no-cache --virtual .build-deps gcc musl-dev
RUN pip install mkdocs
RUN pip install mkdocs-material
RUN pip install mkdocs-awesome-pages-plugin
RUN apk del .build-deps gcc musl-dev

WORKDIR /app

CMD ["mkdocs", "serve"]
