# HTML Game Prompt Template

Add this to your game prompts:

---

**Technical Requirements:** Create the game as a single HTML file with all JavaScript and CSS embedded inline (no external files). Ensure it's mobile-friendly with touch controls for phone browsers. After creating the file, provide an HTML preview link using this format: `https://htmlpreview.github.io/?https://raw.githubusercontent.com/[owner]/[repo]/[branch]/[filename].html`

---

## Example Usage

"Make a space invaders game with cats. **Technical Requirements:** Create the game as a single HTML file with all JavaScript and CSS embedded inline (no external files). Ensure it's mobile-friendly with touch controls for phone browsers. After creating the file, provide an HTML preview link using this format: `https://htmlpreview.github.io/?https://raw.githubusercontent.com/[owner]/[repo]/[branch]/[filename].html`"

---

# Playwright MCP Server Setup

Instructions for installing the [Playwright MCP](https://github.com/microsoft/playwright-mcp) server in Claude Code for browser automation.

## Quick Setup (Automated)

Use the **setup skill** for automated installation:

```bash
# Run the installation script
bash .claude/skills/setup/install-playwright-mcp.sh
```

Or invoke the skill: `/skill setup`

The script will:
1. Verify Node.js 18+ is installed
2. Install Playwright Chromium browser
3. Configure Claude Code with the MCP server
4. Verify the installation

## Manual Setup

### Requirements

- Node.js 18+ (check with `node --version`)
- jq (for JSON manipulation)
- Claude Code

### Step 1: Install Playwright Browser

```bash
npx playwright install chromium
```

This installs the browser to `~/.cache/ms-playwright/`.

### Step 2: Configure Claude Code

Add the Playwright MCP server to `~/.claude.json`:

```bash
# Using jq (recommended)
jq '.mcpServers.playwright = {
    "type": "stdio",
    "command": "npx",
    "args": ["-y", "@playwright/mcp@latest", "--headless"]
}' ~/.claude.json > ~/.claude.json.tmp && mv ~/.claude.json.tmp ~/.claude.json
```

Or manually edit `~/.claude.json`:

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

Restart Claude Code for the MCP server to load.

### Step 4: Verify Installation

```bash
claude mcp list
```

## Configuration Options

| Flag | Description |
|------|-------------|
| `--headless` | Run browser without visible window (recommended for VMs) |
| `--browser chrome` | Use Chrome instead of Chromium |
| `--browser firefox` | Use Firefox (requires `npx playwright install firefox`) |
| `--viewport-size 1280x720` | Set browser viewport size |
| `--user-data-dir /path/to/profile` | Persist browser data between sessions |
| `--isolated` | Keep browser profile in memory only |

## Available Tools

Once configured, you'll have access to:

- `mcp__playwright__browser_navigate` - Navigate to URLs
- `mcp__playwright__browser_click` - Click elements
- `mcp__playwright__browser_type` - Type text into inputs
- `mcp__playwright__browser_snapshot` - Take accessibility snapshots
- `mcp__playwright__browser_screenshot` - Capture screenshots

## Troubleshooting

**Server not loading?**
- Verify Node.js version: `node --version` (must be 18+)
- Check config is valid JSON: `cat ~/.claude.json | python3 -m json.tool`
- Ensure Playwright browsers are installed: `npx playwright install chromium`

**Browser issues?**
- For VMs/servers without displays, always use `--headless`

**`claude mcp list` hangs?**
- This can happen in some environments where MCP initialization takes time
- Verify config: `jq '.mcpServers' ~/.claude.json`
- Restart Claude Code and wait for MCP servers to initialize
