#!/bin/bash

# Check if conda is installed
if ! command -v conda &> /dev/null
then
    echo "Conda could not be found. Please install Conda first."
    exit
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker could not be found. Installing Docker..."
    # Install Docker based on the OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update
        sudo apt-get install -y docker.io
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install --cask docker
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        choco install docker-desktop
    else
        echo "Unsupported OS. Please install Docker manually."
        exit 1
    fi
fi

# Add the user to the docker group
sudo usermod -aG docker $USER

# Avoid logout/login by creating a new group session
newgrp docker

# Prompt the user for the environment name
read -p "Enter the name of the virtual environment and project folder: " ENV_NAME

if [ -z "$ENV_NAME" ]; then
    echo "Environment name cannot be empty."
    exit 1
fi

# Create a new conda environment
conda create -n $ENV_NAME python=3.11 -y

# Activate the environment
source activate $ENV_NAME

# Function to create project structure
create_project_structure() {
    project_name=$1
    mkdir "$project_name"
    cd "$project_name" || exit
    mkdir src
    mkdir tests
    mkdir docs
    mkdir lib
    mkdir data
    mkdir scripts
    mkdir config
    mkdir bin
    mkdir assets
    mkdir notebook
    touch README.md
    echo "# $project_name" > README.md
    echo "This is the $project_name project." >> README.md
    touch requirements.txt
    touch .env.example

    # Add a default LICENSE file (MIT License)
    cat <<EOF > LICENSE
MIT License

Copyright (c) $(date +%Y) $(git config user.name)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

    git init
    cd ..
}

# Function to initialize Sphinx documentation
initialize_sphinx() {
    sphinx-quickstart docs --quiet --project "$project_name" --author "$(git config user.name)" --release "0.1.0"
    cat <<EOF > docs/index.rst
.. $project_name documentation master file, created by
   sphinx-quickstart on $(date).

Welcome to $project_name's documentation!
=========================================

Contents:

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   overview
   api

Indices and tables
==================

* :ref:\`genindex\`
* :ref:\`modindex\`
* :ref:\`search\`
EOF
}

# Create project structure
create_project_structure "$ENV_NAME"

# Initialize Sphinx documentation
initialize_sphinx

# Install dependencies from requirements.txt
pip install -r requirements.txt

echo "Project structure created, tools installed, and git repository initialized in the conda environment '$ENV_NAME'."
