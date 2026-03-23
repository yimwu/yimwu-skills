# Project Structure

## Standard Directory Layout

```
project-name/
├── src/                          # Source code
│   ├── {project}/                # Main package/module
│   │   ├── __init__.py           # Package init (Python)
│   │   ├── __init__.js           # Package init (JS)
│   │   ├── core/                 # Core functionality
│   │   ├── utils/                # Utility functions
│   │   └── {feature}/            # Feature modules
│   └── index.js                  # Entry point (JS)
├── tests/                        # Test files
│   ├── unit/                     # Unit tests
│   ├── integration/              # Integration tests
│   ├── e2e/                      # End-to-end tests
│   └── fixtures/                 # Test fixtures
├── docs/                         # Documentation
│   ├── architecture/             # Architecture docs
│   ├── api/                      # API documentation
│   └── guides/                   # User guides
├── scripts/                       # Build/utility scripts
│   ├── build.sh                  # Build script
│   ├── test.sh                   # Test script
│   └── run_ci_checks.sh          # Local CI validation
├── examples/                      # Example usage
├── .github/
│   └── workflows/
│       └── ci.yml                # GitHub Actions workflow
├── .gitignore                     # Git ignore rules
├── LICENSE                        # MIT License
├── README.md                      # Project README
├── SPEC.md                        # Specification document
├── CLAUDE.md                      # AI developer guide
├── CONTRIBUTING.md                # Contribution guide
└── CHANGELOG.md                   # Version history

# Language-specific files
# Python
├── pyproject.toml                # Package configuration
├── setup.py                       # Setup script (compatibility)
├── requirements.txt              # Core dependencies
├── requirements-dev.txt          # Dev dependencies

# JavaScript
├── package.json                   # Package configuration
├── package-lock.json              # Locked dependencies
├── jsconfig.json                  # JS configuration
├── .eslintrc.js                   # ESLint config
├── .prettierrc                    # Prettier config
```

## .gitignore Template

### Python

```
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class
*.so

# C extensions
*.c
*.o
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# PyInstaller
*.manifest
*.spec

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Virtual environments
venv/
env/
ENV/
.venv

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Translations
*.mo
*.pot

# Jupyter Notebook
.ipynb_checkpoints

# pyenv
.python-version

# Environments
.env
.venv
env/
venv/
ENV/
env.bak/
venv.bak/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# CI
github-ci-log/
```

### JavaScript/Node.js

```
# Dependencies
node_modules/
jspm_packages/

# Build outputs
dist/
build/
out/
.next/
.nuxt/

# Test coverage
coverage/
.nyc_output/

# Logs
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*

# OS
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# Environment
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Lock files
package-lock.json
yarn.lock
pnpm-lock.yaml

# Runtime data
pids/
*.pid
*.seed
*.pid.lock

# TypeScript
*.tsbuildinfo

# Temporary
.cache/
.tmp/
```

### Combined (Recommended)

```
# ==========================================
# Common
# ==========================================
__pycache__/
*.py[cod]
*$py.class
*.so
.DS_Store
Thumbs.db

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
logs/

# Environments
.env
.env.local
.env.*.local

# ==========================================
# Python
# ==========================================
venv/
env/
ENV/
.venv
*.egg-info/
dist/
build/
*.egg

# Test
.pytest_cache/
.coverage
htmlcov/
.tox/
.coverage.*

# ==========================================
# JavaScript/Node.js
# ==========================================
node_modules/
dist/
build/
.next/
.nuxt/
coverage/
package-lock.json
yarn.lock
pnpm-lock.yaml

# ==========================================
# Git
# ==========================================
.git/
.github/
```

## Script Templates

### scripts/run_ci_checks.sh (Linux/macOS)

```bash
#!/bin/bash
set -e

echo "Running local CI validation..."

# Detect language
if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    echo "Detected: Python"
    LANG="python"
elif [ -f "package.json" ]; then
    echo "Detected: JavaScript/Node.js"
    LANG="javascript"
else
    echo "Unknown language, skipping language-specific checks"
    LANG="unknown"
fi

# Run checks based on language
case $LANG in
    python)
        echo "→ Running Python checks..."
        # Add Python-specific checks
        ;;
    javascript)
        echo "→ Running JavaScript checks..."
        # Add JS-specific checks
        ;;
esac

# Common checks
echo "→ Running common checks..."
# Add common checks

echo "✅ All checks passed!"
```

### scripts/run_ci_checks.ps1 (Windows)

```powershell
#!/usr/bin/env pwsh
$ErrorActionPreference = "Stop"

Write-Host "Running local CI validation..." -ForegroundColor Cyan

# Detect language
if (Test-Path "pyproject.toml" -or Test-Path "requirements.txt") {
    Write-Host "Detected: Python" -ForegroundColor Green
    $LANG = "python"
} elseif (Test-Path "package.json") {
    Write-Host "Detected: JavaScript/Node.js" -ForegroundColor Green
    $LANG = "javascript"
} else {
    Write-Host "Unknown language, skipping language-specific checks" -ForegroundColor Yellow
    $LANG = "unknown"
}

# Run checks based on language
switch ($LANG) {
    "python" {
        Write-Host "→ Running Python checks..." -ForegroundColor Yellow
        # Add Python-specific checks
    }
    "javascript" {
        Write-Host "→ Running JavaScript checks..." -ForegroundColor Yellow
        # Add JS-specific checks
    }
}

Write-Host "→ Running common checks..." -ForegroundColor Yellow

Write-Host "✅ All checks passed!" -ForegroundColor Green
```

## Initial Git Commit

```bash
git init
git branch -M main
git add .
git commit -m "chore: initial project structure

- Setup standard project layout
- Add CI/CD configuration
- Configure testing framework
- Add development guidelines (SDD/TDD)
- Add code quality tools

Co-authored-by: Claude <claude@anthropic.com>"
```
