---
description: Create a GitHub issue with title and description
allowed-tools: Bash(gh issue create), Bash(gh issue list), Bash(gh repo view)
---

## Language Conventions

**Infer language style from the project:**
- Analyze existing issues, documentation, and commit messages to detect the project's language variant (US English, UK English, etc.)
- Match the spelling conventions found in the project (e.g., "initialize" vs "initialise", "behavior" vs "behaviour")
- Maintain consistency with the project's established language style throughout issue titles and descriptions

---

Create a GitHub issue with the following workflow:

1. Check if we're in a GitHub repository
2. **Check for ISSUE_TEMPLATE format first:**
   - Look for issue templates in `.github/ISSUE_TEMPLATE/` or `.github/` directories
   - If templates exist, use the most appropriate template format (bug report, feature request, etc.)
   - Parse template structure and fill in the required sections
3. **If no ISSUE_TEMPLATE exists, use custom format:**
   - Infer issue title from user's request context
   - Generate appropriate issue description based on the context
4. Create issue with title and description using `gh issue create`
5. Optionally add existing labels, assignees, or milestone (only use labels that already exist in the repository)

For the issue title:
- Use natural, descriptive language (NOT conventional commits format like "feat:", "fix:", "chore:")
- Make it clear and specific to the problem or feature
- Keep it concise but informative

For the issue description (when using custom format):
- Include clear problem statement or feature request
- Add steps to reproduce (if bug report)
- Keep it structured and actionable

For ISSUE_TEMPLATE format:
- Follow the exact template structure and required fields
- Fill in template placeholders with relevant information from user context
- Maintain template formatting and sections

