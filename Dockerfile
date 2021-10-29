FROM python:alpine
ADD requirements.txt /requirements.txt
RUN apk add --no-cache --virtual .build-deps gcc musl-dev
RUN apk add --no-cache git
ENV GIT_PYTHON_GIT_EXECUTABLE /usr/bin/git
ENV GIT_PYTHON_REFRESH quiet
RUN pip install -r requirements.txt
RUN apk del .build-deps gcc musl-dev

WORKDIR /app

CMD ["mkdocs", "serve"]
