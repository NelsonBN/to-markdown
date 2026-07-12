FROM python:3.13-slim-bullseye AS source

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/microsoft/markitdown.git /markitdown


FROM python:3.13-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV EXIFTOOL_PATH=/usr/bin/exiftool
ENV FFMPEG_PATH=/usr/bin/ffmpeg

# Runtime dependencies
# - ffmpeg / exiftool: required by markitdown
# - poppler-utils: provides pdfimages, used to extract embedded images from PDFs
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    exiftool \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=source /markitdown/. /app
RUN pip --no-cache-dir install \
    /app/packages/markitdown[all] \
    /app/packages/markitdown-sample-plugin

# Default USERID and GROUPID
ARG USERID=nobody
ARG GROUPID=nogroup

USER $USERID:$GROUPID
