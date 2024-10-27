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
└── Dockerfile
```

## Installation Steps

1. **Create a new empty Github Codespace**:
    - Open your GitHub repository and click on the "Code" button.
    - Select "Open with Codespaces" and create a new codespace.

2. **Connect to the codespace through desktop VS Code or online**:
    - If using desktop VS Code, install the "GitHub Codespaces" extension.
    - Open the "Remote Explorer" view and connect to your codespace.
    - If using the online editor, simply open the codespace in your browser.

3. **Clone the repository**:
    ```sh
    git clone https://github.com/reuben-haug/default-python-project-structure.git
    cd default-python-project-structure
    ```

4. **Build the Docker container**:
    ```sh
    docker build -t default-python-project-structure .
    ```

5. **Run the Docker container**:
    ```sh
    docker run -it --rm -v $(pwd):/app default-python-project-structure
    ```

6. **Initialize the project structure**:
    - The `Dockerfile` will automatically create the project structure, including directories like `src`, `tests`, `docs`, `lib`, `data`, `scripts`, `config`, `bin`, `assets`, and `notebook`.
    - Essential files like `README.md`, `requirements.txt`, `.env.example`, `.gitignore`, and `LICENSE` will also be created.

7. **Install dependencies**:
    - The `postCreateCommand` in `.devcontainer/devcontainer.json` will install the required packages listed in `requirements.txt`.

8. **Set up Sphinx documentation**:
    - The `Dockerfile` will install Sphinx and initialize the documentation in the `docs` directory.
    - The `index.rst` file in the `docs` directory will be updated to include the necessary sections.

9. **Customize the template**:
    - Modify the `process_template_files` function in `project_template.sh` to replace placeholders with your project-specific details.
    - Update the `README.md` and `docs/overview.rst` files to reflect the specifics of your new project.

10. **Use Poetry for dependency management**:
    - Initialize a new Poetry environment:
        ```sh
        poetry init
        ```
    - Add dependencies using Poetry:
        ```sh
        poetry add <dependency>
        ```

11. **Set up version control**:
    - Initialize a new Git repository if not already done by the script:
        ```sh
        git init
        ```
    - Commit your changes:
        ```sh
        git add .
        git commit -m "Initial commit"
        ```

12. **Documentation**:
    - Use Sphinx to generate and maintain project documentation. The `docs` directory already contains the necessary files to get started.
    - Build the documentation:
        ```sh
        cd docs
        make html
        ```

13. **Testing**:
    - Write tests in the `tests` directory and use pytest to run them:
        ```sh
        pytest
        ```

14. **Linting and formatting**:
    - Use flake8 for linting:
        ```sh
        flake8 .
        ```
    - Use black for code formatting:
        ```sh
        black .
        ```

15. **Continuous integration**:
    - Set up a CI pipeline using GitHub Actions or another CI tool to automate testing and linting.

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

## Contributing

We welcome contributions to improve this template repository. To contribute, follow these steps:

1. **Fork the repository**:
    - Click the "Fork" button at the top right corner of this repository to create a copy of the repository in your GitHub account.

2. **Clone your forked repository**:
    ```sh
    git clone https://github.com/<your-username>/default-python-project-structure.git
    cd default-python-project-structure
    ```

3. **Create a new branch**:
    ```sh
    git checkout -b feature/your-feature-name
    ```

4. **Make your changes**:
    - Implement your changes and ensure that they follow the project's coding standards and guidelines.

5. **Test your changes**:
    - Run the tests to ensure that your changes do not introduce any issues.
    ```sh
    pytest
    ```

6. **Commit your changes**:
    ```sh
    git add .
    git commit -m "Add your commit message here"
    ```

7. **Push your changes to your forked repository**:
    ```sh
    git push origin feature/your-feature-name
    ```

8. **Create a pull request**:
    - Open your forked repository on GitHub and click the "New pull request" button.
    - Provide a clear and descriptive title and description for your pull request.
    - Submit the pull request for review.

9. **Review and feedback**:
    - Your pull request will be reviewed by the repository maintainers.
    - Address any feedback or requested changes.

10. **Merge**:
    - Once your pull request is approved, it will be merged into the main repository.

Thank you for contributing to this project!
