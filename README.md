# Default Python Project Structure Template

This repository is a template repository for Agile Python projects for personal portfolio projects. The template has a default folder structure with commonly used sub-directories such as `docs`, `notebook`, `src`, and `tests`. The template also includes a `.gitignore`, `README`, and `LICENSE` file with the MIT license.

## Folder Structure

The folder structure of the template is as follows:

```
default-python-project-structure/
│
├── docs/
│
├── notebook/
│
├── src/
│
├── tests/
│
├── .gitignore
├── LICENSE
├── README.md
├── requirements.txt
└── project_template.sh
```

## Installation Steps

1. **Clone the repository**:
    ```sh
    git clone https://github.com/reuben-haug/default-python-project-structure.git
    cd default-python-project-structure
    ```

2. **Enable write permissions for the `project_template.sh` script**:
    ```sh
    sudo chmod +x project_template.sh
    ```

3. **Run the `project_template.sh` script**:
    ```sh
    ./project_template.sh
    ```

4. **Add the `$USER` to the 'docker' group**:
    ```sh
    sudo usermod -aG docker $USER
    ```

5. **Run the `newgrp docker` command to avoid logging out**:
    ```sh
    newgrp docker
    ```

## Requirements

The `requirements.txt` file includes the necessary packages with appropriate version numbers:
```
sphinx==4.2.0
pytest==6.2.5
flake8==3.9.2
mypy==0.910
tox==3.24.4
black==21.9b0
```

## Documentation

The `docs` directory contains Sphinx documentation for the project. The following files are included:
- `index.rst`: The main index file for the documentation.
- `overview.rst`: The project overview.
- `API.rst`: The API documentation.

## Troubleshooting

If you encounter any issues during the template installation, follow these steps:

1. **Remove deprecated linting settings**:
    - Remove the deprecated `python.linting.flake8Enabled` setting from your `.vscode/settings.json` and `.devcontainer/devcontainer.json` files.
    - Install the `flake8` extension from the Visual Studio Code marketplace using the command:
        ```sh
        code --install-extension ms-python.flake8
        ```

2. **Ensure the directory exists**:
    - Verify that the directory `/workspaces/default-python-project-structure-1/.pixi/envs` exists or update your configuration to point to the correct directory.

3. **Verify Python interpreter path**:
    - Ensure that the Python interpreter path set in `.vscode/settings.json` and `.devcontainer/devcontainer.json` is correct and the interpreter is accessible.

4. **Install missing tools**:
    - Install `pyenv` and `poetry` if needed for managing Python versions and dependencies using the following commands:
        ```sh
        # Install pyenv
        curl https://pyenv.run | bash

        # Install poetry
        curl -sSL https://install.python-poetry.org | python3 -
        ```

5. **Verify environment paths**:
    - Ensure that the paths to your Python interpreter and virtual environments are correctly set up and accessible.

6. **Check Pylance language server**:
    - Ensure that the Pylance language server is starting correctly for Python IntelliSense.

7. **Verify Conda and Hatch tools**:
    - Ensure that `conda` and `hatch` tools are installed and configured if you are using them.

By addressing these points, you should be able to resolve the issues and have a smoother development experience in Visual Studio Code.
