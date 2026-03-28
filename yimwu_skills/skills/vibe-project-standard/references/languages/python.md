# Python Configuration

## Project Configuration

### pyproject.toml

```toml
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "{project_name}"
version = "0.1.0-alpha"
description = "{project_description}"
readme = "README.md"
license = {text = "MIT"}
authors = [{name = "{author_name}", email = "{author_email}"}]
requires-python = ">=3.8"
dependencies = []

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "pytest-cov>=4.1.0",
    "pytest-mock>=3.11.0",
    "pytest-asyncio>=0.21.0",
    "black>=23.7.0",
    "flake8>=6.1.0",
    "isort==5.13.2",
    "mypy>=1.5.0",
    "coverage>=7.3.0",
]

[tool.black]
line-length = 100
target-version = ['py38', 'py39', 'py310', 'py311', 'py312']
include = '\.pyi?$'
exclude = '''
/(
    \.git
    | \.eggs
    | \.hg
    | \.mypy_cache
    | \.tox
    | \.venv
    | _build
    | buck-out
    | build
    | dist
)/
'''

[tool.isort]
profile = "black"
line_length = 100
src_paths = ["src", "tests"]
known_first_party = ["{project_name}", "tests"]
skip_gitignore = true

[tool.pytest.ini_options]
minversion = "7.0"
testpaths = ["tests"]
addopts = [
    "-v",
    "--cov=src",
    "--cov-report=term-missing",
    "--cov-report=html",
    "--cov-fail-under=85",
    "--strict-markers",
    "--tb=short",
]
markers = [
    "slow: marks tests as slow (deselect with '-m \"not slow\"')",
    "integration: marks tests as integration tests",
    "unit: marks tests as unit tests",
]
asyncio_mode = "auto"

[tool.mypy]
python_version = "3.8"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = false
ignore_missing_imports = true
```

### requirements.txt

```
# Core dependencies (keep minimal)
```

### requirements-dev.txt

```
# Development dependencies
pytest>=7.4.0
pytest-cov>=4.1.0
pytest-mock>=3.11.0
pytest-asyncio>=0.21.0
black>=23.7.0
flake8>=6.1.0
isort==5.13.2
mypy>=1.5.0
coverage>=7.3.0
```

## Package Structure

### src/{project_name}/__init__.py

```python
"""
{Project Name} - {description}

Public API exports.
"""

__version__ = "0.1.0-alpha"

__all__ = [
    # Export public APIs here
]
```

### src/{project_name}/__main__.py

```python
"""
Entry point for running as a module: python -m {project_name}
"""

from {project_name}.core import main

if __name__ == "__main__":
    main()
```

## Test Configuration

### tests/__init__.py

```python
"""Test package."""
```

### tests/conftest.py

```python
"""
Global pytest configuration and fixtures.
"""

import pytest
import sys
from pathlib import Path

# Add src to path for imports
src_path = Path(__file__).parent.parent / "src"
sys.path.insert(0, str(src_path))


@pytest.fixture
def sample_data():
    """Provide sample data for tests."""
    return {"key": "value"}


@pytest.fixture
def mock_external_api(mocker):
    """Mock external API calls."""
    return mocker.patch("{project_name}.utils.external_api")
```

### tests/unit/__init__.py

```python
"""Unit tests package."""
```

### tests/integration/__init__.py

```python
"""Integration tests package."""
```

## Code Quality Tools

### Running Tools

```bash
# Format code
black src tests/

# Sort imports
isort src tests/

# Lint
flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501,W503

# Type check (optional)
mypy src --ignore-missing-imports

# Run tests
pytest -v

# Run with coverage
pytest --cov=src --cov-report=term-missing --cov-report=html
```

### Pre-commit Hook

### .pre-commit-config.yaml

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files

  - repo: https://github.com/psf/black
    rev: 23.7.0
    hooks:
      - id: black
        language_version: python3.11

  - repo: https://github.com/pycqa/isort
    rev: 5.13.2
    hooks:
      - id: isort
        args: ["--profile", "black"]

  - repo: https://github.com/pycqa/flake8
    rev: 6.1.0
    hooks:
      - id: flake8
        args: ["--max-line-length=100", "--extend-ignore=E203,E501,W503"]
```

## CI Configuration

### .github/workflows/ci.yml (Python)

```yaml
name: Python CI

on:
  push:
    branches: [ main, develop, feature/** ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    name: Python ${{ matrix.python-version }} Test
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
          cache: 'pip'

      - name: Install dependencies
        run: |
          pip install -e ".[dev]"

      - name: Run tests
        run: |
          pytest --cov=src --cov-report=xml tests/

      - name: Upload coverage
        uses: codecov/codecov-action@v4
        with:
          file: ./coverage.xml

  lint:
    name: Lint
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
          cache: 'pip'

      - name: Install dependencies
        run: |
          pip install black flake8 isort mypy

      - name: Black check
        run: black --check src tests/

      - name: isort check
        run: isort --check-only src tests/

      - name: Flake8 check
        run: flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501,W503

      - name: MyPy check
        run: mypy src --ignore-missing-imports || true
```

## Common Patterns

### Project Initialization

```bash
# Create project structure
mkdir -p src/{project_name}/{core,utils,plugins}
mkdir -p tests/{unit,integration,fixtures}
mkdir -p docs/{architecture,api,guides}
mkdir -p examples
mkdir -p scripts

# Initialize git
git init
git branch -M main

# Install in development mode
pip install -e ".[dev]"

# Verify installation
python -c "import {project_name}; print({project_name}.__version__)"
```

### Virtual Environment

```bash
# Create venv
python -m venv venv

# Activate (Unix/macOS)
source venv/bin/activate

# Activate (Windows)
venv\Scripts\activate

# Install dependencies
pip install -e ".[dev]"
```
