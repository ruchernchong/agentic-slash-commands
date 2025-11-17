---
description: Handle GitHub API interactions for issues and pull requests
allowed-tools: Bash(gh issue *), Bash(gh pr *), Bash(gh repo *), Read(.github/*)
---

Provide GitHub integration for /create-issue and /create-pull-request commands:

1. **Repository Detection**:
   - Verify GitHub CLI (gh) is installed
   - Check if current directory is a git repo
   - Get repository owner and name
   - Verify GitHub remote exists

2. **Issue Management**:
   - List issue templates from .github/ISSUE_TEMPLATE/
   - Create issues with appropriate template
   - Add labels, assignees, milestones
   - Link issues to projects if applicable
   - Return issue URL and number

3. **Pull Request Management**:
   - Detect base branch (usually main or master)
   - Check if current branch is pushed to remote
   - Get PR template from .github/PULL_REQUEST_TEMPLATE.md
   - Create PR with title and description
   - Add reviewers, labels, assignees
   - Link to related issues
   - Return PR URL and number

4. **Template Processing**:
   - Read template files
   - Parse template sections
   - Fill in required fields
   - Preserve template structure
   - Handle template variables

5. **Validation**:
   - Check GitHub authentication status
   - Verify repository access
   - Validate branch status
   - Check for conflicts
   - Ensure required fields are filled

6. **Error Handling**:
   - Provide clear error messages
   - Suggest fixes for common issues
   - Fall back gracefully if gh not available
   - Offer manual command alternatives

This skill is used by /create-issue and /create-pull-request to interact with GitHub.
