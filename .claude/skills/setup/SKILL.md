---
name: "setup"
description: "Install and configure the Playwright MCP server for browser automation in Claude Code. Use this skill when you need to set up Playwright MCP for web browsing, taking screenshots, or automating browser interactions."
---

# Playwright MCP Server Setup

This skill installs and configures the [Playwright MCP](https://github.com/microsoft/playwright-mcp) server for Claude Code, enabling browser automation capabilities.

## What This Skill Does

The setup process will:
1. Verify Node.js 18+ is installed
2. Install Playwright Chromium browser
3. Configure Claude Code with the Playwright MCP server
4. Verify the installation

## Installation

Run the installation script located in this skill folder:

```bash
bash /home/user/temp/.claude/skills/setup/install-playwright-mcp.sh
```

Or make it executable and run directly:

```bash
chmod +x /home/user/temp/.claude/skills/setup/install-playwright-mcp.sh
./install-playwright-mcp.sh
```

## Requirements

- **Node.js 18+**: Check with `node --version`
- **jq**: JSON processor for config manipulation
- **Claude Code**: The CLI tool must be available

## Manual Installation Steps

If you prefer to install manually:

### Step 1: Install Playwright Chromium Browser

```bash
npx playwright install chromium
```

### Step 2: Configure Claude Code

Add the Playwright MCP server to `~/.claude.json`:

```bash
# Using jq to add the configuration
jq '.mcpServers.playwright = {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@playwright/mcp@latest", "--headless"]
}' ~/.claude.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json
```

Or manually edit `~/.claude.json` to include:

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

### Step 3: Restart Claude Code

Exit and restart Claude Code for the MCP server to load.

### Step 4: Verify Installation

```bash
claude mcp list
```

You should see `playwright` in the list of configured servers.

## Configuration Options

Common flags you can add to the `args` array in the config:

| Flag | Description |
|------|-------------|
| `--headless` | Run browser without visible window (recommended for VMs/servers) |
| `--browser chrome` | Use Chrome instead of Chromium |
| `--browser firefox` | Use Firefox (requires `npx playwright install firefox`) |
| `--viewport-size 1280x720` | Set browser viewport size |
| `--user-data-dir /path/to/profile` | Persist browser data between sessions |
| `--isolated` | Keep browser profile in memory only |

## Available Tools After Installation

Once configured, you'll have access to:

- `mcp__playwright__browser_navigate` - Navigate to URLs
- `mcp__playwright__browser_click` - Click elements
- `mcp__playwright__browser_type` - Type text into inputs
- `mcp__playwright__browser_snapshot` - Take accessibility snapshots
- `mcp__playwright__browser_screenshot` - Capture screenshots
- `mcp__playwright__browser_wait` - Wait for elements or conditions
- `mcp__playwright__browser_select_option` - Select dropdown options

## Troubleshooting

### Server not loading?
- Verify Node.js version: `node --version` (must be 18+)
- Check the config file is valid JSON: `cat ~/.claude.json | python3 -m json.tool`
- Ensure Playwright browsers are installed: `npx playwright install chromium`

### Browser issues?
- For VMs/servers without displays, always use `--headless`
- If getting permission errors, you may need to run with `--no-sandbox` (security implications)

### `claude mcp list` hangs?
- This can happen in some environments where MCP server initialization takes time
- Verify your configuration is correct by checking: `jq '.mcpServers' ~/.claude.json`
- Restart Claude Code and wait for MCP servers to initialize

## More Information

- [Playwright MCP GitHub Repository](https://github.com/microsoft/playwright-mcp)
- [Playwright Documentation](https://playwright.dev/)
