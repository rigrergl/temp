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

## Quick Setup (Recommended)

Use the automated installation script:

```bash
.claude/skills/setup/install-playwright-mcp.sh
```

This script handles everything automatically. After running, restart Claude Code and verify with:

```bash
claude mcp list
```

You should see `playwright` listed as a configured server.

---

## Manual Setup

If you prefer manual installation or the script doesn't work, follow these steps:

### Requirements

- Node.js 18+ (check with `node --version`)
- Claude Code
- `jq` (for JSON manipulation)

### Step 1: Install Playwright Browser

Run this command to install Chromium (required for the MCP server):

```bash
npx playwright install chromium
```

This installs the browser to `~/.cache/ms-playwright/`.

### Step 2: Configure Claude Code

Add the Playwright MCP server to your Claude Code configuration. Edit `~/.claude.json` and add an `mcpServers` section at the root level:

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

### Configuration Options

Common flags you can add to the `args` array:

| Flag | Description |
|------|-------------|
| `--headless` | Run browser without visible window (recommended for VMs) |
| `--browser chrome` | Use Chrome instead of Chromium |
| `--browser firefox` | Use Firefox (requires `npx playwright install firefox`) |
| `--viewport-size 1280x720` | Set browser viewport size |
| `--user-data-dir /path/to/profile` | Persist browser data between sessions |
| `--isolated` | Keep browser profile in memory only |

### Example with Multiple Options

```json
{
  "mcpServers": {
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@playwright/mcp@latest",
        "--headless",
        "--viewport-size", "1280x720"
      ]
    }
  }
}
```

### Step 3: Restart Claude Code

After editing the configuration, restart Claude Code for the MCP server to load. The Playwright tools will then be available with the `mcp__playwright__` prefix.

## Available Tools

Once configured, you'll have access to browser automation tools including:

- `mcp__playwright__browser_navigate` - Navigate to URLs
- `mcp__playwright__browser_click` - Click elements
- `mcp__playwright__browser_type` - Type text into inputs
- `mcp__playwright__browser_snapshot` - Take accessibility snapshots
- `mcp__playwright__browser_screenshot` - Capture screenshots

## Troubleshooting

**Server not loading?**
- Verify Node.js version: `node --version` (must be 18+)
- Check the config file is valid JSON: `cat ~/.claude.json | python3 -m json.tool`
- Ensure Playwright browsers are installed: `npx playwright install chromium`

**Browser issues?**
- For VMs/servers without displays, always use `--headless`
- If using `--no-sandbox`, be aware of security implications
