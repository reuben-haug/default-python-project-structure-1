# Use the official Python image from the Docker Hub
FROM python:3.10-slim

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

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Create project structure
RUN mkdir -p /app/src /app/tests /app/docs /app/lib /app/data /app/scripts /app/config /app/bin /app/assets /app/notebook

# Install Sphinx
RUN pip install sphinx

# Initialize Sphinx documentation
RUN sphinx-quickstart -q -p "Default Python Project Structure" -a "Reuben Haug" --ext-autodoc --ext-viewcode --ext-napoleon --makefile --sep /app/docs

# Update index.rst
RUN echo "\n   overview\n   api" >> /app/docs/source/index.rst

# Copy the rest of the application code
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["python", "src/main.py"]
