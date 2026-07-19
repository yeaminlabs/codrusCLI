from __future__ import annotations


class CodrusCLIException(Exception):
    """Base exception class for CodrusCLI powered by Codrus models."""

    pass


class ConfigError(CodrusCLIException, ValueError):
    """Configuration error."""

    pass


class AgentSpecError(CodrusCLIException, ValueError):
    """Agent specification error."""

    pass


class InvalidToolError(CodrusCLIException, ValueError):
    """Invalid tool error."""

    pass


class SystemPromptTemplateError(CodrusCLIException, ValueError):
    """System prompt template error."""

    pass


class MCPConfigError(CodrusCLIException, ValueError):
    """MCP config error."""

    pass


class MCPRuntimeError(CodrusCLIException, RuntimeError):
    """MCP runtime error."""

    pass
