# SDD/TDD Workflow

## SDD: Specification-Driven Development

### Overview

SDD emphasizes writing specifications **before** implementation. The specification document (SPEC.md) serves as the source of truth throughout the project lifecycle.

### Core Principles

1. **Write specs first** - Never write code without a clear specification
2. **Single source of truth** - SPEC.md is the reference for all implementation decisions
3. **Review before coding** - Get alignment on specifications before starting
4. **Keep specs updated** - Update SPEC.md when requirements change

### SDD Workflow

```
┌─────────────────────────────────────────────────────────────┐
│  1. Requirements Gathering                                  │
│     └── Understand user needs and system constraints        │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  2. Write SPEC.md                                            │
│     ├── Feature description                                 │
│     ├── Functionality specification                          │
│     ├── Acceptance criteria                                 │
│     └── API design (if applicable)                          │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  3. Review SPEC                                              │
│     ├── Team review                                         │
│     ├── Resolve ambiguities                                 │
│     └── Get approval                                        │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  4. Implementation (TDD)                                    │
│     └── Red → Green → Refactor                              │
└─────────────────────────────────────────────────────────────┘
                           ↓
┌─────────────────────────────────────────────────────────────┐
│  5. Verify Against SPEC                                     │
│     └── All acceptance criteria met?                        │
└─────────────────────────────────────────────────────────────┘
```

## TDD: Test-Driven Development

### Overview

TDD is a development technique where tests are written **before** the code they test. The cycle is: Red (failing test) → Green (make it pass) → Refactor.

### Core Principles

1. **Write failing test first** - The test defines expected behavior
2. **Minimal implementation** - Write only enough code to pass
3. **Refactor continuously** - Improve code structure after tests pass
4. **Never break existing tests** - All tests must pass at all times

### TDD Cycle

```
    ┌──────────────────────────────────────┐
    │           RED                         │
    │  Write a failing test                 │
    │  Define expected behavior             │
    └──────────────────────────────────────┘
                    ↓
    ┌──────────────────────────────────────┐
    │           GREEN                       │
    │  Write minimal code                   │
    │  Make test pass                       │
    │  No over-engineering                   │
    └──────────────────────────────────────┘
                    ↓
    ┌──────────────────────────────────────┐
    │         REFACTOR                      │
    │  Improve code structure                │
    │  Maintain functionality                │
    │  Keep tests green                      │
    └──────────────────────────────────────┘
                    ↓
                    ↓ ← ← ← ← ← ← ← ← ←
                    (Repeat for next feature)
```

### TDD Rules

1. **Red** - You can't write any production code until you have a failing test
2. **Green** - You can't write any more of a test than sufficient to fail; stop coding once it passes
3. **Refactor** - You can refactor to improve structure, but tests must remain green

### Test Structure

#### Python (pytest)

```python
"""
Unit tests for {module_name}.

Follows TDD approach - tests written before implementation.
"""

import pytest
from myproject import MyClass


class TestMyClass:
    """Test MyClass functionality"""

    def test_creation(self):
        """Test class instantiation."""
        instance = MyClass()
        assert instance is not None

    def test_basic_operation_success(self):
        """Test basic operation with valid input."""
        instance = MyClass()
        result = instance.do_something("valid_input")
        assert result == expected_value

    def test_basic_operation_with_none(self):
        """Test handling of None input."""
        instance = MyClass()
        with pytest.raises(ValueError, match="Input cannot be None"):
            instance.do_something(None)

    def test_basic_operation_with_empty_string(self):
        """Test handling of empty string."""
        instance = MyClass()
        result = instance.do_something("")
        assert result == ""  # or appropriate assertion
```

#### JavaScript (Jest)

```javascript
/**
 * Unit tests for {module_name}.
 * Follows TDD approach - tests written before implementation.
 */

const { MyClass } = require('./myClass');

describe('MyClass', () => {
    let instance;

    beforeEach(() => {
        instance = new MyClass();
    });

    describe('creation', () => {
        it('should instantiate correctly', () => {
            expect(instance).toBeDefined();
        });
    });

    describe('doSomething', () => {
        it('should return expected value for valid input', () => {
            const result = instance.doSomething('validInput');
            expect(result).toBe(expectedValue);
        });

        it('should throw error for null input', () => {
            expect(() => instance.doSomething(null)).toThrow('Input cannot be null');
        });

        it('should handle empty string', () => {
            const result = instance.doSomething('');
            expect(result).toBe('');
        });
    });
});
```

### Test Categories

| Category | Purpose | Location |
|----------|---------|----------|
| **Unit Tests** | Test individual functions/methods | `tests/unit/` |
| **Integration Tests** | Test component interactions | `tests/integration/` |
| **E2E Tests** | Test complete user flows | `tests/e2e/` |

### Coverage Requirements

| Metric | Minimum | Target |
|--------|---------|--------|
| Line Coverage | 85% | 90%+ |
| Branch Coverage | 80% | 85%+ |
| Function Coverage | 100% | 100% |

### When to Add Tests

✅ **Add tests for:**
- Every public function/method
- Edge cases and boundary conditions
- Error handling paths
- Business logic
- Integration points

❌ **Skip tests for:**
- Trivial getters/setters
- Auto-generated code
- Private implementation details (unit tests)
- Configuration files

## Combined SDD-TDD Workflow

### Feature Development Flow

```
1. READ SPEC.md
   └── Review requirements for the feature

2. WRITE SPEC ADDITION (if new feature)
   └── Document expected behavior

3. WRITE TEST (RED)
   └── Define expected behavior as test

4. IMPLEMENT (GREEN)
   └── Write minimal code to pass test

5. REFACTOR
   └── Improve code structure

6. VERIFY
   └── All tests pass
   └── Coverage ≥ 85%

7. UPDATE SPEC (if needed)
   └── Document any changes

8. REPEAT
   └── Next feature
```

### Daily Development Routine

```
Morning:
├── Review SPEC.md
├── Pull latest changes
└── Plan today's tasks

During Development:
├── Pick a task
├── Write/update test (RED)
├── Implement (GREEN)
├── Refactor
└── Run tests locally

End of Day:
├── Run full test suite
├── Update SPEC.md if needed
├── Commit changes
└── Push to remote
```

### Best Practices

1. **Small, incremental changes** - One feature at a time
2. **Frequent commits** - Commit at each green phase
3. **Never skip the test** - Every feature needs tests
4. **Refactor with confidence** - Tests protect you
5. **Keep tests fast** - Slow tests = skipped tests
6. **Descriptive test names** - Explain what and why
7. **AAA pattern** - Arrange, Act, Assert
