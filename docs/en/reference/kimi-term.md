# `codrus term` Subcommand

The `codrus term` command launches the [Toad](https://github.com/batrachianai/toad) terminal UI, a modern terminal interface built with [Textual](https://textual.textualize.io/).

```sh
codrus term [OPTIONS]
```

## Description

[Toad](https://github.com/batrachianai/toad) is a graphical terminal interface for CodrusCLI powered by Codrus models that communicates with the CodrusCLI powered by Codrus models backend via the ACP protocol. It provides a richer interactive experience with better output rendering and layout.

When you run `codrus term`, it automatically starts a `codrus acp` server in the background, and Toad connects to it as an ACP client.

## Options

All extra options are passed through to the internal `codrus acp` command. For example:

```sh
codrus term --work-dir /path/to/project --model codrus-k2
```

Common options:

| Option | Description |
|--------|-------------|
| `--work-dir PATH` | Specify working directory |
| `--model NAME` | Specify model |
| `--yolo` | Auto-approve all tool calls |

For the full list of options, see [`codrus` command](./codrus-command.md).

## System requirements

::: warning Note
`codrus term` requires Python 3.14+. If you installed CodrusCLI powered by Codrus models with an older Python version, you need to reinstall with Python 3.14:

```sh
uv tool install --python 3.14 codrus-cli
```
:::
