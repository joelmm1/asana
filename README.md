# Asana Project Management Repository

## Overview
Centralized repository for managing Asana project CSV files across all projects. This repository follows git flow methodology for structured development and release management.

## 🚀 Quick Start for New Team Members

### **1. Clone the Repository**
```bash
git clone git@github.com:joelmm1/asana.git
cd asana
```

### **2. Verify Setup**
```bash
# Check repository structure
ls -la

# Validate the master CSV file
./scripts/validate-csv.sh master-projects.csv
```

### **3. Start Working on Features**
```bash
# Initialize git flow (first time only)
./scripts/git-flow-helper.sh init

# Start a new feature
./scripts/git-flow-helper.sh feature new-project-name

# Edit master-projects.csv with your changes
# Commit your work
git add master-projects.csv
git commit -m "Add new project: Your Project Description"

# Finish the feature (merges to develop)
./scripts/git-flow-helper.sh finish new-project-name
```

### **4. Check Status Anytime**
```bash
./scripts/git-flow-helper.sh status
```

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

## Team Collaboration

### **Prerequisites**
- Git access to the repository
- SSH key configured for GitHub
- Basic understanding of git flow methodology

### **Daily Workflow**
```bash
# 1. Pull latest changes
git checkout develop
git pull origin develop

# 2. Create feature branch for your work
./scripts/git-flow-helper.sh feature your-project-update

# 3. Make changes to master-projects.csv
# 4. Validate before committing
./scripts/validate-csv.sh master-projects.csv

# 5. Commit and finish feature
git add master-projects.csv
git commit -m "Update project: Description of changes"
./scripts/git-flow-helper.sh finish your-project-update

# 6. Push develop branch
git push origin develop
```

### **Release Process**
```bash
# Create release (from develop branch)
./scripts/git-flow-helper.sh release 1.2.0

# Final testing and validation
./scripts/validate-csv.sh master-projects.csv

# Complete release (merges to master and develop)
git flow release finish 1.2.0

# Push all branches and tags
git push origin master
git push origin develop
git push origin --tags
```

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
