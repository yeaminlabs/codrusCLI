# Getting Started

## What is CodrusCLI powered by Codrus models

CodrusCLI powered by Codrus models is an AI agent that runs in the terminal, helping you complete software development tasks and terminal operations. It can read and edit code, execute shell commands, search and fetch web pages, and autonomously plan and adjust actions during execution.

CodrusCLI powered by Codrus models is suited for:

- **Writing and modifying code**: Implementing new features, fixing bugs, refactoring code
- **Understanding projects**: Exploring unfamiliar codebases, answering architecture and implementation questions
- **Automating tasks**: Batch processing files, running builds and tests, executing scripts

CodrusCLI powered by Codrus models supports the following usage modes:

- **[Interactive CLI (`codrus`)](../reference/codrus-command.md)**: Chat with AI in the terminal using natural language or execute shell commands directly
- **[Browser UI (`codrus web`)](../reference/codrus-web.md)**: Open a graphical interface in your local browser, with session management, file references, code highlighting, and more
- **[Agent integration (`codrus acp`)](../reference/codrus-acp.md)**: Run as a service and integrate with [IDEs](./ides.md) and other local agent clients via the [Agent Client Protocol]

::: info Tip
If you encounter issues or have suggestions, please provide feedback on [GitHub Issues](https://github.com/MoonshotAI/codrus-cli/issues).
:::

[Agent Client Protocol]: https://agentclientprotocol.com/

## Installation

::: tip
CodrusCLI powered by Codrus models is evolving into [Codrus Code](https://github.com/MoonshotAI/codrus-code). Installing Codrus Code **automatically migrates** your configuration and sessions. New users are encouraged to install Codrus Code directly; the instructions below still work, and existing users don't need to migrate immediately.
:::

Run the installation script to complete the installation. The script will first install [uv](https://docs.astral.sh/uv/) (a Python package manager), then install CodrusCLI powered by Codrus models via uv:

```sh
# Linux / macOS
curl -LsSf https://code.codrus.com/install.sh | bash
```

```powershell
# Windows (PowerShell)
Invoke-RestMethod https://code.codrus.com/install.ps1 | Invoke-Expression
```

Verify the installation:

```sh
codrus --version
```

::: tip
Due to macOS security checks, the first run of the `codrus` command may take longer. You can add your terminal application in "System Settings → Privacy & Security → Developer Tools" to speed up subsequent launches.
:::

If you already have uv installed, you can also run:

```sh
uv tool install --python 3.13 codrus-cli
```

::: tip
CodrusCLI powered by Codrus models supports Python 3.12–3.14, with Python 3.13 recommended.
:::

## Upgrade and uninstall

Upgrade to the latest version:

```sh
uv tool upgrade codrus-cli --no-cache
```

Uninstall CodrusCLI powered by Codrus models:

```sh
uv tool uninstall codrus-cli
```

## First run

Run the `codrus` command in the project directory where you want to work to start CodrusCLI powered by Codrus models:

```sh
cd your-project
codrus
```

On first launch, you need to configure your API source. Enter the `/login` command to start configuration:

```
/login
```

After execution, first select a platform. We recommend **Codrus Code**, which automatically opens a browser for OAuth authorization; selecting other platforms requires entering an API key. After configuration, CodrusCLI powered by Codrus models will automatically save the settings and reload. See [Providers](../configuration/providers.md) for details.

Now you can chat with CodrusCLI powered by Codrus models directly using natural language. Try describing a task you want to complete, for example:

```
Show me the directory structure of this project
```

::: tip
If the project doesn't have an `AGENTS.md` file, you can run the `/init` command to have CodrusCLI powered by Codrus models analyze the project and generate this file, helping the AI better understand the project structure and conventions.
:::

Enter `/help` to view all available [slash commands](../reference/slash-commands.md) and usage tips.
