#!/bin/bash

# Check if conda is installed
if ! command -v conda &> /dev/null
then
    echo "Conda could not be found. Please install Conda first."
    exit
fi

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

# Install required tools
conda install sphinx behave pytest pytest-cov mypy flake8 -y
pip install pip-tools tox

# Function to create project structure
create_project_structure() {
    project_name=$1
    mkdir "$project_name"
    cd "$project_name" || exit
    mkdir src
    mkdir test
    mkdir docs
    mkdir lib
    mkdir data
    mkdir scripts
    mkdir config
    mkdir bin
    mkdir assets
    touch README.md
    echo "# $project_name" > README.md
    echo "This is the $project_name project." >> README.md
    touch requirements.txt
    touch .env.example
    # Copy .gitignore template
    cat <<EOF > .gitignore
# Ignore system files and directories
.DS_Store
Thumbs.db
desktop.ini

# Ignore IDE and editor files
.vscode/
.idea/
*.sublime-workspace
*.suo
*.cache/
*.log

# Ignore build and compiled files
node_modules/
bower_components/
*.log
*.tmp
*.temp
*.swp
*.out
*.class
*.dll
*.exe
*.pdb
*.jar
*.war
*.ear
*.egg
*.egg-info/
*.pyc
*.pyo
*.pyc/

# Ignore dependency manifests
package-lock.json
yarn.lock
Gemfile.lock
composer.lock
pipfile.lock

# Ignore sensitive or environment-specific information
.env
.env.local
.env.*.local
.env.development.local
.env.test.local
.env.production.local

# Ignore miscellaneous
*.DS_Store
EOF

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

# Create project structure
create_project_structure "$ENV_NAME"

echo "Project structure created, tools installed, and git repository initialized in the conda environment '$ENV_NAME'."