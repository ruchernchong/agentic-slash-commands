# Testing Guide

Safe, isolated testing environment for agentic slash commands using Docker.

## Overview

This test suite uses **Alpine Linux** (minimal ~5MB image) in Docker containers to provide a clean, reproducible environment for testing installation scripts without affecting your actual system.

## Prerequisites

- Docker installed and running
- Docker Compose (v2 or standalone)

## Quick Start

```bash
# Run all tests
cd test
./run-tests.sh

# Run specific test
./run-tests.sh claude      # Test Claude Code installation only
./run-tests.sh universal   # Test universal installer

# Rebuild and run tests
./run-tests.sh --build all

# Interactive testing
./run-tests.sh interactive
```

## Available Tests

### `claude`
Tests Claude Code installation script in isolation:
- Creates symlinks to `~/.claude/commands/`
- Verifies all commands are installed
- Checks symlink count

### `codex`
Tests Codex installation script in isolation:
- Creates symlinks to `~/.codex/commands/`
- Verifies all commands are installed
- Checks symlink count

### `universal`
Tests the universal installer (`install.sh`):
- Installs for both Claude Code and Codex
- Verifies both platforms are set up correctly
- Simulates user input (y/n answers)

### `idempotent`
Tests running the installer multiple times:
- Runs installer twice
- Verifies second run skips existing symlinks
- Ensures no duplicates or errors

### `symlinks`
Tests symlink integrity:
- Verifies all symlinks point to valid files
- Checks for broken links
- Validates symlink targets

### `interactive`
Starts an interactive bash session:
- Full access to test environment
- Manually run any installation script
- Inspect results with standard commands
- Type `exit` to leave

## Test Runner Options

```bash
./run-tests.sh [OPTIONS] [TEST]

Options:
  --build          Build Docker image before running tests
  --help, -h       Show help message

Tests:
  all              Run all tests (default)
  claude           Test Claude Code installation only
  codex            Test Codex installation only
  universal        Test universal installer
  idempotent       Test idempotency
  symlinks         Test symlink integrity
  interactive      Start interactive environment
```

## Examples

```bash
# Run all tests with fresh build
./run-tests.sh --build all

# Test only Claude Code installation
./run-tests.sh claude

# Manual testing in interactive mode
./run-tests.sh interactive
# Then inside container:
bash install.sh
ls -la ~/.claude/commands/
exit
```

## Docker Compose Services

You can also run tests directly with docker-compose:

```bash
# Run specific service
docker-compose run --rm test-claude

# Build and run
docker-compose build
docker-compose run --rm test-universal

# Interactive mode
docker-compose run --rm test-interactive
```

## Test Environment

Each test runs in a fresh Alpine Linux container with:
- `bash` - Shell interpreter
- `git` - Version control (if needed)
- `coreutils` - Standard Unix utilities
- Test user (`testuser`) - Non-root user simulation
- Repository mounted at `/home/testuser/agentic-slash-commands`

## Why Alpine Linux?

- **Minimal size**: ~5MB base image (vs 70MB+ for Ubuntu)
- **Fast**: Quick container startup and tear down
- **Sufficient**: Has all tools needed for bash scripts
- **Secure**: Smaller attack surface, regularly updated

## Cleaning Up

Docker automatically removes containers after tests (`--rm` flag).

To remove the test image:
```bash
docker rmi agentic-test-alpine
```

To clean all Docker resources:
```bash
docker system prune -a
```

## Troubleshooting

### Docker not found
```bash
# Install Docker Desktop from:
# https://www.docker.com/get-started
```

### Permission denied
```bash
# Make test runner executable
chmod +x run-tests.sh
```

### Tests failing
```bash
# Rebuild Docker image
./run-tests.sh --build all

# Run interactive mode to debug
./run-tests.sh interactive
```

## CI/CD Integration

Add to GitHub Actions:

```yaml
name: Test Installers
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: |
          cd test
          ./run-tests.sh --build all
```

## Development Workflow

1. **Make changes** to installation scripts
2. **Run tests** with `./run-tests.sh`
3. **Debug** with `./run-tests.sh interactive` if needed
4. **Commit** when all tests pass

## Notes

- Tests use volumes to mount the repository (changes reflect immediately)
- Each test starts with a clean home directory
- No need to rebuild image unless Dockerfile changes
- Tests are completely isolated from your host system
