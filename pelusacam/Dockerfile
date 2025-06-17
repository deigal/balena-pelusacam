# Use a lightweight base image
FROM balenalib/armv7hf-debian:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    alsa-utils \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists/*

#Download and install AzCopy
RUN curl -L https://aka.ms/downloadazcopy-v10-linux -o azcopy.tar.gz && \
   tar -xvf azcopy.tar.gz && \
   rm azcopy.tar.gz && \
   mv azcopy_linux_amd64_*/azcopy /usr/local/bin/azcopy && \
   chmod +x /usr/local/bin/azcopy

# Create working directory
WORKDIR /app

# Copy entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]