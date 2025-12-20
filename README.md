# Agentic Slash Commands 🤖

<div align="center">

[![CI Tests](https://img.shields.io/github/actions/workflow/status/ruchernchong/agentic-slash-commands/tests.yml?style=for-the-badge&logo=github&label=Tests)](https://github.com/ruchernchong/agentic-slash-commands/actions)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge&logo=opensourceinitiative&logoColor=white)](LICENSE)

[![Platform](https://img.shields.io/badge/Claude_Code-8B5CF6?style=for-the-badge&logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Platform](https://img.shields.io/badge/Codex-10A37F?style=for-the-badge&logo=openai&logoColor=white)](https://openai.com/codex/)
[![Platform](https://img.shields.io/badge/Gemini_CLI-4285F4?style=for-the-badge&logo=google&logoColor=white)](https://github.com/google-gemini/gemini-cli)

</div>

A collection of intelligent capabilities for AI coding assistants
including [Claude Code](https://claude.ai/code), [Codex](https://openai.com/codex/),
and [Gemini CLI](https://github.com/google-gemini/gemini-cli). Optimised for JavaScript/TypeScript development
workflows with smart detection to identify project configuration and automatically execute appropriate
tools with your preferred package manager.

**🚀 Multi-Platform Support**: Write once, use across all platforms with platform-specific terminology:
- **Claude Code**: Skills (invoke with `/skill-name`)
- **Codex**: Prompts
- **Gemini CLI**: Commands

## ✨ Features

- 🎯 **Multi-Platform Support**: Compatible with Claude Code (skills), Codex (prompts), and Gemini CLI (commands)
- 📦 **Smart Package Manager Detection**: Automatically detects and uses pnpm, bun, yarn, or npm based on lock files
- ⚡ **Framework Aware**: Recognises and adapts to React, Vue, Next.js, Nuxt, and more
- 🎨 **Zero Configuration**: Works out of the box with standard JavaScript/TypeScript projects
- 🚀 **Universal Installation**: One command installs for all supported platforms
- 🐳 **Docker-Based Testing**: Comprehensive test suite validates across platforms
- 🔄 **CI/CD Integration**: Automated testing with GitHub Actions ensures quality

## 📋 Available Capabilities

### 🛠️ Core Development

- **`/build`** - Intelligent build detection and execution
  - Auto-detects build tools (Webpack, Vite, Rollup, Next.js, etc.)
  - Uses detected package manager automatically

- **`/test`** - Smart test runner
  - Supports Jest, Vitest, Mocha, Cypress, Playwright
  - Provides clear pass/fail results with highlighted failures

- **`/lint`** - JavaScript/TypeScript linting and formatting
  - Runs ESLint and Prettier
  - Offers auto-fix when available

- **`/setup`** - Automated dependency installation
  - Intelligent package manager detection
  - Installs both production and development dependencies

### 📊 Project Management

- **`/clean`** - Safe cleanup of build artefacts
  - Removes node_modules, dist/, build/, .pnpm-store
  - Clears cache files safely

- **`/commit`** - Smart git commit creation
  - Balanced approach to grouping related changes
  - Generates descriptive commit messages

- **`/create-branch`** - Create and checkout new git branches
  - Smart validation
  - GitHub issue integration

- **`/create-issue`** - GitHub issue creation
  - Template support
  - Pre-filled with project context

- **`/update-issue`** - Update existing GitHub issue
  - Edit title, body, labels, or assignees
  - Respects issue templates

- **`/create-pull-request`** - Automated PR creation
  - Analyses commits for description generation
  - Follows repository conventions

- **`/update-docs`** - Documentation maintenance
  - Updates CLAUDE.md and README.md
  - Keeps documentation in sync

## 🎯 Helper Skills (Claude Code)

Helper skills are automatically discovered by Claude Code to support the user-invocable skills listed above. They provide specialized functionality that enhances capabilities.

### 🧠 Core Helper Skills

- **`commit-message-generator`** - Smart commit message generation
  - Analyzes staged changes to generate descriptive messages
  - Follows conventional commit format and repository patterns
  - Used by `/commit` skill

- **`branch-name-validator`** - Branch naming validation
  - Validates and suggests branch names following conventions
  - Integrates with GitHub issues
  - Used by `/create-branch` skill

- **`pr-description-generator`** - Pull request description generation
  - Analyzes commit history to generate comprehensive PR descriptions
  - Creates test plans and categorizes changes
  - Used by `/create-pull-request` skill

- **`project-structure-analyzer`** - Project configuration analysis
  - Detects package managers, build tools, and testing frameworks
  - Provides structure information for intelligent execution
  - Used by `/build`, `/test`, `/lint`, and `/setup` skills

- **`github-integration`** - GitHub API integration
  - Handles issue and pull request creation via GitHub CLI
  - Processes templates and manages repository interactions
  - Used by `/create-issue` and `/create-pull-request` skills

## 💻 Installation

### 🌐 Universal Installation (All Platforms)

Install for Claude Code, Codex, and Gemini CLI in one step:

```zsh
git clone https://github.com/ruchernchong/agentic-slash-commands.git $HOME/agentic-slash-commands
cd $HOME/agentic-slash-commands
chmod +x install.sh
./install.sh
```

The universal installer will:

- Install skills for **Claude Code** (`$HOME/.claude/skills/`)
- Install prompts for **Codex** (`$HOME/.codex/prompts/`)
- Install commands for **Gemini CLI** (currently disabled - experimental feature)

Capabilities will be immediately available globally across all projects.

### 🎯 Platform-Specific Installation

To install for a specific platform only:

```zsh
cd $HOME/agentic-slash-commands

# Claude Code only
zsh scripts/install-claude.sh

# Codex only
zsh scripts/install-codex.sh

# Gemini CLI only
zsh scripts/install-gemini.sh
```

### 🔄 Updating Commands and Skills

To update to the latest version across all platforms:

```zsh
cd $HOME/agentic-slash-commands
git pull
```

No need to reinstall - the symlinks will automatically reflect the updates!

## 📖 Usage

Simply type `/` followed by the command name in your AI coding assistant:

**Claude Code:**

```
/build
/test
/lint
/setup
```

**Codex:**

```
/build  (autocompletes to /prompt:build)
/test   (autocompletes to /prompt:test)
/lint   (autocompletes to /prompt:lint)
/setup  (autocompletes to /prompt:setup)
```

Note: Codex commands use the `/prompt:` prefix, but typing `/command-name` will autocomplete accordingly.

**Gemini CLI:**
Commands work the same way after conversion to .toml format.

## ⚙️ How It Works

### 📦 Package Manager Detection

Commands automatically detect your package manager in this priority order:

1. **pnpm** (pnpm-lock.yaml present)
2. **bun** (bun.lockb present)
3. **yarn** (yarn.lock present)
4. **npm** (package-lock.json present or fallback)

### 🎯 Smart Execution

Each command:

1. Analyses your project configuration (package.json, config files)
2. Detects the appropriate tool or framework
3. Selects the best package manager
4. Executes with optimal settings
5. Provides actionable feedback

## 🏗️ Command Architecture

Commands are organised in a modular structure supporting multiple platforms:

```
.
├── commands/          # All slash command definitions
│   ├── build.md
│   ├── test.md
│   ├── lint.md
│   ├── setup.md
│   ├── clean.md
│   ├── commit.md
│   ├── create-branch.md
│   ├── create-issue.md
│   ├── create-pull-request.md
│   ├── update-issue.md
│   └── update-docs.md
├── scripts/           # Platform installers and helper scripts
│   ├── install-claude.sh    # Claude Code installer
│   ├── install-codex.sh     # Codex installer
│   ├── install-gemini.sh    # Gemini CLI installer
│   └── commit               # Standalone git commit helper
├── tests/             # Testing infrastructure
│   ├── README.md      # Testing documentation
│   ├── run-tests.sh   # Test runner script
│   └── docker-compose.yml   # Docker test environment
├── .github/           # GitHub workflows and templates
│   ├── workflows/
│   │   └── tests.yml  # CI/CD automation
│   └── ISSUE_TEMPLATE/
├── lib/               # Shared utilities
│   └── helpers.sh     # Common bash functions for installers
├── CLAUDE.md          # Project guidance for Claude Code
├── README.md          # This file
└── install.sh         # Universal installer for all platforms
```

Each command file uses this format:

```yaml
---
description: Command description shown in AI coding assistants
allowed-tools: List of tools the command can use
---

Command instructions and logic here...
```

## ⚙️ Configuration

### 🎨 Project-Specific Behaviour

Commands automatically adapt to:

- `package.json` scripts and dependencies
- Lock file detection (pnpm-lock.yaml, bun.lockb, yarn.lock, package-lock.json)
- ESLint and Prettier configuration
- Testing framework configuration
- Git repository state and GitHub templates

### 🔧 Local Settings

Permission management can be configured in `.claude/settings.local.json`.

## 🧪 Testing

This repository includes comprehensive testing infrastructure to ensure command quality across platforms.

### ▶️ Running Tests

```zsh
cd tests
./run-tests.sh
```

The test suite runs:

- **Docker tests**: Validates installation in Alpine Linux containers
- **macOS tests**: Tests native macOS environment
- **Command validation**: Checks YAML frontmatter and file formatting
- **Idempotence tests**: Ensures repeated installations work correctly

See [`tests/README.md`](tests/README.md) for detailed testing documentation.

## 🔄 CI/CD

All code changes are automatically validated through GitHub Actions:

### 🤖 Automated Workflows

**Location**: `.github/workflows/tests.yml`

**Validation Steps**:

1. **Docker Tests**: Runs full test suite in containerised environment
2. **macOS Tests**: Validates commands on macOS
3. **Command Validation**: Checks all command files for proper formatting

**Features**:

- Runs on every push and pull request to `main`
- Docker layer caching for faster builds
- Security-hardened with pinned GitHub Actions

This ensures all commands work correctly before merging changes.

## 🤝 Contributing

Contributions are welcome! Please ensure:

- New commands follow the existing architecture pattern
- Commands include smart detection where applicable
- YAML frontmatter is properly formatted
- All tests pass before submitting PR (`cd tests && ./run-tests.sh`)
- GitHub Actions workflows pass successfully

### 🔨 Development Workflow

1. Fork and clone the repository
2. Make your changes in the `commands/` directory
3. Run tests locally to validate: `cd tests && ./run-tests.sh`
4. Commit your changes
5. Push to your fork and submit a pull request

The CI/CD pipeline will automatically validate your changes.

## 📄 License

[MIT](LICENSE)

## 🙏 Acknowledgements

Originally built for [Claude Code](https://claude.ai/code) by Anthropic, now supporting multiple AI coding assistant
platforms.
