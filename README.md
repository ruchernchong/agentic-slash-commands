# Claude Code Commands

A collection of intelligent slash commands for [Claude Code](https://claude.ai/code) optimised for JavaScript/TypeScript development workflows. Each command uses smart detection to identify project configuration and automatically execute appropriate tools with your preferred package manager.

## Features

- **Smart Package Manager Detection**: Automatically detects and uses pnpm, bun, yarn, or npm based on lock files
- **Framework Aware**: Recognises and adapts to React, Vue, Next.js, Nuxt, and more
- **Zero Configuration**: Works out of the box with standard JavaScript/TypeScript projects
- **Consistent Conventions**: All documentation and code follows English (Singapore/UK) spelling

## Available Commands

### Core Development

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

### Project Management

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

- **`/create-pull-request`** - Automated PR creation
  - Analyses commits for description generation
  - Follows repository conventions

- **`/update-docs`** - Documentation maintenance
  - Updates CLAUDE.md and README.md
  - Keeps documentation in sync

## Installation

1. Clone this repository to a permanent location:
   ```bash
   git clone https://github.com/ruchernchong/agentic-slash-commands.git $HOME/agentic-slash-commands
   ```

2. Run the installation script to create symlinks:
   ```bash
   cd $HOME/agentic-slash-commands
   chmod +x install.sh
   ./install.sh
   ```

3. The commands will be immediately available in Claude Code globally across all projects.

### Updating Commands

To update to the latest version:

```bash
cd $HOME/agentic-slash-commands
git pull
```

No need to reinstall - the symlinks will automatically reflect the updates!

## Usage

Simply type `/` followed by the command name in Claude Code:

```
/build
/test
/lint
/setup
```

## How It Works

### Package Manager Detection

Commands automatically detect your package manager in this priority order:

1. **pnpm** (pnpm-lock.yaml present)
2. **bun** (bun.lockb present)
3. **yarn** (yarn.lock present)
4. **npm** (package-lock.json present or fallback)

### Smart Execution

Each command:
1. Analyses your project configuration (package.json, config files)
2. Detects the appropriate tool or framework
3. Selects the best package manager
4. Executes with optimal settings
5. Provides actionable feedback

## Command Architecture

Commands are organised in the `commands/` directory and defined using markdown files with YAML frontmatter:

```
.
├── commands/          # All slash command definitions
│   ├── build.md
│   ├── test.md
│   └── ...
├── scripts/           # Helper scripts
│   └── commit
├── CLAUDE.md          # Project guidance for Claude Code
├── README.md
└── install.sh         # Symlink installer
```

Each command file uses this format:

```yaml
---
description: Command description shown in Claude Code
allowed-tools: List of tools the command can use
---

Command instructions and logic here...
```

## Configuration

### Project-Specific Behaviour

Commands automatically adapt to:
- `package.json` scripts and dependencies
- Lock file detection (pnpm-lock.yaml, bun.lockb, yarn.lock, package-lock.json)
- ESLint and Prettier configuration
- Testing framework configuration
- Git repository state and GitHub templates

### Local Settings

Permission management can be configured in `.claude/settings.local.json`.

## Language Conventions

This repository follows **English (Singapore/UK)** spelling conventions:
- "organise" not "organize"
- "optimise" not "optimize"
- "behaviour" not "behavior"
- "colour" not "color"

## Contributing

Contributions are welcome! Please ensure:
- New commands follow the existing architecture pattern
- Documentation uses English (SG/UK) spelling
- Commands include smart detection where applicable
- YAML frontmatter is properly formatted

## License

MIT

## Acknowledgements

Built for [Claude Code](https://claude.ai/code) by Anthropic.
