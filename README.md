# Asana Project Management Repository

## Overview
Centralized repository for managing Asana project CSV files across all projects. This repository follows git flow methodology for structured development and release management.

## Repository Structure
```
/
├── README.md                    # This file
├── BRANCH_STRATEGY.md          # Git flow documentation
├── master-projects.csv         # Master CSV file for all projects
├── archive/                    # Historical CSV files
├── templates/                  # Project templates
└── scripts/                    # Automation scripts
```

## Master CSV File
- **File**: `master-projects.csv`
- **Purpose**: Single source of truth for all Asana project data
- **Format**: Standard Asana import format with all required columns
- **Management**: Updated via git flow branches only

## Git Flow Strategy
This repository follows **git flow** methodology:

- **`master`**: Production-ready project data
- **`develop`**: Integration branch for ongoing project updates
- **`feature/*`**: Individual project feature branches
- **`release/*`**: Release preparation branches
- **`hotfix/*`**: Emergency fixes to master

## Usage

### Adding New Projects
```bash
# Create feature branch
git checkout develop
git checkout -b feature/new-project-name

# Edit master-projects.csv
# Commit changes
git add master-projects.csv
git commit -m "Add new project: [Project Name]"

# Merge to develop
git checkout develop
git merge feature/new-project-name
```

### Updating Existing Projects
```bash
# Create feature branch for updates
git checkout develop
git checkout -b feature/update-project-name

# Update master-projects.csv
# Commit and merge to develop
```

### Release Process
```bash
# Create release branch
git checkout develop
git checkout -b release/v1.x.x

# Final testing and adjustments
# Merge to master and develop
git checkout master
git merge release/v1.x.x
git tag v1.x.x

git checkout develop
git merge release/v1.x.x
```

## Current Projects
- **TourPlan-HubSpot Integration Documentation & TMIS Collaboration** - Active development
- Additional projects will be added as needed

## Contributing
1. Always work on feature branches
2. Use descriptive commit messages
3. Test CSV format before committing
4. Follow the release process for production updates

## File Naming Convention
- `master-projects.csv` - Main project file
- `archive/project-name-YYYYMMDD.csv` - Archived versions
- `templates/template-name.csv` - Project templates

## Support
For questions about this repository structure or git flow process, contact Joel Muriuki.
