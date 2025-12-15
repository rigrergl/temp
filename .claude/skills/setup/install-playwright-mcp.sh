#!/bin/bash
# Playwright MCP Server Installation Script for Claude Code
# This script installs and configures the Playwright MCP server for browser automation

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "Playwright MCP Server Installation Script"
echo "=========================================="
echo ""

# Step 1: Check Node.js version
echo -e "${YELLOW}Step 1: Checking Node.js version...${NC}"
if ! command -v node &> /dev/null; then
    echo -e "${RED}ERROR: Node.js is not installed. Please install Node.js 18+ first.${NC}"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo -e "${RED}ERROR: Node.js version 18+ is required. Current version: $(node -v)${NC}"
    exit 1
fi
echo -e "${GREEN}Node.js version $(node -v) is compatible.${NC}"
echo ""

# Step 2: Install Playwright Chromium browser
echo -e "${YELLOW}Step 2: Installing Playwright Chromium browser...${NC}"
npx playwright install chromium
echo -e "${GREEN}Playwright Chromium installed successfully.${NC}"
echo ""

# Step 3: Configure Claude Code MCP server
echo -e "${YELLOW}Step 3: Configuring Claude Code MCP server...${NC}"

CLAUDE_CONFIG="$HOME/.claude.json"
MCP_CONFIG='{
  "playwright": {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@playwright/mcp@latest", "--headless"]
  }
}'

if [ -f "$CLAUDE_CONFIG" ]; then
    # Check if jq is available
    if command -v jq &> /dev/null; then
        # Backup existing config
        cp "$CLAUDE_CONFIG" "$CLAUDE_CONFIG.backup"

        # Check if mcpServers already exists
        if jq -e '.mcpServers' "$CLAUDE_CONFIG" > /dev/null 2>&1; then
            # Add playwright to existing mcpServers
            jq '.mcpServers.playwright = {
                "type": "stdio",
                "command": "npx",
                "args": ["-y", "@playwright/mcp@latest", "--headless"]
            }' "$CLAUDE_CONFIG" > "$CLAUDE_CONFIG.tmp" && mv "$CLAUDE_CONFIG.tmp" "$CLAUDE_CONFIG"
        else
            # Create mcpServers with playwright
            jq '.mcpServers = {
                "playwright": {
                    "type": "stdio",
                    "command": "npx",
                    "args": ["-y", "@playwright/mcp@latest", "--headless"]
                }
            }' "$CLAUDE_CONFIG" > "$CLAUDE_CONFIG.tmp" && mv "$CLAUDE_CONFIG.tmp" "$CLAUDE_CONFIG"
        fi
        echo -e "${GREEN}MCP server configuration added to $CLAUDE_CONFIG${NC}"
    else
        echo -e "${RED}ERROR: jq is not installed. Please install jq or manually add the MCP config.${NC}"
        echo ""
        echo "Add this to your ~/.claude.json at the root level:"
        echo ""
        echo '"mcpServers": '"$MCP_CONFIG"
        exit 1
    fi
else
    echo -e "${YELLOW}Creating new Claude config file...${NC}"
    echo '{"mcpServers": '"$MCP_CONFIG"'}' | jq '.' > "$CLAUDE_CONFIG"
    echo -e "${GREEN}Created $CLAUDE_CONFIG with MCP server configuration.${NC}"
fi
echo ""

# Step 4: Verify configuration
echo -e "${YELLOW}Step 4: Verifying configuration...${NC}"
if jq -e '.mcpServers.playwright' "$CLAUDE_CONFIG" > /dev/null 2>&1; then
    echo -e "${GREEN}Configuration verified - playwright MCP server found in config.${NC}"
    echo ""
    echo "Configuration details:"
    jq '.mcpServers.playwright' "$CLAUDE_CONFIG"
else
    echo -e "${RED}ERROR: Configuration verification failed.${NC}"
    exit 1
fi
echo ""

# Step 5: Test MCP server can start (optional quick test)
echo -e "${YELLOW}Step 5: Testing MCP server can initialize...${NC}"
# Just check that the npx command can resolve the package
if npx -y @playwright/mcp@latest --help > /dev/null 2>&1; then
    echo -e "${GREEN}MCP server package is accessible.${NC}"
else
    echo -e "${YELLOW}Warning: Could not verify MCP server package. It may still work.${NC}"
fi
echo ""

echo "=========================================="
echo -e "${GREEN}Installation Complete!${NC}"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Restart Claude Code for the MCP server to load"
echo "2. Run 'claude mcp list' to verify the server is registered"
echo "   (Note: This command may hang in non-interactive environments."
echo "    You can verify by checking: jq '.mcpServers' ~/.claude.json)"
echo "3. The Playwright tools will be available with 'mcp__playwright__' prefix"
echo ""
echo "Available tools after restart:"
echo "  - mcp__playwright__browser_navigate"
echo "  - mcp__playwright__browser_click"
echo "  - mcp__playwright__browser_type"
echo "  - mcp__playwright__browser_snapshot"
echo "  - mcp__playwright__browser_screenshot"
echo ""
