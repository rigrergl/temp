---
name: setup
description: Install and configure the Playwright MCP server for browser automation in Claude Code. Use when the user wants to set up Playwright MCP for web scraping, testing, or browser automation tasks.
---

# Playwright MCP Server Setup Skill

This skill helps you install and configure the [Playwright MCP](https://github.com/microsoft/playwright-mcp) server for browser automation in Claude Code.

## What This Does

The Playwright MCP server enables Claude Code to:
- Navigate to websites
- Click elements and interact with pages
- Type text into forms
- Take accessibility snapshots
- Capture screenshots
- Automate browser tasks

## Prerequisites

- Node.js 18+ (check with `node --version`)
- Claude Code installed
- `jq` command-line tool (for JSON manipulation)

## Installation

### Automated Installation

Run the installation script located in this skill folder:

```bash
.claude/skills/setup/install-playwright-mcp.sh
```

This script will:
1. Verify Node.js version
2. Install Playwright Chromium browser
3. Configure the MCP server in `~/.claude.json`
4. Verify the configuration

### Manual Installation

If the script doesn't work, follow these steps:

#### Step 1: Install Playwright Browser

```bash
npx playwright install chromium
```

#### Step 2: Edit Claude Config

Add to `~/.claude.json` at the root level:

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest", "--headless"]
    }
  }
}
```

If `mcpServers` already exists, add the `playwright` entry inside it.

#### Step 3: Restart Claude Code

The MCP server loads on startup. Restart Claude Code after configuration.

## Verification

After installation, run:

```bash
claude mcp list
```

You should see `playwright` listed as a configured server.

## Configuration Options

Modify the `args` array in the config to customize behavior:

| Flag | Description |
|------|-------------|
| `--headless` | Run browser without visible window (required for VMs) |
| `--browser firefox` | Use Firefox instead of Chromium |
| `--browser webkit` | Use WebKit instead of Chromium |
| `--viewport-size 1280x720` | Set browser viewport size |
| `--user-data-dir /path` | Persist browser profile between sessions |
| `--isolated` | Keep browser profile in memory only |

### Example with Custom Viewport

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest", "--headless", "--viewport-size", "1920x1080"]
    }
  }
}
```

## Available Tools After Setup

Once configured, these tools become available:

- `mcp__playwright__browser_navigate` - Navigate to URLs
- `mcp__playwright__browser_click` - Click elements on page
- `mcp__playwright__browser_type` - Type text into inputs
- `mcp__playwright__browser_snapshot` - Get accessibility snapshot
- `mcp__playwright__browser_screenshot` - Capture page screenshot
- `mcp__playwright__browser_scroll` - Scroll the page
- `mcp__playwright__browser_select_option` - Select dropdown options
- `mcp__playwright__browser_hover` - Hover over elements

## Troubleshooting

### Server not loading?
- Check Node.js version: `node --version` (must be 18+)
- Validate JSON config: `cat ~/.claude.json | jq '.'`
- Ensure Playwright browsers installed: `npx playwright install chromium`

### Browser issues in VM/remote?
- Always use `--headless` flag for environments without displays
- Check if required system dependencies are installed:
  ```bash
  npx playwright install-deps chromium
  ```

### Permission errors?
- The `--headless` flag should avoid most permission issues
- If using Docker, ensure the container has appropriate capabilities

## Workflow

When a user asks to set up Playwright MCP:

1. Run the installation script
2. Verify with `claude mcp list`
3. Test a simple navigation to confirm it works
4. Inform user of available tools

## Example Usage After Setup

Once installed, you can use the Playwright tools like:

```
Navigate to https://example.com and take a screenshot
```

Claude will use `mcp__playwright__browser_navigate` followed by `mcp__playwright__browser_screenshot`.
