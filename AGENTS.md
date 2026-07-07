# Agent Instructions

## Scope
This repository builds and publishes base Docker images.

## Rules
- Prefer minimal, deterministic Docker layers.
- Do not introduce breaking tag changes without updating docs.
- Keep generated files in sync with templates.

## Code Style
- Follow existing Ruby/Rake conventions.
- Keep comments concise and only where logic is non-obvious.

## Validation
- Run lint/tests before proposing changes.
- For Docker changes, verify at least one local build path.

## Safety
- Never commit secrets.
- Do not modify unrelated files.
