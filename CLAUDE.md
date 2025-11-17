# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of intelligent Claude Code commands optimised for JavaScript/TypeScript development workflows. Each command uses smart detection to identify project configuration and automatically execute appropriate package manager tools (pnpm, bun, yarn, npm) with preference for modern, fast alternatives.

## Installation

This repository is designed to be cloned once and symlinked to `$HOME/.claude/commands/` for global access across all projects:

```bash
git clone https://github.com/ruchernchong/agentic-slash-commands.git $HOME/agentic-slash-commands
cd $HOME/agentic-slash-commands
chmod +x install.sh
./install.sh
```

### Benefits of Symlink Approach
- **One-time setup**: Clone once, use everywhere
- **Easy updates**: Run `git pull` to update all commands instantly
- **Global availability**: Commands work across all projects
- **No duplication**: Single source of truth for all command definitions

### Updating
```bash
cd $HOME/agentic-slash-commands
git pull
```

The symlinks automatically reflect any updates - no reinstallation needed.

## Language and Writing Conventions

Commands automatically adapt to the language conventions of the project they're being used in. When executing commands:

- **Infer from project context**: Analyse existing documentation, commit messages, and code comments to detect the project's language variant (US English, UK English, etc.)
- **Match existing style**: Use the same spelling conventions found in the project (e.g., "organize" vs "organise", "color" vs "colour")
- **Consistency within project**: Maintain the detected language style throughout command outputs and generated content
- **Fallback to project defaults**: If no clear pattern is detected, follow the project's README or contributing guidelines

This ensures commands integrate seamlessly with any project's established conventions.

## Commands Available

### Core Development Commands
- `/build` - Intelligent build detection and execution (auto-detects pnpm, bun, yarn, npm)
- `/test` - Smart test runner (Jest, Vitest, Mocha, etc.)
- `/lint` - JavaScript/TypeScript linting and formatting (ESLint, Prettier)
- `/setup` - Automated dependency installation with package manager detection

### Project Management
- `/clean` - Safe cleanup of node_modules, dist/, build/, .pnpm-store, cache files
- `/commit` or `./commit` - Smart git commit with balanced approach to change grouping
- `/create-issue` - GitHub issue creation with template support
- `/create-pull-request` - Automated PR creation with commit analysis
- `/update-docs` - Documentation maintenance for CLAUDE.md and README.md files

## Command Architecture

### Directory Structure
Commands are organised in a clean, flat structure:
```
.
├── commands/          # All slash command definitions (.md files)
├── scripts/           # Helper scripts (e.g., commit)
├── CLAUDE.md          # This file - project guidance
├── README.md          # User documentation
└── install.sh         # Symlink installer for global access
```

### Smart Detection System
Each command follows a pattern of:
1. **Project Detection**: Analyze package.json and lock files (pnpm-lock.yaml, bun.lockb, yarn.lock, package-lock.json)
2. **Tool Selection**: Prioritize pnpm > bun > yarn > npm based on lock file presence
3. **Execution**: Run the most suitable command for the environment
4. **Results**: Provide clear output with actionable feedback

### JavaScript/TypeScript Focus
Commands automatically handle:
- **Package Managers**: Intelligent detection with preference order: pnpm → bun → yarn → npm
- **Build Tools**: Webpack, Vite, Rollup, Parcel, Next.js, Nuxt
- **Testing**: Jest, Vitest, Mocha, Cypress, Playwright
- **Linting**: ESLint with TypeScript support, Prettier formatting
- **Frameworks**: React, Vue, Angular, Svelte detection

### Command Definition Format
Commands are defined in markdown files within the `commands/` directory, using YAML frontmatter:
```yaml
---
description: Command description
allowed-tools: List of permitted tools
---
```

All command files are stored in `commands/` for easy organisation and maintenance.

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
- Use `/create-pull-request` for automated PR creation with generated descriptions

## Configuration

### Package.json Integration
Commands automatically read and execute scripts from package.json using detected package manager:
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