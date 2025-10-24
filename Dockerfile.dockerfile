# Use official Python image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Prevent Python from writing .pyc and buffering
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies required for numpy/scipy/matplotlib
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libatlas-base-dev \
    liblapack-dev \
    gfortran \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy application code
COPY . .

# Expose flask port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
