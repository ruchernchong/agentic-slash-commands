#!/bin/bash

# Universal installer for agentic slash commands
# Installs commands for Claude Code and Codex (Gemini CLI disabled)

set -e

# Get script directory and source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Agentic Slash Commands - Universal Installer ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Installing commands for supported platforms...${NC}"
echo -e "${YELLOW}Note: Gemini CLI installation is currently disabled${NC}"
echo ""

# Track overall success
TOTAL_SUCCESS=0
TOTAL_FAILED=0

# Install for Claude Code
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}1/3: Claude Code${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if bash "$SCRIPT_DIR/scripts/install-claude.sh"; then
    ((TOTAL_SUCCESS++))
else
    ((TOTAL_FAILED++))
fi
echo ""

# Install for Codex
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}2/2: Codex${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
if bash "$SCRIPT_DIR/scripts/install-codex.sh"; then
    ((TOTAL_SUCCESS++))
else
    ((TOTAL_FAILED++))
fi
echo ""

# Install for Gemini CLI (DISABLED)
# echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
# echo -e "${BLUE}3/3: Gemini CLI${NC}"
# echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
# if bash "$SCRIPT_DIR/scripts/install-gemini.sh"; then
#     ((TOTAL_SUCCESS++))
# else
#     ((TOTAL_FAILED++))
# fi
# echo ""

# Final summary
echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            Installation Summary                ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}✓  Successful platforms: ${TOTAL_SUCCESS}/2${NC}"
if [ $TOTAL_FAILED -gt 0 ]; then
    echo -e "${RED}✗  Failed platforms:     ${TOTAL_FAILED}/2${NC}"
fi
echo ""
echo -e "${GREEN}🎉 Universal installation complete!${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo -e "${BLUE}  • Claude Code: Ready to use${NC}"
echo -e "${BLUE}  • Codex: Ready to use${NC}"
# echo -e "${BLUE}  • Gemini CLI: Convert commands to .toml format${NC}"
echo ""
echo -e "${BLUE}💡 To update commands across all platforms:${NC}"
echo -e "${BLUE}   cd ${SCRIPT_DIR} && git pull && bash install.sh${NC}"

exit 0
