# `codrus acp` Subcommand

The `codrus acp` command starts a multi-session ACP (Agent Client Protocol) server.

```sh
codrus acp
```

## Description

ACP is a standardized protocol that allows IDEs and other clients to interact with AI agents.

## Use cases

- IDE plugin integration (e.g., JetBrains, Zed)
- Custom ACP client development
- Multi-session concurrent processing

For using CodrusCLI powered by Codrus models in IDEs, see [Using in IDEs](../guides/ides.md).

## Authentication

The ACP server checks user authentication status before creating or loading sessions. If the user is not logged in, the server returns an `AUTH_REQUIRED` error (code `-32000`) with available authentication method details.

Upon receiving this error, the client should guide the user to run the `codrus login` command in the terminal to complete login. Once logged in, subsequent ACP requests will proceed normally.
