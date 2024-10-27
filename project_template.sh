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
    echo "# {{ project_name }}" > README.md
    echo "This repository is a template repository for Agile Python projects for personal portfolio projects. The template has a default folder structure with commonly used sub-directories such as `docs`, `notebook`, `src`, and `tests`. The template also includes a `.gitignore`, `README`, and `LICENSE` file with the MIT license." >> README.md
    echo "" >> README.md
    echo "## Folder Structure" >> README.md
    echo "" >> README.md
    echo "The folder structure of the template is as follows:" >> README.md
    echo "" >> README.md
    echo "```\n{{ project_name }}/\n│\n├── docs/\n│\n├── notebook/\n│\n├── src/\n│\n├── tests/\n├── .gitignore\n├── LICENSE\n├── README.md\n├── requirements.txt\n└── .devcontainer/\n```" >> README.md
    echo "" >> README.md
    echo "## Installation Steps" >> README.md
    echo "" >> README.md
    echo "1. **Create a new empty Github Codespace**:" >> README.md
    echo "    - Open your GitHub repository and click on the \"Code\" button." >> README.md
    echo "    - Select \"Open with Codespaces\" and create a new codespace." >> README.md
    echo "" >> README.md
    echo "2. **Connect to the codespace through desktop VS Code or online**:" >> README.md
    echo "    - If using desktop VS Code, install the \"GitHub Codespaces\" extension." >> README.md
    echo "    - Open the \"Remote Explorer\" view and connect to your codespace." >> README.md
    echo "    - If using the online editor, simply open the codespace in your browser." >> README.md
    echo "" >> README.md
    echo "3. **Clone the repository**:" >> README.md
    echo "    ```sh\n    git clone https://github.com/{{ github_username }}/{{ project_name }}.git\n    cd {{ project_name }}\n    ```" >> README.md
    echo "" >> README.md
    echo "4. **Initialize the project structure**:" >> README.md
    echo "    - The `.devcontainer/Dockerfile` will automatically create the project structure, including directories like `src`, `tests`, `docs`, `lib`, `data`, `scripts`, `config`, `bin`, `assets`, and `notebook`." >> README.md
    echo "    - Essential files like `README.md`, `requirements.txt`, `.env.example`, `.gitignore`, and `LICENSE` will also be created." >> README.md
    echo "" >> README.md
    echo "5. **Install dependencies**:" >> README.md
    echo "    - The `postCreateCommand` in `.devcontainer/devcontainer.json` will install the required packages listed in `requirements.txt`." >> README.md
    echo "" >> README.md
    echo "6. **Set up Sphinx documentation**:" >> README.md
    echo "    - The `.devcontainer/Dockerfile` will install Sphinx and initialize the documentation in the `docs` directory." >> README.md
    echo "    - The `index.rst` file in the `docs` directory will be updated to include the necessary sections." >> README.md
    echo "" >> README.md
    echo "7. **Customize the template**:" >> README.md
    echo "    - Modify the `process_template_files` function in `project_template.sh` to replace placeholders with your project-specific details." >> README.md
    echo "    - Update the `README.md` and `docs/overview.rst` files to reflect the specifics of your new project." >> README.md
    echo "" >> README.md
    echo "8. **Use Poetry for dependency management**:" >> README.md
    echo "    - Initialize a new Poetry environment:" >> README.md
    echo "        ```sh\n        poetry init\n        ```" >> README.md
    echo "    - Add dependencies using Poetry:" >> README.md
    echo "        ```sh\n        poetry add <dependency>\n        ```" >> README.md
    echo "" >> README.md
    echo "9. **Set up version control**:" >> README.md
    echo "    - Initialize a new Git repository if not already done by the script:" >> README.md
    echo "        ```sh\n        git init\n        ```" >> README.md
    echo "    - Commit your changes:" >> README.md
    echo "        ```sh\n        git add .\n        git commit -m \"Initial commit\"\n        ```" >> README.md
    echo "" >> README.md
    echo "10. **Documentation**:" >> README.md
    echo "    - Use Sphinx to generate and maintain project documentation. The `docs` directory already contains the necessary files to get started." >> README.md
    echo "    - Build the documentation:" >> README.md
    echo "        ```sh\n        cd docs\n        make html\n        ```" >> README.md
    echo "" >> README.md
    echo "11. **Testing**:" >> README.md
    echo "    - Write tests in the `tests` directory and use pytest to run them:" >> README.md
    echo "        ```sh\n        pytest\n        ```" >> README.md
    echo "" >> README.md
    echo "12. **Linting and formatting**:" >> README.md
    echo "    - Use flake8 for linting:" >> README.md
    echo "        ```sh\n        flake8 .\n        ```" >> README.md
    echo "    - Use black for code formatting:" >> README.md
    echo "        ```sh\n        black .\n        ```" >> README.md
    echo "" >> README.md
    echo "13. **Continuous integration**:" >> README.md
    echo "    - Set up a CI pipeline using GitHub Actions or another CI tool to automate testing and linting." >> README.md
    echo "" >> README.md
    echo "## Requirements" >> README.md
    echo "" >> README.md
    echo "The `requirements.txt` file includes the necessary packages with appropriate version numbers:" >> README.md
    echo "```\n{{ dependencies }}\n```" >> README.md
    echo "" >> README.md
    echo "## Documentation" >> README.md
    echo "" >> README.md
    echo "The `docs` directory contains Sphinx documentation for the project. The following files are included:" >> README.md
    echo "- `index.rst`: The main index file for the documentation." >> README.md
    echo "- `overview.rst`: The project overview." >> README.md
    echo "- `API.rst`: The API documentation." >> README.md
    echo "" >> README.md
    echo "## Troubleshooting" >> README.md
    echo "" >> README.md
    echo "If you encounter any issues during the template installation, follow these steps:" >> README.md
    echo "" >> README.md
    echo "1. **Remove deprecated linting settings**:" >> README.md
    echo "    - Remove the deprecated `python.linting.flake8Enabled` setting from your `.vscode/settings.json` and `.devcontainer/devcontainer.json` files." >> README.md
    echo "    - Install the `flake8` extension from the Visual Studio Code marketplace using the command:" >> README.md
    echo "        ```sh\n        code --install-extension ms-python.flake8\n        ```" >> README.md
    echo "" >> README.md
    echo "2. **Ensure the directory exists**:" >> README.md
    echo "    - Verify that the directory `/workspaces/{{ project_name }}/.pixi/envs` exists or update your configuration to point to the correct directory." >> README.md
    echo "" >> README.md
    echo "3. **Verify Python interpreter path**:" >> README.md
    echo "    - Ensure that the Python interpreter path set in `.vscode/settings.json` and `.devcontainer/devcontainer.json` is correct and the interpreter is accessible." >> README.md
    echo "" >> README.md
    echo "4. **Install missing tools**:" >> README.md
    echo "    - Install `pyenv` and `poetry` if needed for managing Python versions and dependencies using the following commands:" >> README.md
    echo "        ```sh\n        # Install pyenv\n        curl https://pyenv.run | bash\n" >> README.md
    echo "" >> README.md
    echo "        # Install poetry\n        curl -sSL https://install.python-poetry.org | python3 -\n        ```" >> README.md
    echo "" >> README.md
    echo "5. **Verify environment paths**:" >> README.md
    echo "    - Ensure that the paths to your Python interpreter and virtual environments are correctly set up and accessible." >> README.md
    echo "" >> README.md
    echo "6. **Check Pylance language server**:" >> README.md
    echo "    - Ensure that the Pylance language server is starting correctly for Python IntelliSense." >> README.md
    echo "" >> README.md
    echo "7. **Verify Conda and Hatch tools**:" >> README.md
    echo "    - Ensure that `conda` and `hatch` tools are installed and configured if you are using them." >> README.md
    echo "" >> README.md
    echo "By addressing these points, you should be able to resolve the issues and have a smoother development experience in Visual Studio Code." >> README.md
    echo "" >> README.md
    echo "## Contributing" >> README.md
    echo "" >> README.md
    echo "We welcome contributions to improve this template repository. To contribute, follow these steps:" >> README.md
    echo "" >> README.md
    echo "1. **Fork the repository**:" >> README.md
    echo "    - Click the \"Fork\" button at the top right corner of this repository to create a copy of the repository in your GitHub account." >> README.md
    echo "" >> README.md
    echo "2. **Clone your forked repository**:" >> README.md
    echo "    ```sh\n    git clone https://github.com/{{ github_username }}/{{ project_name }}.git\n    cd {{ project_name }}\n    ```" >> README.md
    echo "" >> README.md
    echo "3. **Create a new branch**:" >> README.md
    echo "    ```sh\n    git checkout -b feature/your-feature-name\n    ```" >> README.md
    echo "" >> README.md
    echo "4. **Make your changes**:" >> README.md
    echo "    - Implement your changes and ensure that they follow the project's coding standards and guidelines." >> README.md
    echo "" >> README.md
    echo "5. **Test your changes**:" >> README.md
    echo "    - Run the tests to ensure that your changes do not introduce any issues." >> README.md
    echo "    ```sh\n    pytest\n    ```" >> README.md
    echo "" >> README.md
    echo "6. **Commit your changes**:" >> README.md
    echo "    ```sh\n    git add .\n    git commit -m \"Add your commit message here\"\n    ```" >> README.md
    echo "" >> README.md
    echo "7. **Push your changes to your forked repository**:" >> README.md
    echo "    ```sh\n    git push origin feature/your-feature-name\n    ```" >> README.md
    echo "" >> README.md
    echo "8. **Create a pull request**:" >> README.md
    echo "    - Open your forked repository on GitHub and click the \"New pull request\" button." >> README.md
    echo "    - Provide a clear and descriptive title and description for your pull request." >> README.md
    echo "    - Submit the pull request for review." >> README.md
    echo "" >> README.md
    echo "9. **Review and feedback**:" >> README.md
    echo "    - Your pull request will be reviewed by the repository maintainers." >> README.md
    echo "    - Address any feedback or requested changes." >> README.md
    echo "" >> README.md
    echo "10. **Merge**:" >> README.md
    echo "    - Once your pull request is approved, it will be merged into the main repository." >> README.md
    echo "" >> README.md
    echo "Thank you for contributing to this project!" >> README.md
    echo "" >> README.md
    echo "## Detailed Instructions and Examples" >> README.md
    echo "" >> README.md
    echo "### Setting Up the Project" >> README.md
    echo "" >> README.md
    echo "1. **Clone the repository**:" >> README.md
    echo "    ```sh\n    git clone https://github.com/{{ github_username }}/{{ project_name }}.git\n    cd {{ project_name }}\n    ```" >> README.md
    echo "" >> README.md
    echo "2. **Create a virtual environment**:" >> README.md
    echo "    ```sh\n    python -m venv venv\n    source venv/bin/activate  # On Windows use `venv\Scripts\activate`\n    ```" >> README.md
    echo "" >> README.md
    echo "3. **Install dependencies**:" >> README.md
    echo "    ```sh\n    pip install -r requirements.txt\n    ```" >> README.md
    echo "" >> README.md
    echo "4. **Initialize the project structure**:" >> README.md
    echo "    - The `project_template.sh` script will automatically create the project structure, including directories like `src`, `tests`, `docs`, `lib`, `data`, `scripts`, `config`, `bin`, `assets`, and `notebook`." >> README.md
    echo "    - Essential files like `README.md`, `requirements.txt`, `.env.example`, `.gitignore`, and `LICENSE` will also be created." >> README.md
    echo "" >> README.md
    echo "### Using the Project" >> README.md
    echo "" >> README.md
    echo "1. **Running the application**:" >> README.md
    echo "    - Navigate to the `src` directory and run the main application file:" >> README.md
    echo "        ```sh\n        cd src\n        python main.py\n        ```" >> README.md
    echo "" >> README.md
    echo "2. **Running tests**:" >> README.md
    echo "    - Navigate to the `tests` directory and run the tests using pytest:" >> README.md
    echo "        ```sh\n        cd tests\n        pytest\n        ```" >> README.md
    echo "" >> README.md
    echo "3. **Building the documentation**:" >> README.md
    echo "    - Navigate to the `docs` directory and build the documentation using Sphinx:" >> README.md
    echo "        ```sh\n        cd docs\n        make html\n        ```" >> README.md
    echo "" >> README.md
    echo "### Examples" >> README.md
    echo "" >> README.md
    echo "1. **Example script**:" >> README.md
    echo "    - Create a new script in the `scripts` directory:" >> README.md
    echo "        ```sh\n        touch scripts/example_script.py\n        ```" >> README.md
    echo "    - Add the following content to the script:" >> README.md
    echo "        ```python\n        def main():\n            print(\"Hello, World!\")\n\n        if __name__ == \"__main__\":\n            main()\n        ```" >> README.md
    echo "" >> README.md
    echo "2. **Example test**:" >> README.md
    echo "    - Create a new test file in the `tests` directory:" >> README.md
    echo "        ```sh\n        touch tests/test_example.py\n        ```" >> README.md
    echo "    - Add the following content to the test file:" >> README.md
    echo "        ```python\n        def test_example():\n            assert 1 + 1 == 2\n        ```" >> README.md
    echo "" >> README.md
    echo "3. **Example Jupyter notebook**:" >> README.md
    echo "    - Create a new Jupyter notebook in the `notebook` directory:" >> README.md
    echo "        ```sh\n        touch notebook/example_notebook.ipynb\n        ```" >> README.md
    echo "    - Add the following content to the notebook:" >> README.md
    echo "        ```markdown\n        # Example Jupyter Notebook\n\n        This is an example Jupyter notebook to demonstrate the usage of the `notebook` directory in the default Python project structure template.\n\n        ## Data Generation\n\n        Let's generate some example data to work with.\n\n        ```python\n        import numpy as np\n        import pandas as pd\n        import matplotlib.pyplot as plt\n        %matplotlib inline\n\n        # Generate example data\n        data = {\n            'A': np.random.randn(100),\n            'B': np.random.randn(100) * 2,\n            'C': np.random.randn(100) + 1\n        }\n        df = pd.DataFrame(data)\n        df.head()\n        ```\n\n        ## Data Visualization\n\n        Now, let's create some visualizations to analyze the data.\n\n        ```python\n        # Plot histograms of the data\n        df.hist(figsize=(10, 8))\n        plt.show()\n        ```\n\n        ```python\n        # Plot scatter matrix\n        pd.plotting.scatter_matrix(df, figsize=(12, 10))\n        plt.show()\n        ```\n        ```" >> README.md
    echo "" >> README.md
    echo "## Enhancing Documentation" >> README.md
    echo "" >> README.md
    echo "To ensure that the Sphinx documentation in the `docs` directory is comprehensive and up-to-date, follow these steps:" >> README.md
    echo "" >> README.md
    echo "1. **Update `index.rst`**:" >> README.md
    echo "    - Ensure that the `index.rst` file includes all necessary sections and references." >> README.md
    echo "" >> README.md
    echo "2. **Add new sections**:" >> README.md
    echo "    - Add new sections to the documentation as needed, such as `architecture`, `design_decisions`, `how_to_test_it`, and `how_to_use_it`." >> README.md
    echo "" >> README.md
    echo "3. **Generate HTML documentation**:" >> README.md
    echo "    - Navigate to the `docs` directory and run the following command to generate the HTML documentation:" >> README.md
    echo "        ```sh\n        make html\n        ```" >> README.md
    echo "" >> README.md
    echo "4. **Review and update**:" >> README.md
    echo "    - Regularly review and update the documentation to ensure it remains accurate and comprehensive." >> README.md
    echo "" >> README.md
    echo "By following these steps, you can enhance the documentation and provide more detailed instructions and examples for setting up and using the project." >> README.md

    touch requirements.txt
    echo "# {{ project_name }} dependencies" > requirements.txt
    echo "" >> requirements.txt
    echo "# Add your project-specific dependencies here" >> requirements.txt
    echo "# Example:" >> requirements.txt
    echo "# numpy==1.21.2" >> requirements.txt
    echo "# pandas==1.3.3" >> requirements.txt
    echo "# matplotlib==3.4.3" >> requirements.txt

    touch .env.example

    # Add a default LICENSE file (MIT License)
    cat <<EOF > LICENSE
