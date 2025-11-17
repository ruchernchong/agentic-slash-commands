#!/bin/bash

# Universal installer for agentic slash commands
# Installs commands for Claude Code and Codex (Gemini CLI disabled)

set -e

# Get script directory and source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

COMMANDS_DIR="$SCRIPT_DIR/commands"

echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Agentic Slash Commands - Universal Installer ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
echo ""

# Helper function to ask yes/no questions
ask_yes_no() {
    local prompt="$1"
    local default="$2"
    local response

    if [ "$default" = "y" ]; then
        read -p "$(echo -e ${BLUE}${prompt} \(Y/n\):${NC} )" response
        response=${response:-y}
    else
        read -p "$(echo -e ${BLUE}${prompt} \(y/N\):${NC} )" response
        response=${response:-n}
    fi

    case "$response" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

# Ask for each platform
echo -e "${BLUE}Select platforms to install:${NC}"
echo ""

INSTALL_CLAUDE=false
INSTALL_CODEX=false
INSTALL_GEMINI=false

if ask_yes_no "Install for Claude Code?" "y"; then
    INSTALL_CLAUDE=true
fi

if ask_yes_no "Install for Codex?" "y"; then
    INSTALL_CODEX=true
fi

# Gemini CLI is currently disabled, so we skip asking
# if ask_yes_no "Install for Gemini CLI?" "n"; then
#     INSTALL_GEMINI=true
# fi
echo ""

# Validate at least one platform selected
if [ "$INSTALL_CLAUDE" = false ] && [ "$INSTALL_CODEX" = false ] && [ "$INSTALL_GEMINI" = false ]; then
    echo ""
    echo -e "${RED}✗ No platforms selected. Exiting.${NC}"
    exit 1
fi

# Build list of all available commands (install all by default)
SELECTED_COMMANDS=()
for file in "$COMMANDS_DIR"/*.md; do
    [ -e "$file" ] || continue
    slug=$(basename "$file" .md)
    SELECTED_COMMANDS+=("$slug")
done

if [ ${#SELECTED_COMMANDS[@]} -eq 0 ]; then
    echo ""
    echo -e "${RED}✗ No slash commands found in ${COMMANDS_DIR}.${NC}"
    exit 1
fi

echo -e "${BLUE}Installing all ${#SELECTED_COMMANDS[@]} slash commands...${NC}"
echo ""

echo ""
echo -e "${BLUE}Installing selected platforms...${NC}"
echo ""

# Track overall success
TOTAL_SUCCESS=0
TOTAL_FAILED=0
TOTAL_SELECTED=0

# Install for Claude Code
if [ "$INSTALL_CLAUDE" = true ]; then
    ((TOTAL_SELECTED++))
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Installing: Claude Code${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    if bash "$SCRIPT_DIR/scripts/install-claude.sh" "${SELECTED_COMMANDS[@]}"; then
        ((TOTAL_SUCCESS++))
    else
        ((TOTAL_FAILED++))
    fi
    echo ""
fi

# Install for Codex
if [ "$INSTALL_CODEX" = true ]; then
    ((TOTAL_SELECTED++))
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Installing: Codex${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    if bash "$SCRIPT_DIR/scripts/install-codex.sh" "${SELECTED_COMMANDS[@]}"; then
        ((TOTAL_SUCCESS++))
    else
        ((TOTAL_FAILED++))
    fi
    echo ""
fi

# Install for Gemini CLI (DISABLED)
if [ "$INSTALL_GEMINI" = true ]; then
    ((TOTAL_SELECTED++))
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Installing: Gemini CLI${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    if bash "$SCRIPT_DIR/scripts/install-gemini.sh" "${SELECTED_COMMANDS[@]}"; then
        ((TOTAL_SUCCESS++))
    else
        ((TOTAL_FAILED++))
    fi
    echo ""
fi

# Final summary
echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            Installation Summary                ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}✓  Successful platforms: ${TOTAL_SUCCESS}/${TOTAL_SELECTED}${NC}"
if [ $TOTAL_FAILED -gt 0 ]; then
    echo -e "${RED}✗  Failed platforms:     ${TOTAL_FAILED}/${TOTAL_SELECTED}${NC}"
fi
echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo ""

# Show next steps only for installed platforms
echo -e "${BLUE}Next steps:${NC}"
if [ "$INSTALL_CLAUDE" = true ]; then
    echo -e "${BLUE}  • Claude Code: Ready to use${NC}"
fi
if [ "$INSTALL_CODEX" = true ]; then
    echo -e "${BLUE}  • Codex: Ready to use${NC}"
fi
if [ "$INSTALL_GEMINI" = true ]; then
    echo -e "${BLUE}  • Gemini CLI: Convert commands to .toml format${NC}"
fi
echo ""
echo -e "${BLUE}💡 To update commands across all platforms:${NC}"
echo -e "${BLUE}   cd ${SCRIPT_DIR} && git pull && bash install.sh${NC}"

exit 0
