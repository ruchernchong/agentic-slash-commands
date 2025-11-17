---
description: Generate descriptive commit messages by analyzing staged changes
allowed-tools: Bash(git status), Bash(git diff), Bash(git log), Read(*.md), Read(*.json)
---

Generate intelligent commit messages for the /commit command:

1. **Analyze Staged Changes**:
   - Run git diff --staged to see what's being committed
   - Identify file types and patterns (code, docs, config, tests)
   - Detect scope of changes (single file, module, cross-cutting)

2. **Determine Commit Type**:
   - feat: New feature or functionality
   - fix: Bug fix
   - docs: Documentation changes
   - style: Code style/formatting (no logic change)
   - refactor: Code restructuring (no behavior change)
   - test: Test additions or modifications
   - chore: Build process, dependencies, tooling

3. **Extract Context**:
   - Check git log for commit message patterns in the repo
   - Read package.json for project context
   - Identify affected components or modules

4. **Generate Message**:
   - Follow conventional commit format if repo uses it
   - Keep subject line under 50 characters
   - Focus on "why" rather than "what"
   - Use imperative mood (e.g., "Add" not "Added")

5. **Return Format**:
   - Subject line (concise summary)
   - Optional body (detailed explanation if needed)
   - Follow repository conventions

This skill is used by the /commit command to generate balanced, descriptive commit messages.
