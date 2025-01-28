#!/bin/bash

# Set your GitHub repository URL
REPO_URL="git@github.com:yangshinyaw/CIACHR.git"

# Set the branch name (default: main)
BRANCH="main"

# Ensure git is initialized
git init
git remote add origin $REPO_URL
git checkout -b $BRANCH

# List of files to commit each day
declare -a FILES=(
  ".gitignore README.md"
  "package.json tsconfig.json vite.config.ts"
  "src/main.tsx src/App.tsx"
  "src/routes.tsx"
  "src/pages/Login.tsx src/pages/Register.tsx"
  "src/components/Navbar.tsx src/components/Footer.tsx"
  "src/pages/Dashboard.tsx"
  "src/context/AuthContext.tsx"
  "src/hooks/useAuth.ts"
  "src/pages/EmployeeList.tsx"
  "src/pages/EmployeeProfile.tsx"
  "src/api/employees.ts"
  "src/components/EmployeeCard.tsx"
  "src/pages/Payroll.tsx"
  "src/api/payroll.ts"
  "src/pages/LeaveRequests.tsx"
  "src/api/leaves.ts"
  "src/components/LeaveForm.tsx"
  "src/pages/Attendance.tsx"
  "src/api/attendance.ts"
  "src/hooks/useEmployees.ts"
  "src/hooks/usePayroll.ts"
  "src/utils/validators.ts"
  "src/components/Alerts.tsx"
  "src/pages/Settings.tsx"
  "src/pages/AdminPanel.tsx"
  "src/api/admin.ts"
  "src/tests/EmployeeList.test.tsx"
  "src/tests/Auth.test.tsx"
  "FINAL_COMMIT"
)

# Loop through the last 30 days
for i in {30..1}
do
  DATE=$(date --date="$i days ago" +"%Y-%m-%dT12:00:00")

  # Select the file(s) for this day
  FILE_INDEX=$((30 - i))
  COMMIT_FILES=${FILES[$FILE_INDEX]}
  
  # Create necessary directories and empty files
  for FILE in $COMMIT_FILES; do
    if [[ "$FILE" == "FINAL_COMMIT" ]]; then
      continue
    fi
    mkdir -p $(dirname $FILE) && touch $FILE
    echo "// Code for $FILE" >> $FILE
  done

  # Add and commit with a backdated timestamp
  git add .
  GIT_COMMITTER_DATE="$DATE" git commit --date "$DATE" -m "feat: update progress log for $DATE"
done

# Push all commits at once
git push origin $BRANCH --force
