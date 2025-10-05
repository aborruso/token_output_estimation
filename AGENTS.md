# Repository Guidelines

## Project Structure & Module Organization
The core CLI lives in `token_evaluate`, a Bash script that orchestrates LLM extraction loops and token counting. The `Makefile` handles installation into `/usr/local/bin`. Reference assets reside in `resource/`—most notably `template.yml`, the prompt loaded by the LLM CLI, plus `llm.md` for broader context. Sample inputs in `sample/` (HTML, CSV, JSON) illustrate expected data shapes. Product context and roadmap notes live in `PRD.md`, while high-level onboarding sits in `README.md`.

## Build, Test, and Development Commands
Run `make install` to copy the CLI into your `$PATH`; use `make uninstall` to remove it. During development, execute the script directly (`./token_evaluate`) to avoid reinstalling. Validate extraction logic with `./token_evaluate -v sample/input_01.html "extract province, city, center, address, contacts and hours"`, which shows each run’s JSON plus the averaged token count. Use `llm templates path` to locate the template directory before copying `resource/template.yml` into place.

## Coding Style & Naming Conventions
Keep contributions Bash 5 compatible and stick to lower_snake_case for variables and functions (`user_instructions`, `cleanup`). Indent with four spaces inside blocks, mirroring the existing script. Prefer guard clauses and explicit error messages over silent failures. When adding complex branches, include a short comment describing the rationale—especially around retry logic and token truncation.

## Testing Guidelines
There is no automated test suite yet; rely on manual regression passes. Exercise new code paths with the samples under `sample/`, and document the commands you ran. When logic touches token limits or retries, run at least one verbose invocation to inspect stderr diagnostics. If you introduce reusable helpers, consider adding a lightweight Bash test harness or snapshot script alongside the samples.

## Commit & Pull Request Guidelines
Existing commits use concise, sentence-style summaries (“Aggiunta documentazione…”, “sample files”). Follow that pattern: start with a capital letter, keep the subject under ~72 characters, and expand in the body if context helps. Pull requests should describe the motivation, list manual verification commands, and link to any relevant issues or PRD sections. Include screenshots only when CLI output changes meaningfully.

## Security & Configuration Tips
API keys stay outside the repo—configure them with `llm keys set openai` and confirm availability via `llm keys list`. Respect the built-in throttling (4s delay) and avoid reducing it without discussing rate-limit implications. Never commit personalized templates; instead, note overrides in the PR description.
