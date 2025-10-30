FROM python:3.9-slim-bullseye

RUN mkdir /app && chmod 777 /app
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -qq update && apt -qq install -y git python3 python3-pip ffmpeg
COPY . .
# Install compatible Pyrogram version before requirements
RUN pip3 install "pyrogram==1.4.16" && pip3 install -r requirements.txt
CMD gunicorn app:app & python -m main
