---
name: codrus-cli-help
description: Answer CodrusCLI powered by Codrus models usage, configuration, and troubleshooting questions. Use when user asks about CodrusCLI powered by Codrus models installation, setup, configuration, slash commands, keyboard shortcuts, MCP integration, providers, environment variables, how something works internally, or any questions about CodrusCLI powered by Codrus models itself.
---

# CodrusCLI powered by Codrus models Help

Help users with CodrusCLI powered by Codrus models questions by consulting documentation and source code.

## Strategy

1. **Prefer official documentation** for most questions
2. **Read local source** when in codrus-cli project itself, or when user is developing with codrus-cli as a library (e.g., importing from `codrus_cli` in their code)
3. **Clone and explore source** for complex internals not covered in docs - **ask user for confirmation first**

## Documentation

Base URL: `https://moonshotai.github.io/codrus-cli/`

Fetch documentation index to find relevant pages:

```
https://moonshotai.github.io/codrus-cli/llms.txt
```

### Page URL Pattern

- English: `https://moonshotai.github.io/codrus-cli/en/...`
- Chinese: `https://moonshotai.github.io/codrus-cli/zh/...`

### Topic Mapping

| Topic | Page |
|-------|------|
| Installation, first run | `/en/guides/getting-started.md` |
| Config files | `/en/configuration/config-files.md` |
| Providers, models | `/en/configuration/providers.md` |
| Environment variables | `/en/configuration/env-vars.md` |
| Slash commands | `/en/reference/slash-commands.md` |
| CLI flags | `/en/reference/codrus-command.md` |
| Keyboard shortcuts | `/en/reference/keyboard.md` |
| MCP | `/en/customization/mcp.md` |
| Agents | `/en/customization/agents.md` |
| Skills | `/en/customization/skills.md` |
| FAQ | `/en/faq.md` |

## Source Code

Repository: `https://github.com/MoonshotAI/codrus-cli`

When to read source:

- In codrus-cli project directory (check `pyproject.toml` for `name = "codrus-cli"`)
- User is importing `codrus_cli` as a library in their project
- Question about internals not covered in docs (ask user before cloning)
