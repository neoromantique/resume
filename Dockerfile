FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    pandoc \
    fonts-liberation \
    xfonts-75dpi \
    xfonts-base \
    fontconfig \
    ca-certificates \
    libssl-dev \
    openssl \
    xz-utils \
    libxrender1 \
    libfontconfig1 \
    libxtst6 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltopdf from the packaging repository
RUN wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb -O /tmp/wkhtmltox.deb && \
    apt-get update && \
    apt-get install -y /tmp/wkhtmltox.deb && \
    rm -f /tmp/wkhtmltox.deb && \
    rm -rf /var/lib/apt/lists/*

# Verify installation
RUN which wkhtmltopdf && wkhtmltopdf --version

# Set up a working directory
WORKDIR /resume

# Add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
