# Contributing Guide

Thank you for your interest in contributing to this project!

## Development Workflow

### 1. Fork and Clone

```bash
# Fork the repository on GitHub

# Clone your fork
git clone https://github.com/{your-username}/{repo}.git
cd {repo}

# Add upstream remote
git remote add upstream https://github.com/{owner}/{repo}.git
```

### 2. Create a Feature Branch

```bash
# Sync with upstream
git fetch upstream
git checkout main
git merge upstream/main

# Create feature branch
git checkout -b feature/your-feature-name
```

### 3. Development (SDD/TDD)

Follow the Specification-Driven and Test-Driven development workflow:

```bash
# 1. Read SPEC.md for requirements
cat SPEC.md

# 2. Write tests first (RED)
# Create test in tests/unit/ or tests/integration/

# 3. Implement (GREEN)
# Write minimal code to pass tests

# 4. Refactor
# Improve code while keeping tests green

# 5. Verify
pytest  # All tests pass
./scripts/run_ci_checks.sh  # All checks pass
```

### 4. Commit Your Changes

Follow the Angular commit format:

```bash
# Format
git commit -m "<type>(<scope>): <subject>

<body>

<footer>"

# Examples

# Feature
git commit -m "feat(auth): add OAuth2 login support

- Implement Google OAuth2 flow
- Add login/logout handlers
- Update user model with provider field"

# Bugfix
git commit -m "fix(api): handle null response in getUser

The getUser endpoint was throwing an error when user
was not found in cache."

# Documentation
git commit -m "docs: update README with installation instructions"

# Refactor
git commit -m "refactor(core): extract validation logic

Move validation to separate module for reusability"
```

**Commit Types:**

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no code change |
| `refactor` | Code restructuring |
| `test` | Adding/updating tests |
| `chore` | Maintenance, dependencies |
| `perf` | Performance improvement |
| `ci` | CI/CD changes |

### 5. Push and Create Pull Request

```bash
# Push to your fork
git push origin feature/your-feature-name

# Create PR on GitHub
# Target: main or develop branch
```

## Pull Request Checklist

Before submitting a PR, ensure:

- [ ] Tests written and passing
- [ ] Coverage ≥ 85%
- [ ] Code formatted (black/prettier)
- [ ] Imports sorted (isort)
- [ ] Lint passing (flake8/eslint)
- [ ] Type check passing (mypy/tsc)
- [ ] SPEC.md updated (if applicable)
- [ ] Documentation updated (if applicable)
- [ ] CHANGELOG.md updated (if applicable)
- [ ] Commit messages follow convention

## Quality Standards

### Code Quality

| Metric | Target |
|--------|--------|
| Test Coverage | ≥ 85% |
| Lint | 0 errors |
| Type Check | Pass |

### Running Quality Checks

```bash
# Full local CI
./scripts/run_ci_checks.sh

# Individual checks
pytest --cov=src --cov-report=term-missing
black --check src tests/
isort --check src tests/
flake8 src tests/
mypy src
```

## Reporting Issues

### Bug Reports

Include:
- Description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Environment (OS, Python/Node version, etc.)
- Error messages or logs

### Feature Requests

Include:
- Clear description of the feature
- Use case (why do you need it?)
- Proposed solution (optional)
- Alternatives considered (optional)

## Code Style

### Python

- Follow PEP 8
- Use type hints
- Write docstrings for public APIs
- Format with black (line-length: 100)
- Sort imports with isort

### JavaScript

- Follow ESLint rules
- Use TypeScript for type safety
- Write JSDoc for public APIs
- Format with Prettier

## Testing Guidelines

### Unit Tests

- Test one thing per test function
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Test happy path AND edge cases

```python
# Python example
def test_calculate_total_with_valid_items():
    """Test total calculation with valid items."""
    # Arrange
    items = [{"price": 10}, {"price": 20}]
    
    # Act
    result = calculate_total(items)
    
    # Assert
    assert result == 30
```

```javascript
// JavaScript example
test('calculates total with valid items', () => {
    // Arrange
    const items = [{ price: 10 }, { price: 20 }];
    
    // Act
    const result = calculateTotal(items);
    
    // Assert
    expect(result).toBe(30);
});
```

### Integration Tests

- Test component interactions
- Use real or realistic mock data
- Verify data flow between components

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

- Open an issue for questions
- Check existing issues before creating new ones
- Be respectful and constructive in all interactions

---

**Thank you for contributing!**
