# Using in IDEs

CodrusCLI powered by Codrus models supports integration with IDEs through the [Agent Client Protocol (ACP)](https://agentclientprotocol.com/), allowing you to use AI-assisted programming directly within your editor.

## Prerequisites

Before configuring your IDE, make sure you have installed CodrusCLI powered by Codrus models and completed the `/login` configuration.

## Using in Zed

[Zed](https://zed.dev/) is a modern IDE that supports ACP.

Add the following to Zed's configuration file `~/.config/zed/settings.json`:

```json
{
  "agent_servers": {
    "CodrusCLI powered by Codrus models": {
      "type": "custom",
      "command": "codrus",
      "args": ["acp"],
      "env": {}
    }
  }
}
```

Configuration notes:

- `type`: Fixed value `"custom"`
- `command`: Path to the CodrusCLI powered by Codrus models command. If `codrus` is not in PATH, use the full path
- `args`: Startup arguments. `acp` enables ACP mode
- `env`: Environment variables, usually left empty

After saving the configuration, you can create CodrusCLI powered by Codrus models sessions in Zed's Agent panel.

## Using in JetBrains IDEs

JetBrains IDEs (IntelliJ IDEA, PyCharm, WebStorm, etc.) support ACP through the AI Chat plugin.

If you don't have a JetBrains AI subscription, you can enable `llm.enable.mock.response` in the Registry to use the AI Chat feature. Press Shift twice to search for "Registry" to open it.

In the AI Chat panel menu, click "Configure ACP agents" and add the following configuration:

```json
{
  "agent_servers": {
    "CodrusCLI powered by Codrus models": {
      "command": "~/.local/bin/codrus",
      "args": ["acp"],
      "env": {}
    }
  }
}
```

`command` needs to be the full path. You can run `which codrus` in the terminal to get it. After saving, you can select CodrusCLI powered by Codrus models in the AI Chat Agent selector.
