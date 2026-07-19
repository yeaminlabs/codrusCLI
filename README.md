# CodrusCLI powered by Kimi models

[![Commit Activity](https://img.shields.io/github/commit-activity/w/MoonshotAI/codrus-cli)](https://github.com/MoonshotAI/codrus-cli/graphs/commit-activity)
[![Checks](https://img.shields.io/github/check-runs/MoonshotAI/codrus-cli/main)](https://github.com/MoonshotAI/codrus-cli/actions)

CodrusCLI powered by Kimi models is an AI agent that runs in the terminal, designed specifically to help modern enterprises and businesses automate software development tasks, integrate with internal knowledge, and streamline DevOps operations. It can read and edit code, execute shell commands, search and fetch web pages, and autonomously plan and adjust actions during execution.

## 🚀 For Businesses: Why CodrusCLI?

CodrusCLI is built to be a **Secure, Extensible Enterprise Terminal Assistant**. By leveraging MCP (Model Context Protocol), it seamlessly connects to your company's internal tools without leaving the terminal.

### 1. Secure Internal Knowledge Access (The "Company Brain" in the Terminal)
Connect CodrusCLI to your Jira, Confluence, or internal wikis via MCP. A developer or product manager can simply ask: *"What were the decisions made on the Q3 payment gateway migration?"* and CodrusCLI fetches context securely directly in the terminal.

### 2. Automated Developer Onboarding & DevOps
New hires can run `codrus setup-env`. The AI agent reads your company's internal onboarding markdown files, installs dependencies, configures Docker, and sets up AWS credentials—autonomously explaining what it's doing along the way.

### 3. Intelligent Cloud & Infrastructure Management
DevOps teams can use CodrusCLI to type: *"Scale the staging database instance to t3.medium and back up the current one"*. CodrusCLI proposes the exact AWS CLI or Terraform commands and waits for execution approval, severely reducing catastrophic human errors.

### 4. Automated Code Auditing & PR Reviews
Before pushing code, run `codrus audit`. The CLI checks the local git diff against your company's specific internal style guides and security policies (e.g., checking for leaked API keys or inefficient queries) and fixes them automatically.

### 5. Data Analytics for Non-Technical Staff
Staff can type *"Show me the daily active users from the European region over the last week"*. CodrusCLI connects to the read-only database replica, generates safe SQL, executes it, and renders a beautiful terminal graph or table.

---

## Getting Started

See [Getting Started](https://moonshotai.github.io/codrus-cli/en/guides/getting-started.html) for how to install and start using CodrusCLI powered by Kimi models.

## Key Features

### Shell command mode

CodrusCLI is not only a coding agent, but also a shell. You can switch the shell command mode by pressing `Ctrl-X`. In this mode, you can directly run shell commands without leaving CodrusCLI.

![](./docs/media/shell-mode.gif)

> [!NOTE]
> Built-in shell commands like `cd` are not supported yet.

### IDE integration via ACP

CodrusCLI supports [Agent Client Protocol](https://github.com/agentclientprotocol/agent-client-protocol) out of the box. You can use it together with any ACP-compatible editor or IDE.

To use CodrusCLI with ACP clients, run CodrusCLI in the terminal and send `/login` first. Then configure your ACP client to start CodrusCLI as an ACP agent server with the command `codrus acp`.

```json
{
  "agent_servers": {
    "CodrusCLI": {
      "type": "custom",
      "command": "codrus",
      "args": ["acp"],
      "env": {}
    }
  }
}
```

### Zsh integration

You can use CodrusCLI together with Zsh, to empower your shell experience with AI agent capabilities. Switch to agent mode by pressing `Ctrl-X`.

### MCP support

CodrusCLI supports MCP (Model Context Protocol) tools out of the box. You can manage MCP servers with the `codrus mcp` sub-command group.

```sh
# Add streamable HTTP server:
codrus mcp add --transport http context7 https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY: ctx7sk-your-key"

# Add stdio server:
codrus mcp add --transport stdio chrome-devtools -- npx chrome-devtools-mcp@latest

# List added MCP servers:
codrus mcp list
```

## Development

To develop CodrusCLI, run:

```sh
git clone https://github.com/yeaminlabs/codrusCLI.git
cd codrusCLI

make prepare  # prepare the development environment
```

Refer to the following commands after you make changes:

```sh
uv run codrus  # run CodrusCLI
make format    # format code
make check     # run linting and type checking
make test      # run tests
```
