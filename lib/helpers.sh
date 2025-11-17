#!/bin/bash

# Shared installation helper functions for agentic slash commands
# Source this file in platform-specific installation scripts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters for tracking installation
INSTALLED=0
SKIPPED=0
FAILED=0

# Function to create symlink
# Usage: create_symlink <source_file> <target_directory> <link_name>
create_symlink() {
    local source_file="$1"
    local target_dir="$2"
    local link_name="$3"
    local target_path="${target_dir}/${link_name}"

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

# Function to clean up old symlinks in a directory
# Usage: cleanup_symlinks <directory>
cleanup_symlinks() {
    local dir="$1"

    if [ ! -d "$dir" ]; then
        return 0
    fi

    echo -e "${BLUE}🧹 Cleaning up old symlinks in ${dir}${NC}"

    local removed=0
    for link in "$dir"/*.md; do
        [ -L "$link" ] || continue
        rm "$link"
        ((removed++))
    done

    if [ $removed -gt 0 ]; then
        echo -e "${GREEN}✓  Removed ${removed} old symlink(s)${NC}"
    fi
    echo ""
}

# Function to print installation summary
# Usage: print_summary
print_summary() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓  Installed: ${INSTALLED}${NC}"
    if [ $SKIPPED -gt 0 ]; then
        echo -e "${YELLOW}⏭  Skipped:   ${SKIPPED}${NC}"
    fi
    if [ $FAILED -gt 0 ]; then
        echo -e "${RED}✗  Failed:    ${FAILED}${NC}"
    fi
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Function to list available commands
# Usage: list_commands <commands_directory> <command_prefix>
list_commands() {
    local commands_dir="$1"
    local prefix="$2"

    echo ""
    echo "Available commands:"
    for file in "$commands_dir"/*.md; do
        [ -e "$file" ] || continue
        filename=$(basename "$file" .md)
        echo "  • ${prefix}${filename}"
    done
}

# Reset counters (call this at the start of each script)
reset_counters() {
    INSTALLED=0
    SKIPPED=0
    FAILED=0
}
