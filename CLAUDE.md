# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of intelligent agentic capabilities designed for multiple AI platforms (Claude Code, Codex, Gemini CLI). These capabilities are optimised for JavaScript/TypeScript development workflows and use smart detection to identify project configuration and automatically execute appropriate package manager tools (pnpm, bun, yarn, npm) with preference for modern, fast alternatives.

**Multi-Platform Support**: Capabilities are written once and can be installed across multiple platforms through platform-specific installers:
- **Claude Code**: Installed as skills (invoke with `/skill-name`)
- **Codex**: Installed as prompts
- **Gemini CLI**: Installed as commands

## Installation

This repository is designed to be cloned once and symlinked globally for all supported platforms:

```zsh
git clone https://github.com/ruchernchong/agentic-slash-commands.git $HOME/agentic-slash-commands
cd $HOME/agentic-slash-commands
chmod +x install.sh
./install.sh
```

The universal installer will set up capabilities for each platform:
- **Claude Code**: Symlinks skills to `$HOME/.claude/skills/`
- **Codex**: Symlinks prompts to `$HOME/.codex/prompts/`
- **Gemini CLI**: Currently disabled (experimental feature)

### Platform-Specific Installation

To install for a specific platform only:

```zsh
# Claude Code only
zsh scripts/install-claude.sh

# Codex only
zsh scripts/install-codex.sh

# Gemini CLI only
zsh scripts/install-gemini.sh
```

### Benefits of Symlink Approach
- **One-time setup**: Clone once, use everywhere across all platforms
- **Easy updates**: Run `git pull` to update all capabilities instantly
- **Global availability**: Works across all projects
- **No duplication**: Single source of truth for all capability definitions
- **Multi-platform**: Install once, use with Claude Code (skills), Codex (prompts), and Gemini CLI (commands)

### Updating
```zsh
cd $HOME/agentic-slash-commands
git pull
```

The symlinks automatically reflect any updates - no reinstallation needed.

## Language and Writing Conventions

Skills automatically adapt to the language conventions of the project they're being used in. When executing:

- **Infer from project context**: Analyse existing documentation, commit messages, and code comments to detect the project's language variant (US English, UK English, etc.)
- **Match existing style**: Use the same spelling conventions found in the project (e.g., "organize" vs "organise", "color" vs "colour")
- **Consistency within project**: Maintain the detected language style throughout outputs and generated content
- **Fallback to project defaults**: If no clear pattern is detected, follow the project's README or contributing guidelines

This ensures skills integrate seamlessly with any project's established conventions.

## Skills Available (Claude Code)

### User-Invocable Skills
User-invocable skills are explicitly invoked with `/skill-name` syntax:

#### Core Development
- `/build` - Intelligent build detection and execution (auto-detects pnpm, bun, yarn, npm)
- `/test` - Smart test runner (Jest, Vitest, Mocha, etc.)
- `/lint` - JavaScript/TypeScript linting and formatting (ESLint, Prettier)
- `/setup` - Automated dependency installation with package manager detection

#### Project Management
- `/clean` - Safe cleanup of node_modules, dist/, build/, .pnpm-store, cache files
- `/commit` - Smart git commit with balanced approach to change grouping
- `/create-branch` - Create and checkout new git branch with smart validation and GitHub issue integration
- `/create-issue` - GitHub issue creation with template support
- `/create-pull-request` - Automated PR creation with commit analysis
- `/update-issue` - Update GitHub issue title, body, labels, or assignees
- `/update-docs` - Documentation maintenance for CLAUDE.md and README.md files

### Helper Skills (Auto-Discovered)

Helper skills are automatically discovered and used by Claude Code to support user-invocable skills. They provide specialized functionality that enhances the capabilities above:

- `commit-message-generator` - Generates descriptive commit messages by analyzing staged changes (used by `/commit`)
- `branch-name-validator` - Validates and suggests branch names following repository conventions (used by `/create-branch`)
- `pr-description-generator` - Generates pull request descriptions by analyzing commits and changes (used by `/create-pull-request`)
- `project-structure-analyzer` - Analyzes project structure to detect package managers, build tools, and testing frameworks (used by `/build`, `/test`, `/lint`, `/setup`)
- `github-integration` - Handles GitHub API interactions for issues and pull requests (used by `/create-issue`, `/create-pull-request`)

## Skills Architecture

### Directory Structure
Skills are organised in a modular structure:
```
.
├── commands/          # User-invocable skills (.md files) - invoke with /skill-name
├── skills/            # Helper skills (.md files) - auto-discovered by Claude Code
├── scripts/           # Platform-specific installers and helper scripts
│   ├── install-claude.sh    # Claude Code installer
│   ├── install-codex.sh     # Codex installer
│   ├── install-gemini.sh    # Gemini CLI installer
│   └── commit               # Standalone git commit helper script
├── tests/             # Testing infrastructure
│   ├── README.md      # Testing documentation
│   ├── run-tests.sh   # Test runner script
│   └── docker-compose.yml   # Docker-based test environment
├── .github/           # GitHub workflows and templates
│   ├── workflows/     # CI/CD automation
│   │   └── tests.yml  # Automated testing workflow
│   └── ISSUE_TEMPLATE/      # Issue templates
├── lib/               # Shared utilities and helpers
│   └── helpers.sh     # Common bash functions for installers
├── CLAUDE.md          # This file - project guidance for Claude Code
├── README.md          # User documentation
└── install.sh         # Universal installer for all platforms
```

