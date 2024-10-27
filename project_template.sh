#!/bin/bash

# Prompt the user for the environment name
read -p "Enter the name of the virtual environment and project folder: " ENV_NAME

# Create the project folder
mkdir -p $ENV_NAME

# Copy the template files to the project folder
cp -r . $ENV_NAME

# Navigate to the project folder
cd $ENV_NAME

# Initialize a new Git repository
git init

# Create a new Conda environment
conda create -n $ENV_NAME python=3.8 -y

# Activate the Conda environment
conda activate $ENV_NAME

# Install dependencies from requirements.txt
pip install -r requirements.txt

# Print success message
echo "Project setup complete. Conda environment '$ENV_NAME' created and dependencies installed."