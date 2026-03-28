# Quality Checklist

## Overview

This checklist ensures code quality meets production standards before release. All items must pass or be explicitly accepted.

## Pre-Merge Checklist

### Code Style

| Check | Description | Status |
|-------|-------------|--------|
| **Formatting** | Code follows project style guide | ☐ |
| **Imports Sorted** | Imports organized correctly | ☐ |
| **No Dead Code** | No commented-out code blocks | ☐ |
| **Naming Conventions** | Consistent naming throughout | ☐ |

### Linting

| Check | Description | Status |
|-------|-------------|--------|
| **Lint Pass** | All linter rules satisfied | ☐ |
| **No Warnings** | No linter warnings | ☐ |
| **No Errors** | No linter errors | ☐ |

#### Python Linters

```bash
# Black (formatting)
black --check src tests/

# isort (import sorting)
isort --check-only src tests/

# Flake8 (linting)
flake8 src tests/ --max-line-length=100 --extend-ignore=E203,E501

# Ruff (all-in-one)
ruff check src tests/
```

#### JavaScript Linters

```bash
# ESLint
eslint src tests/

# Prettier (formatting)
prettier --check "**/*.{js,jsx,ts,tsx,json,md}"
```

### Type Safety

| Check | Description | Status |
|-------|-------------|--------|
| **Type Check Pass** | No type errors | ☐ |
| **Types Exported** | Public APIs have types | ☐ |
| **No Implicit Any** | No implicit any types | ☐ |

#### Python Type Checkers

```bash
# MyPy
mypy src --ignore-missing-imports
```

#### JavaScript Type Checkers

```bash
# TypeScript
tsc --noEmit

# Flow (if using Flow)
flow check
```

### Testing

| Check | Description | Status |
|-------|-------------|--------|
| **All Tests Pass** | 100% of tests passing | ☐ |
| **Coverage ≥ 85%** | Line coverage meets minimum | ☐ |
| **New Features Tested** | New code has tests | ☐ |
| **No Skipped Tests** | All tests are active | ☐ |

#### Python Tests

```bash
# Run all tests
pytest -v

# Run with coverage
pytest --cov=src --cov-report=term-missing --cov-report=html

# Check coverage
coverage report --fail-under=85
```

#### JavaScript Tests

```bash
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Check coverage threshold
jest --coverage --coverageThreshold='{"global":{"lines":85}}'
```

### Error Handling

| Check | Description | Status |
|-------|-------------|--------|
| **No Swallowed Exceptions** | All exceptions handled properly | ☐ |
| **Error Messages** | Errors have meaningful messages | ☐ |
| **Async Errors** | Promises have catch handlers | ☐ |
| **Boundary Errors** | Edge cases handled | ☐ |

#### Common Error Patterns

**❌ Bad: Swallowed exceptions**
```python
# Python - BAD
try:
    do_something()
except:
    pass
```

**✅ Good: Proper error handling**
```python
# Python - GOOD
try:
    do_something()
except SpecificError as e:
    logger.error(f"Failed to do something: {e}")
    raise CustomError("Operation failed") from e
```

**❌ Bad: Missing catch handler**
```javascript
// JavaScript - BAD
fetch('/api/data')
    .then(response => response.json());
```

**✅ Good: Proper async error handling**
```javascript
// JavaScript - GOOD
try {
    const response = await fetch('/api/data');
    const data = await response.json();
} catch (error) {
    logger.error('Failed to fetch data:', error);
    throw new CustomError('Fetch failed');
}
```

### Performance

| Check | Description | Status |
|-------|-------------|--------|
| **No N+1 Queries** | No repeated queries in loops | ☐ |
| **No Memory Leaks** | Resources properly cleaned up | ☐ |
| **No Blocking I/O** | Async operations used correctly | ☐ |
| **No Expensive Ops in Hot Path** | Performance-critical code optimized | ☐ |

### Security

| Check | Description | Status |
|-------|-------------|--------|
| **No Hardcoded Secrets** | No API keys/passwords in code | ☐ |
| **Input Validation** | All inputs validated | ☐ |
| **SQL Injection Safe** | No string concatenation in queries | ☐ |
| **XSS Safe** | Output properly escaped | ☐ |

### Documentation

| Check | Description | Status |
|-------|-------------|--------|
| **Public APIs Documented** | Functions have docstrings/comments | ☐ |
| **README Updated** | Documentation reflects current state | ☐ |
| **Examples Work** | Example code is runnable | ☐ |
| **SPEC.md Updated** | Spec reflects implemented features | ☐ |

## Quality Gates

### Gate 1: Local Development

```bash
# Must pass before commit
./scripts/run_ci_checks.sh
```

### Gate 2: Pull Request

```bash
# CI must pass
- All tests passing
- Coverage ≥ 85%
- Lint passing
- Type check passing
```

### Gate 3: Pre-Release

```bash
# Final quality check
- All Gate 1 and 2 checks pass
- Documentation complete
- CHANGELOG updated
- No known critical bugs
```

## Quality Metrics

| Metric | Minimum | Good | Excellent |
|--------|---------|------|-----------|
| **Test Coverage** | 85% | 90% | 95%+ |
| **Code Review Approval** | 1 | 2 | 2+ |
| **Critical Bugs** | 0 | 0 | 0 |
| **High Bugs** | 0 | 0 | 0 |
| **Technical Debt** | < 5% | < 3% | < 1% |

## CI Quality Check Output

```markdown
## Quality Check Report

### Code Style
- [x] Formatting: PASS
- [x] Import sorting: PASS
- [x] Naming conventions: PASS

### Linting
- [x] ESLint/Flake8: PASS
- [x] No warnings: PASS

### Type Safety
- [x] Type check: PASS
- [x] No implicit any: PASS

### Testing
- [x] Tests: 45/45 passing
- [x] Coverage: 91.2%
- [x] All tests active: PASS

### Error Handling
- [x] Proper exception handling: PASS
- [x] Async error handling: PASS

### Performance
- [x] No N+1 queries: PASS
- [x] No memory leaks: PASS

### Security
- [x] No hardcoded secrets: PASS
- [x] Input validation: PASS

### Documentation
- [x] Public APIs documented: PASS
- [x] README updated: PASS

---
**Overall: ✅ PASS**
```

## Continuous Improvement

1. **Track quality metrics** over time
2. **Address technical debt** regularly
3. **Refactor legacy code** incrementally
4. **Update checklists** based on learnings
5. **Share best practices** across team