### Smart Detection System
Each skill follows a pattern of:
1. **Project Detection**: Analyze package.json and lock files (pnpm-lock.yaml, bun.lockb, yarn.lock, package-lock.json)
2. **Tool Selection**: Prioritize pnpm > bun > yarn > npm based on lock file presence
3. **Execution**: Run the most suitable operation for the environment
4. **Results**: Provide clear output with actionable feedback

### JavaScript/TypeScript Focus
Skills automatically handle:
- **Package Managers**: Intelligent detection with preference order: pnpm → bun → yarn → npm
- **Build Tools**: Webpack, Vite, Rollup, Parcel, Next.js, Nuxt
- **Testing**: Jest, Vitest, Mocha, Cypress, Playwright
- **Linting**: ESLint with TypeScript support, Prettier formatting
- **Frameworks**: React, Vue, Angular, Svelte detection

### Skill Definition Format
All skills are defined in markdown files using YAML frontmatter:

**User-Invocable Skills** (stored in `commands/` directory):
```yaml
---
description: Skill description (what it does and when to use it)
model: sonnet  # Optional: specify Claude model
allowed-tools: List of permitted tools
---
```

**Helper Skills** (stored in `skills/` directory):
```yaml
---
description: Skill description (capability provided)
allowed-tools: List of permitted tools
---
```

Both types use the same format. User-invocable skills are explicitly invoked with `/skill-name`, while helper skills are automatically discovered by Claude Code based on context.

## Development Workflow

### For Build Tasks
- Use `/build` to automatically detect package manager and run build scripts
- Priority: pnpm-lock.yaml → bun.lockb → yarn.lock → package-lock.json
- Handles different environments (production, development, staging)
- Detects build tools like Webpack, Vite, Next.js, etc.

### For Code Quality
- Use `/lint` to run ESLint and Prettier for JavaScript/TypeScript projects
- Automatically detects .eslintrc* and .prettierrc* configuration
- Offers to auto-fix issues when ESLint --fix is available

### For Testing
- Use `/test` to run JavaScript/TypeScript test suites
- Detects Jest, Vitest, Mocha, and other testing frameworks
- Shows clear pass/fail results with highlighted failures

### For Dependencies
- Use `/setup` to install dependencies with intelligent package manager detection
- Detection order: pnpm-lock.yaml → bun.lockb → yarn.lock → package-lock.json
- Falls back to npm if no lock files present
- Installs both production and development dependencies

### For Git Workflow
- Use `/commit` for balanced commit creation (keeps related changes together)
- Use `/create-branch` to create new branches with automatic prefix detection (feature/, bugfix/, hotfix/, chore/, docs/)
- Use `/create-pull-request` for automated PR creation with generated descriptions

**Note**: The `/commit` skill is invoked within Claude Code. There's also a standalone `scripts/commit` bash script that provides similar functionality but can be used independently outside of Claude Code sessions.

## Configuration

### Package.json Integration
Skills automatically read and execute scripts from package.json using detected package manager:
- `pnpm run build` (preferred) or `bun run build` or `yarn build` or `npm run build`
- `pnpm test` (preferred) or `bun test` or `yarn test` or `npm test`
- `pnpm run lint` (preferred) or `bun run lint` or `yarn lint` or `npm run lint`

### Local Settings
Commands respect local settings defined in `.claude/settings.local.json` for permission management.

### Project-Specific Behavior
Each command adapts to:
- package.json scripts and dependencies
- Lock file detection with priority: pnpm-lock.yaml > bun.lockb > yarn.lock > package-lock.json
- ESLint and Prettier configuration files
- Testing framework configuration
- Git repository state and GitHub templates

## Testing

This repository includes a comprehensive Docker-based testing infrastructure to validate commands across different environments.

### Running Tests

```zsh
# Run all tests (Docker + macOS if applicable)
cd tests
./run-tests.sh

# Run specific test suites
./run-tests.sh docker    # Docker-based tests only
./run-tests.sh macos     # macOS tests only
```

### Test Coverage

The test suite validates:
- **Installation integrity**: Symlink creation and correctness
- **Command validation**: All command files have proper YAML frontmatter
- **Idempotence**: Repeated installations don't break existing setup
- **Cross-platform**: Tests run on Alpine Linux (Docker) and macOS
- **Package manager detection**: Validates pnpm/bun/yarn/npm detection logic

See `tests/README.md` for detailed testing documentation.

## CI/CD

Automated workflows run on every push and pull request to ensure quality:

### GitHub Actions Workflows

**Location**: `.github/workflows/tests.yml`

**Jobs**:
1. **docker-tests**: Validates installation and commands in Alpine Linux container
2. **macos-tests**: Tests on macOS environment
3. **validate-commands**: Checks all command files for proper formatting

**Features**:
- Docker layer caching for faster builds
- Pinned Actions to commit hashes for security
- Automated validation on push/PR to main branch

This ensures all commands work correctly across platforms before merging changes.