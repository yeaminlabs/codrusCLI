# `codrus info` 子命令

`codrus info` 显示 CodrusCLI powered by Codrus models 的版本和协议信息。

```sh
codrus info [--json]
```

## 选项

| 选项 | 说明 |
|------|------|
| `--json` | 以 JSON 格式输出 |

## 输出内容

| 字段 | 说明 |
|------|------|
| `codrus_cli_version` | CodrusCLI powered by Codrus models 版本号 |
| `agent_spec_versions` | 支持的 Agent 规格版本列表 |
| `wire_protocol_version` | Wire 协议版本 |
| `python_version` | Python 运行时版本 |

## 示例

**文本输出**

```sh
$ codrus info
codrus-cli version: 1.20.0
agent spec versions: 1
wire protocol: 1.10
python version: 3.13.1
```

**JSON 输出**

```sh
$ codrus info --json
{"codrus_cli_version": "1.20.0", "agent_spec_versions": ["1"], "wire_protocol_version": "1.10", "python_version": "3.13.1"}
```
