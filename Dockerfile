# Base image
FROM python:3.10.8-slim-buster

# Fix sources for old Debian (buster is EOL)
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list

# Update system & install git
RUN apt update && apt upgrade -y
RUN apt install -y git

# Copy requirements
COPY requirements.txt /requirements.txt

# Install Python dependencies
RUN pip3 install -U pip && pip3 install -U -r /requirements.txt

# Set working directory
RUN mkdir /VJ-File-Store
WORKDIR /VJ-File-Store

# Copy all project files
COPY . /VJ-File-Store

# Run bot
CMD ["python", "bot.py"]
