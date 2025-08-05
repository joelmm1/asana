# Git Flow Strategy for Asana Project Management

## Branch Strategy Overview

This repository uses **Git Flow** methodology to manage Asana project CSV files with structured development and release cycles.

## Branch Types

### 1. Master Branch (`master`)
- **Purpose**: Production-ready project data
- **Protection**: Direct commits prohibited
- **Updates**: Only via merge from `release/*` or `hotfix/*` branches
- **Tags**: All releases tagged with version numbers (v1.0.0, v1.1.0, etc.)

### 2. Develop Branch (`develop`)
- **Purpose**: Integration branch for ongoing development
- **Source**: Features merge here before release
- **Testing**: All changes tested before merging to release branches

### 3. Feature Branches (`feature/*`)
- **Naming**: `feature/project-name` or `feature/update-description`
- **Purpose**: Individual project development or updates
- **Lifecycle**: Created from `develop`, merged back to `develop`
- **Examples**:
  - `feature/tourplan-hubspot-integration`
  - `feature/update-conditional-automation`
  - `feature/new-crm-integration`

### 4. Release Branches (`release/*`)
- **Naming**: `release/v1.x.x`
- **Purpose**: Prepare releases, final testing, version bumps
- **Lifecycle**: Created from `develop`, merged to both `master` and `develop`
- **Activities**: Bug fixes, documentation updates, version preparation

### 5. Hotfix Branches (`hotfix/*`)
- **Naming**: `hotfix/critical-fix-description`
- **Purpose**: Emergency fixes to production
- **Lifecycle**: Created from `master`, merged to both `master` and `develop`
- **Use Cases**: Critical CSV format errors, urgent project updates

## Workflow Commands

### Initialize Git Flow
```bash
cd /home/joel/tourplan/asana
git flow init

# Accept defaults:
# - Production branch: master
# - Development branch: develop
# - Feature prefix: feature/
# - Release prefix: release/
# - Hotfix prefix: hotfix/
# - Version tag prefix: v
```

### Feature Development Workflow
```bash
# Start new feature
git flow feature start project-name

# Work on feature (edit master-projects.csv)
git add master-projects.csv
git commit -m "Add/Update project: [description]"

# Finish feature (merges to develop)
git flow feature finish project-name
```

### Release Workflow
```bash
# Start release
git flow release start 1.1.0

# Final adjustments and testing
git add .
git commit -m "Prepare release v1.1.0"

# Finish release (merges to master and develop, creates tag)
git flow release finish 1.1.0
```

### Hotfix Workflow
```bash
# Start hotfix
git flow hotfix start critical-fix

# Make urgent fixes
git add master-projects.csv
git commit -m "Fix critical issue: [description]"

# Finish hotfix (merges to master and develop, creates tag)
git flow hotfix finish critical-fix
```

## Project Management Integration

### CSV File Management
- **Single Source**: `master-projects.csv` contains all project data
- **Validation**: Ensure CSV format compatibility with Asana import
- **Backup**: Archive old versions in `archive/` directory
- **Templates**: Store reusable project templates in `templates/`

### Version Control Best Practices
1. **Descriptive Commits**: Use clear, actionable commit messages
2. **Atomic Changes**: One logical change per commit
3. **Testing**: Validate CSV format before committing
4. **Documentation**: Update README when adding new projects

### Branch Protection Rules
- **Master**: Requires pull request, no direct commits
- **Develop**: Allows direct commits from team members
- **Feature**: Individual development branches

## Release Versioning

### Semantic Versioning (vX.Y.Z)
- **Major (X)**: Breaking changes, new project structure
- **Minor (Y)**: New projects, significant updates
- **Patch (Z)**: Bug fixes, minor corrections

### Examples
- **v1.0.0**: Initial repository setup
- **v1.1.0**: Add TourPlan-HubSpot integration project
- **v1.1.1**: Fix date formatting in project timeline
- **v1.2.0**: Add new CRM integration project

## Team Collaboration

### Multiple Contributors
```bash
# Always pull latest changes
git pull origin develop

# Create feature branch
git flow feature start your-feature-name

# Regular commits during development
git add .
git commit -m "Progress on feature: [description]"

# Push feature branch for collaboration
git push origin feature/your-feature-name

# Finish feature when complete
git flow feature finish your-feature-name
```

### Code Review Process
1. Push feature branch to remote
2. Create pull request to `develop`
3. Team review of CSV changes
4. Merge after approval

## Emergency Procedures

### Critical CSV Error
```bash
# Immediate hotfix
git flow hotfix start csv-format-fix

# Fix the issue
git add master-projects.csv
git commit -m "Fix critical CSV format error"

# Deploy immediately
git flow hotfix finish csv-format-fix
```

### Rollback Strategy
```bash
# Revert to previous version
git checkout master
git reset --hard v1.x.x  # Previous working version
git push --force-with-lease origin master
```

## Integration with External Systems

### Asana Import
- Use `master` branch CSV for production imports
- Test with `develop` branch data in staging
- Validate format before each release

### Project Management Tools
- Link git commits to project tracking systems
- Use issue numbers in commit messages
- Tag releases with project milestones

## Monitoring and Maintenance

### Regular Tasks
- Weekly: Review and merge feature branches
- Monthly: Create release with accumulated changes
- Quarterly: Archive old CSV versions
- As needed: Security updates and dependency management
