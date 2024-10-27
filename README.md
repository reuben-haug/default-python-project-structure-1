# Default Python Project Structure Template

This repository is a template for Agile Python projects, designed for personal portfolio projects. The template provides a default folder structure with commonly used sub-directories and includes essential files such as `.gitignore`, `README`, and `LICENSE` with the MIT license. The template is platform-agnostic but primarily focused on GitHub Codespaces and VS Code integration.

## How to Use This Template

1. Clone the repository:
    ```sh
    git clone https://github.com/reuben-haug/default-python-project-structure.git
    ```

2. Navigate to the project directory:
    ```sh
    cd default-python-project-structure
    ```

3. Enable write permissions for the 'project_template.sh' script:
    ```sh
    sudo chmod +x project_template.sh
    ```

4. Run the 'project_template.sh' script to set up the project structure and environment:
    ```sh
    ./project_template.sh
    ```

5. Create a new virtual environment and activate it:
    ```sh
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

6. Install the required dependencies:
    ```sh
    pip install -r requirements.txt
    ```

7. Start working on your project by adding your code to the appropriate directories.

## Default Folder Structure

The template provides the following folder structure:

```
default-python-project-structure/
│
├── .vscode/             # VS Code configuration files
│
├── data/                # Directory for datasets
│
├── docs/                # Directory for project documentation
│
├── notebook/            # Directory for Jupyter notebooks
│
├── src/                 # Directory for source code
│   └── __init__.py      # Empty file to mark the directory as a Python package
│
├── tests/               # Directory for test files
│   └── test_example.py  # Example test file using pytest
│
├── .gitignore           # Git ignore file
├── LICENSE              # MIT License file
├── README.md            # Project README file
└── requirements.txt     # File for listing project dependencies
```

## Example Usage

### Data Science Project

- Utilize the `notebook` directory for Jupyter notebooks to perform data analysis and visualization.
- Store datasets in the `data` directory.
- Use the `src` directory for data processing scripts and machine learning models.
- Document your project in the `docs` directory using Sphinx.
- Write tests for your data processing and machine learning code in the `tests` directory.
