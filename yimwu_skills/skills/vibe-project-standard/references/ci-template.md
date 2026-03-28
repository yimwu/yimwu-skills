# CI/CD Template

## GitHub Actions Workflow

### Python CI Template

```yaml
name: Python CI

on:
  push:
    branches: [ main, develop, feature/** ]
  pull_request:
    branches: [ main, develop ]

jobs:
  quality:
    name: Code Quality and Tests
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.8', '3.9', '3.10', '3.11', '3.12']

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
          cache: 'pip'

      - name: Cache isort
        uses: actions/cache@v4
        with:
          path: ~/.cache/pip
          key: ${{ runner.os }}-isort-${{ hashFiles('requirements*.txt') }}

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -e .
          pip install -r requirements-dev.txt

      - name: Code formatting check (Black)
        run: |
          black --check src tests/

      - name: Import sorting check (isort)
        run: |
          isort --check-only src tests/

      - name: Lint check (Flake8)
        run: |
          flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501

      - name: Type check (MyPy)
        run: |
          mypy src --ignore-missing-imports || true
        continue-on-error: true

      - name: Run tests with coverage
        run: |
          pytest --cov=src --cov-report=xml --cov-report=term-missing tests/

      - name: Check coverage threshold
        run: |
          coverage report --fail-under=85 || true
        continue-on-error: true

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v4
        with:
          file: ./coverage.xml
          fail_ci_if_error: false

  summary:
    name: Quality Summary
    runs-on: ubuntu-latest
    needs: quality
    if: always()
    steps:
      - name: Check quality results
        run: |
          result="${{ needs.quality.result }}"
          if [ "$result" == "success" ]; then
            echo "✅ All quality checks passed"
            exit 0
          elif [ "$result" == "cancelled" ]; then
            echo "❌ Quality checks were cancelled"
            exit 1
          else
            echo "⚠️  Quality job completed with some failures"
            echo "Note: MyPy type checking is optional"
            exit 0
          fi
```

### JavaScript CI Template

```yaml
name: JavaScript CI

on:
  push:
    branches: [ main, develop, feature/** ]
  pull_request:
    branches: [ main, develop ]

jobs:
  quality:
    name: Code Quality and Tests
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [18, 20, 21, 22]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run ESLint
        run: npm run lint

      - name: Run Prettier check
        run: npm run format:check

      - name: Run type check
        run: npm run typecheck

      - name: Run tests with coverage
        run: npm test -- --coverage

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v4
        with:
          file: ./coverage/lcov.info
          fail_ci_if_error: false

  summary:
    name: Quality Summary
    runs-on: ubuntu-latest
    needs: quality
    if: always()
    steps:
      - name: Check quality results
        run: |
          result="${{ needs.quality.result }}"
          if [ "$result" == "success" ]; then
            echo "✅ All quality checks passed"
            exit 0
          elif [ "$result" == "cancelled" ]; then
            echo "❌ Quality checks were cancelled"
            exit 1
          else
            echo "⚠️  Quality job completed with some failures"
            exit 0
          fi
```

### Combined Multi-Language CI

```yaml
name: CI

on:
  push:
    branches: [ main, develop, feature/** ]
  pull_request:
    branches: [ main, develop ]

jobs:
  detect-language:
    name: Detect Language
    runs-on: ubuntu-latest
    outputs:
      languages: ${{ steps.detect.outputs.languages }}
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Detect language
        id: detect
        run: |
          if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
            echo "languages=python" >> $GITHUB_OUTPUT
          elif [ -f "package.json" ]; then
            echo "languages=javascript" >> $GITHUB_OUTPUT
          else
            echo "languages=none" >> $GITHUB_OUTPUT
          fi

  python-ci:
    name: Python Quality
    runs-on: ubuntu-latest
    needs: detect-language
    if: needs.detect-language.outputs.languages == 'python'
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
          pip install -e .
          pip install -r requirements-dev.txt

      - name: Quality checks
        run: |
          black --check src tests/
          isort --check-only src tests/
          flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501
          mypy src --ignore-missing-imports || true
          pytest --cov=src tests/

  javascript-ci:
    name: JavaScript Quality
    runs-on: ubuntu-latest
    needs: detect-language
    if: needs.detect-language.outputs.languages == 'javascript'

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Quality checks
        run: |
          npm run lint
          npm run format:check
          npm run typecheck
          npm test -- --coverage
```

## Local CI Validation Script

### scripts/run_ci_checks.sh (Unix)

