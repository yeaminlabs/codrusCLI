# CodrusCLI powered by Codrus models Tools

## Guidelines

- Tools should not refer to types in `codrus_cli/wire/` unless they are explicitly implementing a UI / runtime bridge. When importing things like `ToolReturnValue` or `DisplayBlock`, prefer `kosong.tooling`.
