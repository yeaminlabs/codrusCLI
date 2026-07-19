# `codrus info` Subcommand

`codrus info` displays version and protocol information for CodrusCLI powered by Codrus models.

```sh
codrus info [--json]
```

## Options

| Option | Description |
|--------|-------------|
| `--json` | Output in JSON format |

## Output

| Field | Description |
|-------|-------------|
| `codrus_cli_version` | CodrusCLI powered by Codrus models version number |
| `agent_spec_versions` | List of supported agent spec versions |
| `wire_protocol_version` | Wire protocol version |
| `python_version` | Python runtime version |

## Examples

**Text output**

```sh
$ codrus info
codrus-cli version: 1.20.0
agent spec versions: 1
wire protocol: 1.10
python version: 3.13.1
```

**JSON output**

```sh
$ codrus info --json
{"codrus_cli_version": "1.20.0", "agent_spec_versions": ["1"], "wire_protocol_version": "1.10", "python_version": "3.13.1"}
```
