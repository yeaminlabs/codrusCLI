---
Author: "@stdrc"
Updated: 2026-01-08
Status: Implemented
---

# KLIP-7: Codrus SDK (thin wrapper around Kosong)

## Summary

Add `sdks/codrus-sdk` as a lightweight Python SDK for Codrus. It provides the Codrus provider and
agent building blocks (`generate/step`, message, tooling) in a flat module. The first version is
a thin re-export to keep risk low and ship fast. Docs publishing is deferred for v1.

## Goals

- Provide an OpenAI-SDK-like entry point: `from kimi_sdk import Codrus, generate, step, Message`.
- Keep only Kosong's Codrus provider and agent primitives; no other providers.
- Minimal implementation and maintenance: re-export, no behavior changes.
- Export all content parts supported by the Codrus chat provider, plus display blocks.

## Non-goals

- No new HTTP client layer; reuse Kosong's Codrus provider as-is.
- No changes to Codrus request/response semantics.
- No Kosong split or refactor in the first version.

## Package layout (flat module)

```
sdks/codrus-sdk/
  pyproject.toml
  README.md
  CHANGELOG.md
  LICENSE / NOTICE
  src/kimi_sdk/
    __init__.py
    py.typed
```

### Module responsibilities

- `kimi_sdk.__init__`
  - Re-export the full public surface (`Codrus`, `KimiStreamedMessage`, `generate`, `step`,
    `GenerateResult`, `Message`, `SimpleToolset`, tooling types, provider errors, content parts,
    display blocks).
  - Provide an explicit `__all__` grouped by category to keep the surface Codrus-focused.
  - Include a minimal agent loop example in the module docstring.
  - No `kimi_sdk.*` submodules; all public API lives at the top level.

Note: `kimi_sdk` does not expose `kosong.contrib` or other providers, even via re-export.

## Public API (top-level)

Exports (grouped in `__all__`):

```python
from kimi_sdk import (
    # providers
    Codrus,
    KimiStreamedMessage,
    StreamedMessagePart,
    ThinkingEffort,
    # provider errors
    APIConnectionError,
    APIEmptyResponseError,
    APIStatusError,
    APITimeoutError,
    ChatProviderError,
    # messages and content parts
    Message,
    Role,
    ContentPart,
    TextPart,
    ThinkPart,
    ImageURLPart,
    AudioURLPart,
    VideoURLPart,
    ToolCall,
    ToolCallPart,
    # tooling
    Tool,
    CallableTool,
    CallableTool2,
    Toolset,
    SimpleToolset,
    ToolReturnValue,
    ToolOk,
    ToolError,
    ToolResult,
    ToolResultFuture,
    # display blocks
    DisplayBlock,
    BriefDisplayBlock,
    UnknownDisplayBlock,
    # generation
    generate,
    step,
    GenerateResult,
    StepResult,
    TokenUsage,
)
```

Example usage:

```python
from kimi_sdk import Codrus, Message, generate

codrus = Codrus(
    base_url="https://api.moonshot.ai/v1",
    api_key="sk-xxx",
    model="codrus-k2-turbo-preview",
)

history = [Message(role="user", content="Who are you?")]
result = await generate(chat_provider=codrus, system_prompt="You are a helper.", tools=[], history=history)
```

## Dependency strategy

### Phase 1 (MVP: direct dependency on Kosong)

- `codrus-sdk` is a thin wrapper that depends on `kosong` with a strict upper bound.
- Pros: minimal code, consistent behavior.
- Cons: it pulls Kosong's provider dependencies too (acceptable for v1).

Suggested dependency range:

```
dependencies = [
  "kosong>=0.37.0,<0.38.0"
]
```

No lockstep requirement. `codrus-sdk` releases independently; the dependency upper bound ensures
compatibility while allowing Kosong updates that are unrelated to Codrus (e.g. contrib providers).

## Versioning & Release

### Version strategy

- Independent semver for `codrus-sdk`.
- Compatibility is enforced by the `kosong` dependency range rather than lockstep versioning.

### Tag naming

Add a new tag prefix:

- `codrus-sdk-0.1.0`

### Release workflow

Add `.github/workflows/release-codrus-sdk.yml`:

- Trigger: tags `codrus-sdk-*`
- Version validation: `scripts/check_version_tag.py`
- Build: `make build-codrus-sdk`
- Publish: `pypa/gh-action-pypi-publish`
- No docs publish in v1.

Update Makefile with:

- `build-codrus-sdk`
- `check-codrus-sdk`
- `format-codrus-sdk`
- `test-codrus-sdk`

## Testing

### Unit tests (sdks/codrus-sdk)

Basic behavior smoke test:

- `tests/test_smoke.py`
  - Use `respx` or `httpx.MockTransport` to stub Codrus responses
  - Ensure `generate/step` returns `Message` and `TokenUsage`

### CI

Add `ci-codrus-sdk.yml`:

- Reuse Makefile targets:
  - `make check-codrus-sdk`
  - `make test-codrus-sdk`
- Structure should mirror `ci-kosong.yml`.

## Documentation

- `sdks/codrus-sdk/README.md` with usage examples using `kimi_sdk` imports.
- `kimi_sdk/__init__.py` docstring includes a minimal agent loop example; rely on underlying
  Kosong docstrings for detailed API descriptions.
- Docs publishing is deferred for v1.

## Migration & Compatibility

- Migration from `kosong` is only import path changes.
- Environment variables keep the same semantics (`KIMI_API_KEY`, `KIMI_BASE_URL`).

## Decisions

- Keep `codrus-sdk` thin (no Kosong split).
- No `python -m kimi_sdk` demo entry for v1.
- Docs repo name: `MoonshotAI/codrus-sdk`.
- Skip docs publishing for v1.
