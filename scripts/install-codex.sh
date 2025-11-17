#!/bin/bash

# Symlink installer for Codex commands
# Creates symlinks from this repository to ~/.codex/prompts/

set -e

# Get script directory and source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
source "$ROOT_DIR/lib/helpers.sh"

# Configuration
COMMANDS_DIR="$ROOT_DIR/commands"
INSTALL_DIR="${HOME}/.codex/prompts"
SELECTED_COMMANDS=("$@")

# Ensure install directory exists
mkdir -p "$INSTALL_DIR"

echo -e "${BLUE}🔗 Installing Codex command symlinks${NC}"
echo -e "${BLUE}From: ${COMMANDS_DIR}${NC}"
echo -e "${BLUE}To:   ${INSTALL_DIR}${NC}"
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
    echo -e "${GREEN}🎉 Codex installation complete!${NC}"

    # List available commands
    list_commands "$COMMANDS_DIR" "/" "${DISPLAY_COMMANDS[@]}"

    echo ""
    echo -e "${BLUE}💡 Tip: To update commands, run 'git pull' in ${ROOT_DIR}${NC}"
fi

exit 0