MIT License

Copyright (c) {{ year }} {{ author }}

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

# Function to process template files and replace placeholders
process_template_files() {
    project_name=$1
    author_name=$(git config user.name)
    current_year=$(date +%Y)

    # Replace placeholders in README.md
    sed -i "s/{{ project_name }}/$project_name/g" "$project_name/README.md"
    sed -i "s/{{ github_username }}/$(git config user.username)/g" "$project_name/README.md"

    # Replace placeholders in LICENSE
    sed -i "s/{{ year }}/$current_year/g" "$project_name/LICENSE"
    sed -i "s/{{ author }}/$author_name/g" "$project_name/LICENSE"

    # Replace placeholders in requirements.txt
    sed -i "s/{{ project_name }}/$project_name/g" "$project_name/requirements.txt"
}

# Function to remove old files
remove_old_files() {
    rm -rf notebook/example_notebook.ipynb
    rm -rf tests/test_example.py
}

# Function to test the repository from scratch
test_repository_from_scratch() {
    # Run the CI pipeline
    .github/workflows/ci.yml
}

# Create project structure
create_project_structure "$ENV_NAME"

# Initialize Sphinx documentation
initialize_sphinx

# Process template files and replace placeholders
process_template_files "$ENV_NAME"

# Remove old files
remove_old_files

# Test the repository from scratch
test_repository_from_scratch

# Install dependencies from requirements.txt
pip install -r requirements.txt

echo "Project structure created, tools installed, and git repository initialized in the conda environment '$ENV_NAME'."
