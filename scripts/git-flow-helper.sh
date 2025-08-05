#!/bin/bash
# Git Flow Helper Script for Asana Repository

ACTION="$1"
PROJECT_NAME="$2"
VERSION="$3"

show_usage() {
    echo "Usage: $0 [action] [options]"
    echo ""
    echo "Actions:"
    echo "  init                    - Initialize git flow"
    echo "  feature [name]          - Start new feature branch"
    echo "  finish [name]           - Finish current feature"
    echo "  release [version]       - Start release process"
    echo "  hotfix [name]           - Start hotfix process"
    echo "  status                  - Show current branch status"
    echo "  validate                - Validate master-projects.csv"
    echo ""
    echo "Examples:"
    echo "  $0 init"
    echo "  $0 feature tourplan-integration"
    echo "  $0 finish tourplan-integration"
    echo "  $0 release 1.1.0"
    echo "  $0 hotfix critical-csv-fix"
    echo "  $0 validate"
}

case "$ACTION" in
    "init")
        echo "Initializing git flow..."
        git flow init -d
        echo "✅ Git flow initialized with default settings"
        ;;
    
    "feature")
        if [ -z "$PROJECT_NAME" ]; then
            echo "Error: Please provide feature name"
            echo "Usage: $0 feature [feature-name]"
            exit 1
        fi
        echo "Starting feature: $PROJECT_NAME"
        git flow feature start "$PROJECT_NAME"
        echo "✅ Feature branch created: feature/$PROJECT_NAME"
        echo "💡 Edit master-projects.csv and commit your changes"
        ;;
    
    "finish")
        if [ -z "$PROJECT_NAME" ]; then
            CURRENT_BRANCH=$(git branch --show-current)
            if [[ $CURRENT_BRANCH == feature/* ]]; then
                PROJECT_NAME=${CURRENT_BRANCH#feature/}
                echo "Auto-detected feature: $PROJECT_NAME"
            else
                echo "Error: Not on a feature branch and no feature name provided"
                exit 1
            fi
        fi
        echo "Finishing feature: $PROJECT_NAME"
        # Validate CSV before finishing
        ./scripts/validate-csv.sh master-projects.csv
        if [ $? -eq 0 ]; then
            git flow feature finish "$PROJECT_NAME"
            echo "✅ Feature merged to develop branch"
        else
            echo "❌ CSV validation failed. Please fix errors before finishing feature."
            exit 1
        fi
        ;;
    
    "release")
        if [ -z "$PROJECT_NAME" ]; then
            echo "Error: Please provide version number"
            echo "Usage: $0 release [version]"
            exit 1
        fi
        echo "Starting release: v$PROJECT_NAME"
        git flow release start "$PROJECT_NAME"
        echo "✅ Release branch created: release/$PROJECT_NAME"
        echo "💡 Make final adjustments and run: git flow release finish $PROJECT_NAME"
        ;;
    
    "hotfix")
        if [ -z "$PROJECT_NAME" ]; then
            echo "Error: Please provide hotfix name"
            echo "Usage: $0 hotfix [hotfix-name]"
            exit 1
        fi
        echo "Starting hotfix: $PROJECT_NAME"
        git flow hotfix start "$PROJECT_NAME"
        echo "✅ Hotfix branch created: hotfix/$PROJECT_NAME"
        echo "⚠️  Fix critical issue and run: git flow hotfix finish $PROJECT_NAME"
        ;;
    
    "status")
        echo "Git Flow Status"
        echo "==============="
        CURRENT_BRANCH=$(git branch --show-current)
        echo "Current branch: $CURRENT_BRANCH"
        echo ""
        echo "Recent commits:"
        git log --oneline -5
        echo ""
        echo "Branch list:"
        git branch -a
        ;;
    
    "validate")
        echo "Validating master-projects.csv..."
        ./scripts/validate-csv.sh master-projects.csv
        ;;
    
    *)
        show_usage
        ;;
esac
