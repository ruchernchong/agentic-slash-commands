#!/bin/bash

# Symlink installer for Claude Code commands
# Creates symlinks from this repository to ~/.claude/commands/

set -e

# Colours for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Colour

# Configuration
COMMANDS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${HOME}/.claude/commands"

# Ensure install directory exists
mkdir -p "$INSTALL_DIR"

echo -e "${BLUE}🔗 Installing Claude Code command symlinks${NC}"
echo -e "${BLUE}From: ${COMMANDS_DIR}${NC}"
echo -e "${BLUE}To:   ${INSTALL_DIR}${NC}"
echo ""

# Track installation
INSTALLED=0
SKIPPED=0
FAILED=0

# Function to create symlink
create_symlink() {
    local source_file="$1"
    local link_name="$2"
    local target_path="${INSTALL_DIR}/${link_name}"

    # Check if symlink already exists
    if [ -L "$target_path" ]; then
        if [ "$(readlink "$target_path")" = "$source_file" ]; then
            echo -e "${YELLOW}⏭  Skipped: ${link_name} (already linked)${NC}"
            ((SKIPPED++))
            return 0
        else
            echo -e "${YELLOW}⚠  Removing old symlink: ${link_name}${NC}"
            rm "$target_path"
        fi
    elif [ -e "$target_path" ]; then
        echo -e "${RED}✗  Failed: ${link_name} (file exists, not a symlink)${NC}"
        ((FAILED++))
        return 1
    fi

    # Create symlink
    if ln -s "$source_file" "$target_path"; then
        echo -e "${GREEN}✓  Installed: ${link_name}${NC}"
        ((INSTALLED++))
        return 0
    else
        echo -e "${RED}✗  Failed: ${link_name}${NC}"
        ((FAILED++))
        return 1
    fi
}

# Install command files (.md files from commands/ directory)
echo -e "${BLUE}📦 Installing slash commands:${NC}"
for file in "$COMMANDS_DIR"/commands/*.md; do
    # Skip if no .md files found
    [ -e "$file" ] || continue

    filename=$(basename "$file")

    # Create symlink for command file
    create_symlink "$file" "$filename"
done

echo ""

# Summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓  Installed: ${INSTALLED}${NC}"
if [ $SKIPPED -gt 0 ]; then
    echo -e "${YELLOW}⏭  Skipped:   ${SKIPPED}${NC}"
fi
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}✗  Failed:    ${FAILED}${NC}"
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $INSTALLED -gt 0 ] || [ $SKIPPED -gt 0 ]; then
    echo ""
    echo -e "${GREEN}🎉 Installation complete!${NC}"
    echo ""
    echo "Available commands in Claude Code:"
    for file in "$COMMANDS_DIR"/commands/*.md; do
        [ -e "$file" ] || continue
        filename=$(basename "$file" .md)
        echo "  • /${filename}"
    done
    echo ""
    echo -e "${BLUE}💡 Tip: To update commands, run 'git pull' in ${COMMANDS_DIR}${NC}"
fi

exit 0
