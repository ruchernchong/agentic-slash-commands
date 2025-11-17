#!/bin/bash

# Symlink installer for Claude Code commands
# Creates symlinks from this repository to ~/.claude/commands/

set -e

# Get script directory and source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
source "$ROOT_DIR/lib/helpers.sh"

# Configuration
COMMANDS_DIR="$ROOT_DIR/commands"
INSTALL_DIR="${HOME}/.claude/commands"

# Ensure install directory exists
mkdir -p "$INSTALL_DIR"

echo -e "${BLUE}🔗 Installing Claude Code command symlinks${NC}"
echo -e "${BLUE}From: ${COMMANDS_DIR}${NC}"
echo -e "${BLUE}To:   ${INSTALL_DIR}${NC}"
echo ""

# Reset counters
reset_counters

# Install command files (.md files from commands/ directory)
echo -e "${BLUE}📦 Installing slash commands:${NC}"
for file in "$COMMANDS_DIR"/*.md; do
    # Skip if no .md files found
    [ -e "$file" ] || continue

    filename=$(basename "$file")

    # Create symlink for command file
    create_symlink "$file" "$INSTALL_DIR" "$filename"
done

# Print summary
print_summary

if [ $INSTALLED -gt 0 ] || [ $SKIPPED -gt 0 ]; then
    echo ""
    echo -e "${GREEN}🎉 Claude Code installation complete!${NC}"

    # List available commands
    list_commands "$COMMANDS_DIR" "/"

    echo ""
    echo -e "${BLUE}💡 Tip: To update commands, run 'git pull' in ${ROOT_DIR}${NC}"
fi

exit 0
