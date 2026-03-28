# Project Guide for Claude Code

## Architecture Overview

This project follows a standard production-ready structure with emphasis on:
- **Specification-Driven Development (SDD)** - Write specs before code
- **Test-Driven Development (TDD)** - Write tests first, then implementation
- **Clean Architecture** - Separation of concerns

## Project Structure

```
src/                    # Source code
├── {project}/         # Main package
│   ├── __init__.py    # Package exports
│   ├── core/          # Core functionality
│   ├── utils/         # Utilities
│   └── {feature}/     # Feature modules
tests/                  # Test files
├── unit/              # Unit tests
├── integration/       # Integration tests
└── fixtures/         # Test fixtures
docs/                   # Documentation
├── architecture/      # Architecture docs
├── api/               # API docs
└── guides/            # User guides
```

## Development Workflow

### 1. Understanding Requirements

Before writing any code:
1. Read `SPEC.md` for project requirements
2. Check relevant feature specification
3. Understand acceptance criteria

### 2. Making Changes

Follow the SDD/TDD cycle:

```
1. READ SPEC.md
   └── Review requirements

2. WRITE TEST (RED)
   └── Define expected behavior
   └── Run: tests should FAIL

3. IMPLEMENT (GREEN)
   └── Write minimal code to pass test
   └── Run: tests should PASS

4. REFACTOR
   └── Improve code structure
   └── Ensure tests still pass

5. VERIFY
   └── Run full test suite
   └── Run quality checks
   └── Coverage ≥ 85%
```

### 3. Committing Changes

Use Angular commit format:

```bash
# Feature
git commit -m "feat(scope): add new feature"

# Bugfix
git commit -m "fix(scope): resolve issue"

# Documentation
git commit -m "docs(scope): update docs"

# Refactor
git commit -m "refactor(scope): improve code"

# Tests
git commit -m "test(scope): add tests"
```

## Quality Standards

### Code Quality

| Check | Tool | Command |
|-------|------|---------|
| Formatting | black (Python) / prettier (JS) | `black src tests/` |
| Import sorting | isort (Python) | `isort --check src tests/` |
| Linting | flake8 (Python) / eslint (JS) | `flake8 src tests/` |
| Type checking | mypy (Python) / tsc (JS) | `mypy src` |

### Test Coverage

- **Minimum**: 85% line coverage
- **Target**: 90%+ line coverage
- **Required**: All public APIs must be tested

### Running Quality Checks

```bash
# All checks
./scripts/run_ci_checks.sh

# Individual checks
pytest --cov=src --cov-report=term-missing
black --check src tests/
flake8 src tests/
mypy src
```

## Key Files

| File | Purpose |
|------|---------|
| `SPEC.md` | Project specification and requirements |
| `pyproject.toml` / `package.json` | Project configuration and dependencies |
| `tests/conftest.py` / `jest.config.js` | Test configuration |
| `.github/workflows/ci.yml` | CI/CD pipeline |

## Common Tasks

### Adding a New Feature

1. Update `SPEC.md` with feature specification
2. Write tests in `tests/unit/`
3. Implement in `src/{project}/`
4. Ensure coverage ≥ 85%
5. Update documentation

### Running Specific Tests

```bash
# Single test file
pytest tests/unit/test_module.py

# Single test
pytest tests/unit/test_module.py::TestClass::test_method

# Tests matching pattern
pytest -k "test_pattern"
```

### Debugging Failed Tests

```bash
# Show print statements
pytest -v -s

# Drop into debugger on failure
pytest --pdb

# Show local variables on failure
pytest -v -l
```

## Architecture Decisions

### Why This Structure?

1. **Separation of concerns** - Core logic isolated from I/O
2. **Testability** - Easy to mock dependencies
3. **Scalability** - Feature modules can grow independently
4. **Maintainability** - Clear ownership of code

### Key Patterns Used

- **Repository Pattern** - Data access abstraction
- **Service Layer** - Business logic encapsulation
- **Dependency Injection** - Loose coupling

## Important Notes

### DO

- ✅ Write tests before implementation
- ✅ Follow the commit convention
- ✅ Update SPEC.md when requirements change
- ✅ Run quality checks locally before pushing
- ✅ Maintain ≥ 85% coverage

### DON'T

- ❌ Commit code without tests
- ❌ Skip quality checks
- ❌ Leave TODO comments in code
- ❌ Hardcode secrets in code
- ❌ Break the build

## Getting Help

- **Issues**: Create a GitHub issue
- **Documentation**: Check `docs/` directory
- **Questions**: Review SPEC.md first

## References

- [Specification-Driven Development](references/sdd-tdd-workflow.md)
- [Quality Checklist](references/quality-checklist.md)
- [Release Workflow](references/release-workflow.md)
