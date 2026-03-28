# Vibe Project Standard

A skill for AI agents to build production-ready projects with standardized structure, SDD/TDD workflow, CI/CD configuration, and quality assurance.

## Features

- **Standard Directory Structure** - Consistent project layout for any language
- **SDD/TDD Workflow** - Specification-driven and test-driven development
- **CI/CD Templates** - GitHub Actions + local validation scripts
- **Quality Standards** - Lint, type check, and coverage requirements
- **Release Process** - Standardized versioning and release workflow
- **Multi-Language Support** - Python and JavaScript/TypeScript

## Installation

```bash
# Using npx (for Claude Code)
npx skills add sanyuan0704/sanyuan-skills --path skills/vibe-project-standard

# Or clone and use locally
git clone https://github.com/yimwu/yimwu-skills.git
```

## Usage

```
/vibe-project-standard
```

The skill will guide you through:

1. **Project Initialization** - Detect language, create structure, generate configs
2. **Documentation** - Create SPEC.md, README.md, CLAUDE.md, CONTRIBUTING.md
3. **CI/CD Setup** - GitHub Actions workflow and local validation
4. **Development** - SDD/TDD workflow for features
5. **Quality Assurance** - Lint, type check, coverage
6. **Release** - Git tagging and GitHub Release

## Supported Languages

| Language | Status | Config Files |
|----------|--------|--------------|
| Python | ✅ Full | pyproject.toml, pytest, black, isort, flake8, mypy |
| JavaScript/TypeScript | ✅ Full | package.json, jest, eslint, prettier, TypeScript |

## Documentation Templates

| Template | Purpose |
|----------|---------|
| `references/docs/SPEC.md` | Project specification |
| `references/docs/README.md` | Project README |
| `references/docs/CLAUDE.md` | AI developer guide |
| `references/docs/CONTRIBUTING.md` | Contribution guidelines |
| `references/docs/LICENSE` | MIT License |
| `references/docs/.env.example` | Environment variables |

## Project Structure

```
my-project/
├── src/                    # Source code
├── tests/                  # Test files
├── docs/                   # Documentation
├── scripts/                # Build scripts
├── examples/               # Example usage
├── .github/workflows/      # CI/CD
├── .gitignore
├── LICENSE
├── SPEC.md                 # Specification
├── README.md
└── CLAUDE.md              # AI developer guide
```

## Workflow

### Development Cycle

```
SPEC → RED (write test) → GREEN (make pass) → REFACTOR → repeat
```

### Release Cycle

```
1. Update CHANGELOG
2. Run full quality check
3. Create git tag
4. Push to remote
5. Create GitHub release
```

## Quality Standards

| Metric | Target |
|--------|--------|
| Test Coverage | ≥ 85% |
| Lint | Pass |
| Type Check | Pass |

## Extending

To add support for a new language:

1. Create `references/languages/{language}.md`
2. Include:
   - Package manager config
   - Test framework config
   - Linter config
   - Type checker config
   - CI matrix versions

## License

MIT License - see [LICENSE](LICENSE)

## Based On

- SlotAgent v0.1.0-alpha development experience
- Industry best practices for SDD/TDD
- GitHub Actions CI/CD patterns
