# Release Workflow

## Overview

This document defines the standardized release process for production-ready projects.

## Version Numbering

### Semantic Versioning (SemVer)

```
MAJOR.MINOR.PATCH
  │     │     │
  │     │     └── PATCH: Bug fixes, no API changes
  │     └──────── MINOR: New features, backward compatible
  └────────────── MAJOR: Breaking changes
```

### Pre-release Versions

```
v1.0.0-alpha      # Alpha release (early testing)
v1.0.0-beta       # Beta release (feature complete)
v1.0.0-rc.1       # Release candidate
v1.0.0            # Stable release
```

## Git Flow

### Branch Strategy

```
main (production)
  └── develop (integration)
       ├── feature/xxx
       ├── feature/yyy
       └── bugfix/zzz
```

### Branch Naming

| Branch Type | Pattern | Example |
|-------------|---------|---------|
| Feature | `feature/{description}` | `feature/user-authentication` |
| Bugfix | `bugfix/{description}` | `bugfix/fix-login-error` |
| Hotfix | `hotfix/{description}` | `hotfix/security-patch` |
| Release | `release/v{version}` | `release/v1.0.0` |

### Workflow

```
1. Create feature branch
   git checkout -b feature/my-feature

2. Development (SDD/TDD)
   - Write SPEC.md
   - Write tests first
   - Implement
   - Refactor

3. Commit changes
   git add .
   git commit -m "feat: add new feature"

4. Push to remote
   git push origin feature/my-feature

5. Create Pull Request
   - Target: develop branch
   - Fill PR template
   - Request reviews

6. After approval, merge
   git checkout develop
   git merge --no-ff feature/my-feature
   git push origin develop

7. Delete feature branch
   git branch -d feature/my-feature
   git push origin --delete feature/my-feature
```

## Commit Convention

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

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
| `revert` | Revert previous commit |

### Examples

```bash
# Feature
git commit -m "feat(auth): add OAuth2 login support

- Implement Google OAuth2 flow
- Add login/logout handlers
- Update user model with provider field"

# Bugfix
git commit -m "fix(api): handle null response in getUser

The getUser endpoint was throwing an error when
user data was not found in cache."

# Breaking change
git commit -m "feat!: change authentication API

BREAKING CHANGE: Old /api/login endpoint replaced with
/api/auth/login. Update client applications."
```

## Release Process

### Pre-Release Checklist

```markdown
## Release Checklist: v{version}

### Quality
- [ ] All tests passing (X/X)
- [ ] Coverage ≥ 85%
- [ ] Lint passing
- [ ] Type check passing
- [ ] No critical bugs

### Documentation
- [ ] SPEC.md updated
- [ ] README.md updated
- [ ] CHANGELOG.md updated
- [ ] API docs updated (if applicable)
- [ ] Examples verified

### Repository
- [ ] All PRs merged to develop
- [ ] develop branch up to date with main
- [ ] No pending changes

### Communication
- [ ] Release notes prepared
- [ ] Team notified
- [ ] Documentation published
```

### Release Steps

#### 1. Update Development

```bash
# Ensure develop is ready
git checkout develop
git pull origin develop

# Run final checks
./scripts/run_ci_checks.sh
```

#### 2. Update CHANGELOG

```markdown
## [v{version}] - {YYYY-MM-DD}

### Added
- New feature A
- New feature B

### Changed
- Improved performance of X
- Updated documentation

### Fixed
- Bug in module Y

### Breaking
- Removed deprecated API Z
```

#### 3. Create Release Branch

```bash
# Create release branch
git checkout -b release/v{version}

# Bump version in config files
# pyproject.toml, package.json, etc.

# Commit version bump
git add .
git commit -m "chore: bump version to v{version}"
```

#### 4. Merge to Main

```bash
# Switch to main
git checkout main

# Merge release (no fast-forward)
git merge --no-ff release/v{version}

# Tag the release
git tag -a v{version} -m "Release v{version}

Features:
- New feature A
- New feature B

Bug Fixes:
- Fixed bug in module Y

Breaking Changes:
- Removed deprecated API Z"

# Push to remote
git push origin main
git push origin v{version}
```

#### 5. Merge Back to Develop

```bash
# Switch to develop
git checkout develop

# Merge release
git merge --no-ff release/v{version}

# Push
git push origin develop

# Delete release branch
git branch -d release/v{version}
git push origin --delete release/v{version}
```

#### 6. Create GitHub Release

1. Go to: `https://github.com/{owner}/{repo}/releases/new`
2. Select tag: `v{version}`
3. Title: `{Project Name} v{version}`
4. Description: Use CHANGELOG content
5. Check ✅ **Set as pre-release** (if applicable)
6. Click **Publish release**

### GitHub Release Template

```markdown
## What's Changed

### ✨ New Features
- Feature A description
- Feature B description

### 🐛 Bug Fixes
- Fixed X
- Fixed Y

### 💥 Breaking Changes
- Change Z description

### 🔧 Maintenance
- Dependency updates
- Documentation improvements

---

**Full Changelog**: https://github.com/{owner}/{repo}/compare/v{prev}...v{version}

**Downloads**:
- Source code (zip)
- Source code (tar.gz)
```

## Post-Release

### 1. Verify CI on Tag

```bash
# Check CI status
git fetch --tags
git checkout v{version}
./scripts/run_ci_checks.sh
```

### 2. Monitor for Issues

- Watch CI/CD pipelines
- Monitor error reporting tools
- Check support channels for issues

### 3. Announce

```markdown
## Release Announcement

🚀 {Project} v{version} is now available!

[Highlights and key changes]

[Link to release notes]

[Link to documentation]
```

## Hotfix Process

### For Critical Bugs

```bash
# Create hotfix branch from main
git checkout -b hotfix/v{version} main

# Fix the issue
# Write test
# Implement fix

# Commit with fix type
git commit -m "fix: resolve critical issue"

# Create PR to main
# After approval, merge to main

# Tag the hotfix
git checkout main
git merge --no-ff hotfix/v{version}
git tag -a v{version} -m "Hotfix v{version}"

# Merge to develop
git checkout develop
git merge --no-ff hotfix/v{version}

# Cleanup
git branch -d hotfix/v{version}
```

## Rollback Procedure

### If Critical Issue Found Post-Release

```bash
# Revert to previous version
git checkout v{previous-version}

# Or revert the merge commit
git revert -m 1 {merge-commit-sha}

# Push the revert
git push origin main

# Create hotfix for the fix
```

## Version References

| Reference | File |
|-----------|------|
| Current version | `pyproject.toml`, `package.json` |
| Version history | `CHANGELOG.md` |
| Release notes | GitHub Releases |
| Migration guide | `docs/migration/` |
