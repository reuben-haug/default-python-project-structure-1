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
└── .devcontainer/
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

4. **Initialize the project structure**:
    - The `.devcontainer/Dockerfile` will automatically create the project structure, including directories like `src`, `tests`, `docs`, `lib`, `data`, `scripts`, `config`, `bin`, `assets`, and `notebook`.
    - Essential files like `README.md`, `requirements.txt`, `.env.example`, `.gitignore`, and `LICENSE` will also be created.

5. **Install dependencies**:
    - The `postCreateCommand` in `.devcontainer/devcontainer.json` will install the required packages listed in `requirements.txt`.

6. **Set up Sphinx documentation**:
    - The `.devcontainer/Dockerfile` will install Sphinx and initialize the documentation in the `docs` directory.
    - The `index.rst` file in the `docs` directory will be updated to include the necessary sections.

7. **Customize the template**:
    - Modify the `process_template_files` function in `project_template.sh` to replace placeholders with your project-specific details.
    - Update the `README.md` and `docs/overview.rst` files to reflect the specifics of your new project.

8. **Use Poetry for dependency management**:
    - Initialize a new Poetry environment:
        ```sh
        poetry init
        ```
    - Add dependencies using Poetry:
        ```sh
        poetry add <dependency>
        ```

9. **Set up version control**:
    - Initialize a new Git repository if not already done by the script:
        ```sh
        git init
        ```
    - Commit your changes:
        ```sh
        git add .
        git commit -m "Initial commit"
        ```

10. **Documentation**:
    - Use Sphinx to generate and maintain project documentation. The `docs` directory already contains the necessary files to get started.
    - Build the documentation:
        ```sh
        cd docs
        make html
        ```

11. **Testing**:
    - Write tests in the `tests` directory and use pytest to run them:
        ```sh
        pytest
        ```

12. **Linting and formatting**:
    - Use flake8 for linting:
        ```sh
        flake8 .
        ```
    - Use black for code formatting:
        ```sh
        black .
        ```

13. **Continuous integration**:
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

## Detailed Instructions and Examples

### Setting Up the Project

1. **Clone the repository**:
    ```sh
    git clone https://github.com/reuben-haug/default-python-project-structure.git
    cd default-python-project-structure
    ```

2. **Create a virtual environment**:
    ```sh
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. **Install dependencies**:
    ```sh
    pip install -r requirements.txt
    ```

4. **Initialize the project structure**:
    - The `project_template.sh` script will automatically create the project structure, including directories like `src`, `tests`, `docs`, `lib`, `data`, `scripts`, `config`, `bin`, `assets`, and `notebook`.
    - Essential files like `README.md`, `requirements.txt`, `.env.example`, `.gitignore`, and `LICENSE` will also be created.

### Using the Project

1. **Running the application**:
    - Navigate to the `src` directory and run the main application file:
        ```sh
        cd src
        python main.py
        ```

2. **Running tests**:
    - Navigate to the `tests` directory and run the tests using pytest:
        ```sh
        cd tests
        pytest
        ```

3. **Building the documentation**:
    - Navigate to the `docs` directory and build the documentation using Sphinx:
        ```sh
        cd docs
        make html
        ```

### Examples

1. **Example script**:
    - Create a new script in the `scripts` directory:
        ```sh
        touch scripts/example_script.py
        ```
    - Add the following content to the script:
        ```python
        def main():
            print("Hello, World!")

        if __name__ == "__main__":
            main()
        ```

2. **Example test**:
    - Create a new test file in the `tests` directory:
        ```sh
        touch tests/test_example.py
        ```
    - Add the following content to the test file:
        ```python
        def test_example():
            assert 1 + 1 == 2
        ```

3. **Example Jupyter notebook**:
    - Create a new Jupyter notebook in the `notebook` directory:
        ```sh
        touch notebook/example_notebook.ipynb
        ```
    - Add the following content to the notebook:
        ```markdown
        # Example Jupyter Notebook

        This is an example Jupyter notebook to demonstrate the usage of the `notebook` directory in the default Python project structure template.

        ## Data Generation

        Let's generate some example data to work with.

        ```python
        import numpy as np
        import pandas as pd
        import matplotlib.pyplot as plt
        %matplotlib inline

        # Generate example data
        data = {
            'A': np.random.randn(100),
            'B': np.random.randn(100) * 2,
            'C': np.random.randn(100) + 1
        }
        df = pd.DataFrame(data)
        df.head()
        ```

        ## Data Visualization

        Now, let's create some visualizations to analyze the data.

        ```python
        # Plot histograms of the data
        df.hist(figsize=(10, 8))
        plt.show()
        ```

        ```python
        # Plot scatter matrix
        pd.plotting.scatter_matrix(df, figsize=(12, 10))
        plt.show()
        ```
        ```

## Enhancing Documentation

To ensure that the Sphinx documentation in the `docs` directory is comprehensive and up-to-date, follow these steps:

1. **Update `index.rst`**:
    - Ensure that the `index.rst` file includes all necessary sections and references.

2. **Add new sections**:
    - Add new sections to the documentation as needed, such as `architecture`, `design_decisions`, `how_to_test_it`, and `how_to_use_it`.

3. **Generate HTML documentation**:
    - Navigate to the `docs` directory and run the following command to generate the HTML documentation:
        ```sh
        make html
        ```

4. **Review and update**:
    - Regularly review and update the documentation to ensure it remains accurate and comprehensive.

By following these steps, you can enhance the documentation and provide more detailed instructions and examples for setting up and using the project.
