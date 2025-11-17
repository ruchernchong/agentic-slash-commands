---
description: Generate pull request descriptions by analyzing commits and changes
allowed-tools: Bash(git log), Bash(git diff), Bash(gh pr list), Read(*.md)
---

Generate comprehensive PR descriptions for the /create-pull-request command:

1. **Analyze Commit History**:
   - Get all commits since divergence from base branch
   - Extract commit messages and changes
   - Identify patterns and themes across commits
   - Group related changes together

2. **Categorize Changes**:
   - New features added
   - Bug fixes implemented
   - Refactoring performed
   - Documentation updates
   - Test additions/modifications
   - Configuration changes

3. **Generate Summary**:
   - Create concise 1-3 bullet point summary
   - Focus on user-facing changes
   - Highlight breaking changes if any
   - Note dependencies or related PRs

4. **Create Test Plan**:
   - List areas that should be tested
   - Include specific test scenarios
   - Note any manual testing required
   - Reference automated tests if applicable

5. **Check Repository Templates**:
   - Read .github/PULL_REQUEST_TEMPLATE.md if exists
   - Follow template structure
   - Fill in required sections
   - Add additional context as needed

6. **Return Format**:
   - Title (based on primary change)
   - Summary section (bullet points)
   - Test plan section (checklist format)
   - Additional notes if needed

This skill is used by the /create-pull-request command to generate informative PR descriptions.
