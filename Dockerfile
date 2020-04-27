FROM python:alpine

RUN apk add --no-cache --virtual .build-deps gcc musl-dev
RUN apk add --no-cache git
RUN pip install mkdocs
RUN pip install mkdocs-material
RUN pip install mkdocs-awesome-pages-plugin
ENV GIT_PYTHON_GIT_EXECUTABLE /usr/bin/git
ENV GIT_PYTHON_REFRESH quiet
RUN pip install mkdocs-git-revision-date-localized-plugin
RUN apk del .build-deps gcc musl-dev

WORKDIR /app

CMD ["mkdocs", "serve"]