```bash
#!/bin/bash
set -e

echo "Running local CI validation..."
echo "================================"

# Detect language
if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    LANG="python"
    echo "Detected: Python"
elif [ -f "package.json" ]; then
    LANG="javascript"
    echo "Detected: JavaScript/Node.js"
else
    echo "⚠️  Unknown language"
    exit 1
fi

echo "================================"

case $LANG in
    python)
        echo "→ Running Python checks..."
        
        echo "  → Black formatting..."
        black --check src tests/ || { echo "❌ Black check failed"; exit 1; }
        
        echo "  → isort import sorting..."
        isort --check-only src tests/ || { echo "❌ isort check failed"; exit 1; }
        
        echo "  → Flake8 linting..."
        flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501 || { echo "❌ Flake8 check failed"; exit 1; }
        
        echo "  → MyPy type checking (optional)..."
        mypy src --ignore-missing-imports || true
        
        echo "  → Running tests..."
        pytest --cov=src --cov-report=term-missing tests/ || { echo "❌ Tests failed"; exit 1; }
        
        echo "  → Checking coverage..."
        coverage report --fail-under=85 || { echo "⚠️  Coverage below 85%"; exit 1; }
        ;;
        
    javascript)
        echo "→ Running JavaScript checks..."
        
        echo "  → ESLint..."
        npm run lint || { echo "❌ ESLint check failed"; exit 1; }
        
        echo "  → Prettier formatting..."
        npm run format:check || { echo "❌ Prettier check failed"; exit 1; }
        
        echo "  → TypeScript type checking..."
        npm run typecheck || { echo "❌ Type check failed"; exit 1; }
        
        echo "  → Running tests..."
        npm test -- --coverage || { echo "❌ Tests failed"; exit 1; }
        
        echo "  → Checking coverage..."
        # Jest coverage threshold check
        ;;
esac

echo "================================"
echo "✅ All checks passed!"
```

### scripts/run_ci_checks.ps1 (Windows)

```powershell
#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

Write-Host "Running local CI validation..." -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Detect language
if (Test-Path "pyproject.toml" -or Test-Path "requirements.txt") {
    $LANG = "python"
    Write-Host "Detected: Python" -ForegroundColor Green
} elseif (Test-Path "package.json") {
    $LANG = "javascript"
    Write-Host "Detected: JavaScript/Node.js" -ForegroundColor Green
} else {
    Write-Host "Unknown language" -ForegroundColor Red
    exit 1
}

Write-Host "================================" -ForegroundColor Cyan

switch ($LANG) {
    "python" {
        Write-Host "Running Python checks..." -ForegroundColor Yellow
        
        Write-Host "  → Black formatting..."
        black --check src tests/
        
        Write-Host "  → isort import sorting..."
        isort --check-only src tests/
        
        Write-Host "  → Flake8 linting..."
        flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501
        
        Write-Host "  → MyPy type checking..."
        mypy src --ignore-missing-imports
        
        Write-Host "  → Running tests..."
        pytest --cov=src --cov-report=term-missing tests/
        
        Write-Host "  → Checking coverage..."
        coverage report --fail-under=85
    }
    
    "javascript" {
        Write-Host "Running JavaScript checks..." -ForegroundColor Yellow
        
        Write-Host "  → ESLint..."
        npm run lint
        
        Write-Host "  → Prettier formatting..."
        npm run format:check
        
        Write-Host "  → TypeScript type checking..."
        npm run typecheck
        
        Write-Host "  → Running tests..."
        npm test -- --coverage
    }
}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "✅ All checks passed!" -ForegroundColor Green
```

## CI Best Practices

### 1. Caching Dependencies

```yaml
# Python
- uses: actions/setup-python@v5
  with:
    python-version: '3.11'
    cache: 'pip'

# JavaScript
- uses: actions/setup-node@v4
  with:
    node-version: '20'
    cache: 'npm'
```

### 2. Parallel Jobs

```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: npm test
```

### 3. Fail-Fast Strategy

```yaml
strategy:
  fail-fast: true  # Stop all jobs if one fails
  matrix:
    # ...

strategy:
  fail-fast: false  # Let all jobs complete
  matrix:
    # ...
```

### 4. Conditional Steps

```yaml
steps:
  - name: Upload coverage
    if: matrix.python-version == '3.12'  # Only on latest version
    uses: codecov/codecov-action@v4
```

## CI Status Badges

### Markdown

```markdown
[![CI](https://github.com/{owner}/{repo}/actions/workflows/ci.yml/badge.svg)](https://github.com/{owner}/{repo}/actions/workflows/ci.yml)
[![Coverage](https://codecov.io/gh/{owner}/{repo}/branch/main/graph/badge.svg)](https://codecov.io/gh/{owner}/{repo})
```

### Display

| Badge | Description |
|-------|-------------|
| ![CI](https://github.com/{owner}/{repo}/actions/workflows/ci.yml/badge.svg) | CI status |
| ![Coverage](https://codecov.io/gh/{owner}/{repo}/branch/main/graph/badge.svg) | Test coverage |
