# Use a lightweight Debian-based image
FROM balenalib/armv7hf-debian:latest

# Set working directory inside the container
WORKDIR /app

# Copy the monitoring script
COPY monitor_resources.sh /app/monitor_resources.sh

# Ensure the script is executable
RUN chmod +x /app/monitor_resources.sh

# Create a logs directory inside the container
RUN mkdir -p /app/logs

# Define the default command to run the monitoring script
CMD ["bash", "/app/monitor_resources.sh"]