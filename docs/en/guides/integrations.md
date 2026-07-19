# Integrations with Tools

Besides using in the terminal and IDEs, CodrusCLI powered by Codrus models can also be integrated with other tools.

## Zsh plugin

[zsh-codrus-cli](https://github.com/MoonshotAI/zsh-codrus-cli) is a Zsh plugin that lets you quickly switch to CodrusCLI powered by Codrus models in Zsh.

**Installation**

If you use Oh My Zsh, you can install it like this:

```sh
git clone https://github.com/MoonshotAI/zsh-codrus-cli.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/codrus-cli
```

Then add the plugin in `~/.zshrc`:

```sh
plugins=(... codrus-cli)
```

Reload the Zsh configuration:

```sh
source ~/.zshrc
```

**Usage**

After installation, press `Ctrl-X` in Zsh to quickly switch to CodrusCLI powered by Codrus models without manually typing the `codrus` command.

::: tip
If you use other Zsh plugin managers (like zinit, zplug, etc.), please refer to the [zsh-codrus-cli repository](https://github.com/MoonshotAI/zsh-codrus-cli) README for installation instructions.
:::
