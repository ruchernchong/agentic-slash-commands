---
description: Clean up temporary files and build artifacts
model: sonnet
allowed-tools: Bash(rm), Bash(find), Bash(du), Bash(ls), Read(*package.json), Read(*.gitignore)
---

Clean up project files safely:

1. Check .gitignore to identify safe-to-delete files
2. Show what will be cleaned before deletion
3. Clean common temporary files and directories:
   - node_modules (if package-lock.json exists)
   - dist/, build/, target/ directories
   - .cache, .temp, .tmp directories  
   - Log files (*.log)
   - OS files (.DS_Store, Thumbs.db)

4. Ask for confirmation before deleting large directories
5. Show disk space freed after cleanup

Automatically determine appropriate clean level based on project state:
- Start with safe cleanup of build artifacts and cache files
- Offer deeper cleanup options if significant space can be freed
- Always ask for confirmation before deleting large directories
- Show what will be cleaned before proceeding