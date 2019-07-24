FROM python:3-alpine

RUN apk add --no-cache ca-certificates bash openssh-client
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /tini
RUN chmod +x /tini

WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt

ENTRYPOINT ["/tini", "--", "./entrypoint.sh"]
