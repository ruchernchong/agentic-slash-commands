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
SKILLS_DIR="$ROOT_DIR/skills"
COMMANDS_INSTALL_DIR="${HOME}/.claude/commands"
SKILLS_INSTALL_DIR="${HOME}/.claude/skills"
SELECTED_COMMANDS=("$@")

# Ensure install directories exist
mkdir -p "$COMMANDS_INSTALL_DIR"
mkdir -p "$SKILLS_INSTALL_DIR"

echo -e "${BLUE}🔗 Installing Claude Code symlinks${NC}"
echo -e "${BLUE}Commands from: ${COMMANDS_DIR}${NC}"
echo -e "${BLUE}Commands to:   ${COMMANDS_INSTALL_DIR}${NC}"
echo -e "${BLUE}Skills from:   ${SKILLS_DIR}${NC}"
echo -e "${BLUE}Skills to:     ${SKILLS_INSTALL_DIR}${NC}"
echo ""

# Warning about overwriting
echo -e "${YELLOW}⚠️  WARNING: Existing commands and skills will be overwritten!${NC}"
echo -e "${YELLOW}   We will attempt to backup your existing content before overwriting.${NC}"
echo -e "${YELLOW}   Backups will be saved with a .bak extension.${NC}"
echo -e "${YELLOW}   Do note that this is not guaranteed and you should have your own backup.${NC}"
echo ""

# Reset counters
reset_counters

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
    create_symlink "$file" "$COMMANDS_INSTALL_DIR" "$filename"
done

# Install skills files (.md files from skills/ directory)
echo ""
echo -e "${BLUE}🎯 Installing skills:${NC}"
SKILLS_INSTALLED=0
if [ -d "$SKILLS_DIR" ]; then
    for file in "$SKILLS_DIR"/*.md; do
        [ -e "$file" ] || continue
        filename=$(basename "$file")

        # Create symlink for skill file
        create_symlink "$file" "$SKILLS_INSTALL_DIR" "$filename"
        ((SKILLS_INSTALLED++)) || true
    done

    if [ $SKILLS_INSTALLED -eq 0 ]; then
        echo -e "${YELLOW}⏭  No skills found to install${NC}"
    fi
else
    echo -e "${YELLOW}⏭  No skills directory found${NC}"
fi

# Print summary
print_summary

if [ $INSTALLED -gt 0 ] || [ $SKIPPED -gt 0 ]; then
    echo ""
    echo -e "${GREEN}🎉 Claude Code installation complete!${NC}"

    # List available commands
    list_commands "$COMMANDS_DIR" "/" "${DISPLAY_COMMANDS[@]}"

    # List available skills
    if [ -d "$SKILLS_DIR" ] && [ -n "$(ls -A "$SKILLS_DIR"/*.md 2>/dev/null)" ]; then
        echo ""
        echo "Available skills:"
        for file in "$SKILLS_DIR"/*.md; do
            [ -e "$file" ] || continue
            skillname=$(basename "$file" .md)
            echo "  • ${skillname}"
        done
    fi

    echo ""
    echo -e "${BLUE}💡 Tip: To update commands and skills, run 'git pull' in ${ROOT_DIR}${NC}"
fi

exit 0
