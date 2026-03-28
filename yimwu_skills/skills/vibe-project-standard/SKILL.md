---
name: vibe-project-standard
description: "Vibe Coding 项目规范化技能。指导从零构建生产级项目，包含 SDD/TDD 开发流程、CI/CD 配置、质量保证和发布流程。支持 Python 和 JavaScript/TypeScript。"
---

# Vibe Project Standard

## Overview

本技能指导 AI Agent 为 vibe coding 项目构建规范化、可维护的生产级代码库。通过标准化的开发流程和配置模板，确保项目从一开始就具备高质量基础。

## 支持的语言

- **Python** - 完整配置支持
- **JavaScript/TypeScript** - 完整配置支持
- **可扩展** - 轻松添加新语言支持

## Supported Languages

- **Python** - Full configuration support
- **JavaScript/TypeScript** - Full configuration support
- **Extensible** - Easy to add new language support

## Workflow

### Phase 1: Project Initialization

```
1. Detect Language
   ├── Python: Look for .py files, requirements.txt, pyproject.toml
   └── JavaScript: Look for .js/.ts files, package.json

2. Create Standard Directory Structure
   ├── src/           # Source code
   ├── tests/         # Test files
   ├── docs/          # Documentation
   ├── scripts/       # Build/utility scripts
   ├── examples/      # Example usage
   └── .github/workflows/  # CI/CD

3. Initialize Git Repository
   ├── git init
   ├── git branch -M main
   └── Create .gitignore

4. Generate Language-Specific Config
   ├── Load references/languages/{language}.md
   ├── Generate package manager config
   ├── Generate test framework config
   └── Generate lint/type check config
```

### Phase 2: Documentation (SDD)

```
1. Create SPEC.md
   └── Load references/docs/SPEC.md as template

2. Create README.md
   └── Load references/docs/README.md as template

3. Create CLAUDE.md
   └── Load references/docs/CLAUDE.md as template

4. Create CONTRIBUTING.md
   └── Load references/docs/CONTRIBUTING.md as template

5. Create LICENSE
   └── Default: MIT License

6. Create .env.example
   └── For environment variable documentation
```

### Phase 3: CI/CD Setup

```
1. GitHub Actions Workflow
   └── Load references/ci-template.md

2. Local CI Validation Script
   └── Create scripts/run_ci_checks.sh
```

### Phase 4: Development Iteration (TDD)

```
For each feature/module:

1. SPEC
   └── Review SPEC.md for requirements

2. RED - Write Test First
   ├── Write failing test
   └── Verify test fails

3. GREEN - Make it Pass
   ├── Write minimal implementation
   └── Verify test passes

4. REFACTOR
   ├── Improve code structure
   └── Ensure tests still pass
```

### Phase 5: Quality Assurance

```
Load references/quality-checklist.md

1. Code Style
   ├── Linting passed
   └── Formatting consistent

2. Type Safety
   ├── Type checks passed
   └── No type errors

3. Test Coverage
   └── Coverage ≥ 85%

4. Error Handling
   ├── No swallowed exceptions
   └── Proper error propagation

5. Performance
   ├── No N+1 queries
   └── No memory leaks
```

### Phase 6: Release

```
Load references/release-workflow.md

1. Pre-Release Checklist
   ├── All tests passing
   ├── Coverage ≥ 85%
   ├── Documentation updated
   └── CHANGELOG updated

2. Version Tagging
   ├── git tag -a v{version} -m "Release v{version}"
   └── git push origin v{version}

3. GitHub Release
   ├── Create release from tag
   └── Add release notes

4. Post-Release
   └── Update version in config
```

## Output Format

### Project Initialization Report

```markdown
## Project Initialization Complete

**Language**: {Python/JavaScript}
**Structure**: Standard layout applied
**Config Files**: Generated

### Created Files
- src/
- tests/
- docs/
- scripts/
- .github/workflows/ci.yml
- {language config files}

### Next Steps
1. Review SPEC.md and fill in requirements
2. Start development with TDD workflow
3. Run `./scripts/run_ci_checks.sh` locally
```

### Quality Check Report

```markdown
## Quality Check Report

| Check | Status |
|-------|--------|
| Lint | ✅/❌ |
| Type Check | ✅/❌ |
| Coverage | XX% |
| Tests | X/X passing |

### Issues Found
- (list if any)
```

### Release Checklist

```markdown
## Release Checklist

### Pre-Release
- [ ] All tests passing
- [ ] Coverage ≥ 85%
- [ ] CHANGELOG updated
- [ ] Documentation complete

### Release
- [ ] Create git tag
- [ ] Push to remote
- [ ] Create GitHub release

### Post-Release
- [ ] Verify CI passes on tag
- [ ] Update version in config
```

## References

### Core References
| File | Purpose |
|------|---------|
| `references/project-structure.md` | Standard directory layout |
| `references/sdd-tdd-workflow.md` | Development methodology |
| `references/quality-checklist.md` | Quality standards |
| `references/release-workflow.md` | Release process |
| `references/ci-template.md` | CI/CD configuration |

### Documentation Templates
| File | Purpose |
|------|---------|
| `references/docs/SPEC.md` | Specification template |
| `references/docs/README.md` | README template |
| `references/docs/CLAUDE.md` | AI developer guide |
| `references/docs/CONTRIBUTING.md` | Contribution guide |
| `references/docs/LICENSE` | MIT License template |
| `references/docs/.env.example` | Environment variables template |

### Language Configurations
| File | Purpose |
|------|---------|
| `references/languages/python.md` | Python: pyproject.toml, pytest, black, isort, flake8, mypy |
| `references/languages/javascript.md` | JavaScript/TypeScript: package.json, jest, eslint, prettier, tsc |

## Best Practices

1. **Always write tests first** - TDD ensures reliability
2. **Keep specs updated** - SPEC.md is the source of truth
3. **Run CI locally** - Catch issues before push
4. **Maintain coverage** - ≥85% is the minimum
5. **Document decisions** - Architecture decisions in docs/
6. **Version properly** - Semantic versioning for releases
