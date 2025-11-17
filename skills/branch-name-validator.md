---
description: Validate and suggest branch names following repository conventions
allowed-tools: Bash(git branch), Bash(git remote), Read(*.md)
---

Validate and generate branch names for the /create-branch command:

1. **Detect Repository Conventions**:
   - List existing branches with git branch -a
   - Identify common prefixes (feature/, bugfix/, hotfix/, chore/, docs/)
   - Check for naming patterns (kebab-case, snake_case, etc.)

2. **Parse GitHub Issue Integration**:
   - Extract issue number from user input
   - Validate issue exists (if GitHub integration available)
   - Include issue number in branch name if applicable

3. **Validate Branch Name**:
   - Check for invalid characters (spaces, special chars)
   - Ensure name follows detected conventions
   - Verify branch doesn't already exist
   - Warn about overly long names (>50 chars)

4. **Suggest Improvements**:
   - Add appropriate prefix if missing
   - Convert to kebab-case if needed
   - Include issue number in standard format
   - Ensure descriptive and concise

5. **Return Validation Result**:
   - Valid: true/false
   - Suggested name (if improvements needed)
   - Warnings or errors
   - Final branch name to create

This skill is used by the /create-branch command to ensure branch names follow repository standards.
