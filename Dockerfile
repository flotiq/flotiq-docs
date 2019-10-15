FROM python:alpine

RUN pip install mkdocs
RUN pip install mkdocs-material
RUN pip install mkdocs-awesome-pages-plugin

WORKDIR /app

CMD ["mkdocs", "serve"]