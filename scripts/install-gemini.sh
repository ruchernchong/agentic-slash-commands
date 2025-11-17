#!/bin/bash

# Symlink installer for Gemini CLI commands
# Creates symlinks from this repository to ~/.gemini/commands/

set -e

# Get script directory and source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
source "$ROOT_DIR/lib/helpers.sh"

# Configuration
COMMANDS_DIR="$ROOT_DIR/commands"
INSTALL_DIR="${HOME}/.gemini/commands"
SELECTED_COMMANDS=("$@")

# Ensure install directory exists
mkdir -p "$INSTALL_DIR"

echo -e "${BLUE}🔗 Installing Gemini CLI command symlinks${NC}"
echo -e "${BLUE}From: ${COMMANDS_DIR}${NC}"
echo -e "${BLUE}To:   ${INSTALL_DIR}${NC}"
echo ""

# Warning about .toml requirement
echo -e "${YELLOW}⚠️  Note: Gemini CLI requires .toml files${NC}"
echo -e "${YELLOW}   Current commands are in .md format${NC}"
echo -e "${YELLOW}   Commands will need to be converted to work with Gemini${NC}"
echo ""

# Reset counters
reset_counters

# Clean up old symlinks first
cleanup_symlinks "$INSTALL_DIR"

# Build list of command files to install
COMMAND_FILES=()
if [ ${#SELECTED_COMMANDS[@]} -gt 0 ]; then
    for cmd in "${SELECTED_COMMANDS[@]}"; do
        [ -n "$cmd" ] || continue
        file="$COMMANDS_DIR/${cmd}.md"
        if [ -f "$file" ]; then
            COMMAND_FILES+=("$file")
        else
            echo -e "${YELLOW}⏭  Skipped: /${cmd} (not found)${NC}"
        fi
    done
else
    for file in "$COMMANDS_DIR"/*.md; do
        [ -e "$file" ] || continue
        COMMAND_FILES+=("$file")
    done
fi

if [ ${#COMMAND_FILES[@]} -eq 0 ]; then
    echo -e "${RED}✗  No command files selected for installation${NC}"
    exit 1
fi

DISPLAY_COMMANDS=()
for file in "${COMMAND_FILES[@]}"; do
    DISPLAY_COMMANDS+=("$(basename "$file" .md)")
done

# Install command files (.md files from commands/ directory)
# Note: These will need to be converted to .toml format for Gemini
echo -e "${BLUE}📦 Installing slash commands:${NC}"
for file in "${COMMAND_FILES[@]}"; do
    filename=$(basename "$file")

    # Create symlink for command file
    create_symlink "$file" "$INSTALL_DIR" "$filename"
done

# Print summary
print_summary

if [ $INSTALLED -gt 0 ] || [ $SKIPPED -gt 0 ]; then
    echo ""
    echo -e "${YELLOW}⚠️  Gemini installation incomplete${NC}"
    echo -e "${YELLOW}   Commands are symlinked but need .toml conversion${NC}"

    # List available commands
    list_commands "$COMMANDS_DIR" "/" "${DISPLAY_COMMANDS[@]}"

    echo ""
    echo -e "${BLUE}💡 Next steps:${NC}"
    echo -e "${BLUE}   1. Convert .md files to .toml format${NC}"
    echo -e "${BLUE}   2. To update, run 'git pull' in ${ROOT_DIR}${NC}"
fi

exit 0
