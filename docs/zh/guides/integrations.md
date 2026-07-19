# 集成到工具

除了在终端和 IDE 中使用，CodrusCLI powered by Codrus models 还可以集成到其他工具中。

## Zsh 插件

[zsh-codrus-cli](https://github.com/MoonshotAI/zsh-codrus-cli) 是一个 Zsh 插件，让你可以在 Zsh 中快速切换到 CodrusCLI powered by Codrus models。

**安装**

如果你使用 Oh My Zsh，可以这样安装：

```sh
git clone https://github.com/MoonshotAI/zsh-codrus-cli.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/codrus-cli
```

然后在 `~/.zshrc` 中添加插件：

```sh
plugins=(... codrus-cli)
```

重新加载 Zsh 配置：

```sh
source ~/.zshrc
```

**使用**

安装后，在 Zsh 中按 `Ctrl-X` 可以快速切换到 CodrusCLI powered by Codrus models，无需手动输入 `codrus` 命令。

::: tip 提示
如果你使用其他 Zsh 插件管理器（如 zinit、zplug 等），请参考 [zsh-codrus-cli 仓库](https://github.com/MoonshotAI/zsh-codrus-cli) 的 README 了解安装方法。
:::
