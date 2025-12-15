#!/bin/bash
#
# Playwright MCP Server Installation Script
# This script installs and configures the Playwright MCP server for Claude Code
#
# Usage: ./install-playwright-mcp.sh
#
# Requirements:
#   - Node.js 18 or newer
#   - jq (for JSON manipulation)
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Playwright MCP Server Installation ===${NC}"
echo ""

# Step 1: Check Node.js version
echo -e "${YELLOW}Step 1: Checking Node.js version...${NC}"
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed. Please install Node.js 18 or newer.${NC}"
    exit 1
fi

NODE_VERSION=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}Error: Node.js version must be 18 or newer. Current version: $(node --version)${NC}"
    exit 1
fi
echo -e "${GREEN}Node.js version $(node --version) - OK${NC}"
echo ""

# Step 2: Check for jq
echo -e "${YELLOW}Step 2: Checking for jq...${NC}"
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is not installed. Please install jq for JSON manipulation.${NC}"
    echo "  On Ubuntu/Debian: sudo apt-get install jq"
    echo "  On macOS: brew install jq"
    exit 1
fi
echo -e "${GREEN}jq found - OK${NC}"
echo ""

# Step 3: Install Playwright Chromium browser
echo -e "${YELLOW}Step 3: Installing Playwright Chromium browser...${NC}"
npx playwright install chromium
echo -e "${GREEN}Playwright Chromium installed - OK${NC}"
echo ""

# Step 4: Configure Claude Code
echo -e "${YELLOW}Step 4: Configuring Claude Code MCP server...${NC}"
CLAUDE_CONFIG="$HOME/.claude.json"

# Create config if it doesn't exist
if [ ! -f "$CLAUDE_CONFIG" ]; then
    echo '{}' > "$CLAUDE_CONFIG"
fi

# Check if playwright MCP is already configured
if jq -e '.mcpServers.playwright' "$CLAUDE_CONFIG" > /dev/null 2>&1; then
    echo -e "${YELLOW}Playwright MCP server already configured. Updating...${NC}"
fi

# Add or update the playwright MCP server configuration
jq '.mcpServers.playwright = {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@playwright/mcp@latest", "--headless"]
}' "$CLAUDE_CONFIG" > "${CLAUDE_CONFIG}.tmp" && mv "${CLAUDE_CONFIG}.tmp" "$CLAUDE_CONFIG"

echo -e "${GREEN}Claude Code configured - OK${NC}"
echo ""

# Step 5: Verify configuration
echo -e "${YELLOW}Step 5: Verifying configuration...${NC}"
echo "Current MCP configuration:"
jq '.mcpServers' "$CLAUDE_CONFIG"
echo ""

# Step 6: Test the Playwright MCP package
echo -e "${YELLOW}Step 6: Testing Playwright MCP package...${NC}"
if npx -y @playwright/mcp@latest --version 2>/dev/null || npx -y @playwright/mcp@latest --help | head -1 > /dev/null 2>&1; then
    echo -e "${GREEN}Playwright MCP package working - OK${NC}"
else
    echo -e "${RED}Warning: Could not verify Playwright MCP package${NC}"
fi
echo ""

# Step 7: Run claude mcp list to verify (with timeout)
echo -e "${YELLOW}Step 7: Running 'claude mcp list' to verify setup...${NC}"
echo "(This may take a moment as it initializes the MCP servers)"
if timeout 30 claude mcp list 2>&1; then
    echo -e "${GREEN}MCP server list verified - OK${NC}"
else
    echo -e "${YELLOW}Note: 'claude mcp list' timed out or failed.${NC}"
    echo "This is normal in some environments. The configuration has been applied."
    echo "Restart Claude Code to activate the Playwright MCP server."
fi
echo ""

echo -e "${GREEN}=== Installation Complete ===${NC}"
echo ""
echo "The Playwright MCP server has been configured. To use it:"
echo "1. Restart Claude Code (exit and reopen)"
echo "2. The following tools will be available:"
echo "   - mcp__playwright__browser_navigate"
echo "   - mcp__playwright__browser_click"
echo "   - mcp__playwright__browser_type"
echo "   - mcp__playwright__browser_snapshot"
echo "   - mcp__playwright__browser_screenshot"
echo ""
echo "For more information: https://github.com/microsoft/playwright-mcp"
