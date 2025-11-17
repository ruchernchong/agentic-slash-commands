#!/bin/bash

# Test runner for agentic slash commands
# Uses Docker Compose to run tests in isolated Alpine Linux containers

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Check if docker is available
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Error: Docker is not installed or not in PATH${NC}"
    echo "Please install Docker from https://www.docker.com/get-started"
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null 2>&1; then
    echo -e "${RED}Error: Docker Compose is not installed${NC}"
    echo "Please install Docker Compose"
    exit 1
fi

# Use docker compose or docker-compose
COMPOSE_CMD="docker compose"
if ! docker compose version &> /dev/null 2>&1; then
    COMPOSE_CMD="docker-compose"
fi

# Parse arguments
TEST_TARGET="all"
BUILD_FIRST=false

show_help() {
    echo "Usage: $0 [OPTIONS] [TEST]"
    echo ""
    echo "Run tests in isolated Docker containers"
    echo ""
    echo "Tests:"
    echo "  all              Run all tests (default)"
    echo "  claude           Test Claude Code installation only"
    echo "  codex            Test Codex installation only"
    echo "  universal        Test universal installer (both platforms)"
    echo "  idempotent       Test running installer twice (idempotency)"
    echo "  symlinks         Test symlink integrity"
    echo "  interactive      Start interactive test environment"
    echo ""
    echo "Options:"
    echo "  --build          Build Docker image before running tests"
    echo "  --help, -h       Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Run all tests"
    echo "  $0 claude             # Test Claude Code only"
    echo "  $0 --build all        # Rebuild image and run all tests"
    echo "  $0 interactive        # Start interactive bash session"
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --build)
            BUILD_FIRST=true
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        all|claude|codex|universal|idempotent|symlinks|interactive)
            TEST_TARGET="$1"
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            echo "Run with --help for usage information"
            exit 1
            ;;
    esac
done

# Build if requested
if [ "$BUILD_FIRST" = true ]; then
    echo -e "${BLUE}Building Docker image...${NC}"
    $COMPOSE_CMD build
    echo ""
fi

# Run tests
echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Agentic Slash Commands - Docker Test Suite   ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
echo ""

case $TEST_TARGET in
    all)
        echo -e "${BLUE}Running all tests...${NC}"
        echo ""

        tests=("claude" "codex" "universal" "idempotent" "symlinks")
        failed_tests=()

        for test in "${tests[@]}"; do
            echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            echo -e "${BLUE}Running: $test${NC}"
            echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            if $COMPOSE_CMD run --rm "$test"; then
                echo -e "${GREEN}✓ $test passed${NC}"
            else
                echo -e "${RED}✗ $test failed${NC}"
                failed_tests+=("$test")
            fi
            echo ""
        done

        # Summary
        echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
        echo -e "${BLUE}║              Test Summary                      ║${NC}"
        echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
        echo ""

        total=${#tests[@]}
        passed=$((total - ${#failed_tests[@]}))

        echo -e "${GREEN}✓ Passed: $passed/$total${NC}"

        if [ ${#failed_tests[@]} -gt 0 ]; then
            echo -e "${RED}✗ Failed: ${#failed_tests[@]}/$total${NC}"
            echo -e "${RED}Failed tests: ${failed_tests[*]}${NC}"
            exit 1
        else
            echo -e "${GREEN}✅ All tests passed!${NC}"
        fi
        ;;

    claude)
        $COMPOSE_CMD run --rm claude
        ;;

    codex)
        $COMPOSE_CMD run --rm codex
        ;;

    universal)
        $COMPOSE_CMD run --rm universal
        ;;

    idempotent)
        $COMPOSE_CMD run --rm idempotent
        ;;

    symlinks)
        $COMPOSE_CMD run --rm symlinks
        ;;

    interactive)
        echo -e "${BLUE}Starting interactive test environment...${NC}"
        echo -e "${BLUE}Available commands:${NC}"
        echo -e "${BLUE}  - bash install.sh${NC}"
        echo -e "${BLUE}  - bash scripts/install-claude.sh${NC}"
        echo -e "${BLUE}  - bash scripts/install-codex.sh${NC}"
        echo -e "${BLUE}  - ls ~/.claude/commands/${NC}"
        echo -e "${BLUE}  - exit (to leave)${NC}"
        echo ""
        $COMPOSE_CMD run --rm interactive
        ;;
esac
