---
description: Run linters and formatters for the project
model: sonnet
allowed-tools: Bash(npm run lint), Bash(npx eslint), Bash(prettier), Bash(ruff), Bash(black), Bash(cargo clippy), Bash(rustfmt), Bash(gofmt), Bash(golangci-lint), Read(*package.json), Read(*.eslintrc*), Read(*.prettierrc*), Read(*pyproject.toml)
---

Run linting and formatting tools:

1. Detect available linters and formatters:
   - JavaScript/TypeScript: ESLint, Prettier
   - Python: Ruff, Black, Flake8
   - Rust: Clippy, rustfmt
   - Go: gofmt, golangci-lint

2. Run appropriate tools based on project configuration
3. Show linting results with clear error/warning counts
4. Offer to auto-fix issues when possible

First run linters to show results, then offer to auto-fix issues if any are found:
- Run appropriate linters and formatters for the detected project type
- Show clear results with error/warning counts
- Offer to auto-fix fixable issues when available
- Apply formatting automatically where appropriate