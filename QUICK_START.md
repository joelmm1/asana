# Quick Start Guide - Asana Project Management Repository

## 🚀 **New Team Member Setup**

### **Step 1: Clone Repository**
```bash
git clone git@github.com:joelmm1/asana.git
cd asana
```

### **Step 2: Verify Setup**
```bash
# Check repository structure
ls -la

# Validate master CSV
./scripts/validate-csv.sh master-projects.csv

# Check git flow status
./scripts/git-flow-helper.sh status
```

### **Step 3: Start Your First Feature**
```bash
# Create feature branch
./scripts/git-flow-helper.sh feature my-first-project

# Edit master-projects.csv (add your project)
# Save and validate
./scripts/validate-csv.sh master-projects.csv

# Commit your work
git add master-projects.csv
git commit -m "Add new project: My First Project"

# Finish feature (merges to develop)
./scripts/git-flow-helper.sh finish my-first-project
```

## 🎯 **Repository Setup Complete!**

### **What's Been Created:**
✅ **Git Flow Repository** with proper branching strategy  
✅ **Master CSV File** (`master-projects.csv`) - single source of truth  
✅ **Automated Validation** - ensures CSV quality before commits  
✅ **Helper Scripts** - streamlined git flow operations  
✅ **Historical Archive** - all previous CSV versions preserved  
✅ **Project Templates** - for consistent new project creation  

### **Repository Structure:**
```
/home/joel/tourplan/asana/
├── master-projects.csv          # 📋 Main project file (23 tasks)
├── README.md                    # 📖 Full documentation  
├── BRANCH_STRATEGY.md           # 🔄 Git flow guide
├── .gitignore                   # 🚫 Git ignore rules
├── archive/                     # 📦 Historical CSV files (8 files)
├── templates/                   # 📝 Project templates
│   └── project-template.csv
└── scripts/                     # 🛠️ Automation tools
    ├── validate-csv.sh          # ✅ CSV validation
    └── git-flow-helper.sh       # 🔄 Git flow automation
```

## 🎯 **Current Project Status:**
- **TourPlan-HubSpot Integration** (24 rows total)
- **115 TourPlan fields analyzed** ✅ COMPLETED
- **17 priority field mappings** ✅ COMPLETED  
- **Conditional Automation Strategy** 🔄 IN PROGRESS
- **API Development** 📋 READY TO BEGIN

## ⚡ **Quick Commands:**

### **Validate CSV:**
```bash
cd /home/joel/tourplan/asana
./scripts/validate-csv.sh master-projects.csv
```

### **Start New Feature:**
```bash
./scripts/git-flow-helper.sh feature new-project-name
# Edit master-projects.csv 
git add master-projects.csv
git commit -m "Add new project: Description"
./scripts/git-flow-helper.sh finish new-project-name
```

### **Check Status:**
```bash
./scripts/git-flow-helper.sh status
```

### **Create Release:**
```bash
./scripts/git-flow-helper.sh release 1.1.0
```

## 🔧 **Git Flow Branches:**
- **`master`** - Production CSV (clean, validated)
- **`develop`** - Current working branch ⭐
- **`feature/*`** - Individual project branches
- **`release/*`** - Version preparation
- **`hotfix/*`** - Emergency fixes

## 📝 **CSV Validation Results:**
```
✅ Header format correct
✅ Total rows: 24 (including header)  
✅ Data rows: 23
✅ All tasks have names
✅ All dates in correct format (YYYY-MM-DD)
✅ No weekend dates found
```

## 🌐 **Remote Repository Ready:**
The repository is ready to be pushed to any remote git service (GitHub, GitLab, etc.) for team collaboration and backup.

## 📞 **Support:**
- **CSV Issues**: Use `validate-csv.sh` to check format
- **Git Flow Help**: Use `git-flow-helper.sh` for guided operations  
- **Documentation**: Check `README.md` and `BRANCH_STRATEGY.md`

---
**Repository initialized by:** Joel Muriuki  
**Date:** August 5, 2025  
**Current Branch:** `develop`  
**Ready for:** Team collaboration and project management
