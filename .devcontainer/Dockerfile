# Use the official Python image from the Docker Hub
FROM mcr.microsoft.com/devcontainers/universal:2-linux

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add a non-root user
RUN useradd -m myuser
USER myuser

# Install Python dependencies
COPY ../requirements.txt /app/
RUN pip install --no-cache-dir -r /app/requirements.txt

# Create project structure
RUN mkdir -p /app/src /app/tests /app/docs /app/lib /app/data /app/scripts /app/config /app/bin /app/assets /app/notebook

# Copy the rest of the application code
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["python", "src/main.py"]
