FROM python:3.11-slim-bullseye

RUN mkdir /app && chmod 777 /app
WORKDIR /app
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

# Copy the rest of the application
COPY . .

# Fix for Heroku - use the port provided by Heroku
CMD gunicorn --bind 0.0.0.0:$PORT app:app & python -m main
