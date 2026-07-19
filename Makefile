.DEFAULT_GOAL := prepare

.PHONY: help
help: ## Show available make targets.
	@echo "Available make targets:"
	@awk 'BEGIN { FS = ":.*## " } /^[A-Za-z0-9_.-]+:.*## / { printf "  %-20s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: install-prek
install-prek: ## Install prek and repo git hooks.
	@echo "==> Installing prek"
	@uv tool install prek
	@echo "==> Installing git hooks with prek"
	@uv tool run prek install

.PHONY: prepare
prepare: download-deps install-prek ## Sync dependencies for all workspace packages and install prek hooks.
	@echo "==> Syncing dependencies for all workspace packages"
	@uv sync --frozen --all-extras --all-packages

.PHONY: prepare-build
prepare-build: download-deps ## Sync dependencies for releases without workspace sources.
	@echo "==> Syncing dependencies for release builds (no sources)"
	@uv sync --all-extras --all-packages --no-sources

# for codrus web development
.PHONY: web-back web-front
web-back: ## Start web backend with uvicorn (reload enabled).
	@LOG_LEVEL=DEBUG uv run uvicorn codrus_cli.web.app:create_app --factory --reload --port 5494
web-front: ## Start web frontend (vite dev server).
	@npm --prefix web run dev

# for codrus vis development
.PHONY: vis-back vis-front
vis-back: ## Start vis backend with uvicorn (reload enabled).
	@LOG_LEVEL=DEBUG uv run uvicorn codrus_cli.vis.app:create_app --factory --reload --port 5495
vis-front: ## Start vis frontend (vite dev server).
	@npm --prefix vis run dev

.PHONY: format format-codrus-cli format-kosong format-pykaos format-codrus-sdk format-web
format: format-codrus-cli format-kosong format-pykaos format-codrus-sdk format-web ## Auto-format all workspace packages.
format-codrus-cli: ## Auto-format CodrusCLI powered by Codrus models sources with ruff.
	@echo "==> Formatting CodrusCLI powered by Codrus models sources"
	@uv run ruff check --fix
	@uv run ruff format
format-kosong: ## Auto-format kosong sources with ruff.
	@echo "==> Formatting kosong sources"
	@uv run --project packages/kosong --directory packages/kosong ruff check --fix
	@uv run --project packages/kosong --directory packages/kosong ruff format
format-pykaos: ## Auto-format pykaos sources with ruff.
	@echo "==> Formatting pykaos sources"
	@uv run --project packages/kaos --directory packages/kaos ruff check --fix
	@uv run --project packages/kaos --directory packages/kaos ruff format
format-codrus-sdk: ## Auto-format codrus-sdk sources with ruff.
	@echo "==> Formatting codrus-sdk sources"
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk ruff check --fix
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk ruff format
format-web: ## Auto-format web sources with npm run format.
	@echo "==> Formatting web sources"
	@if command -v npm >/dev/null 2>&1; then \
		npm --prefix web run format; \
	else \
		echo "npm not found. Install Node.js (npm) to run web formatting."; \
		exit 1; \
	fi
.PHONY: check check-codrus-cli check-kosong check-pykaos check-codrus-sdk check-web
check: check-codrus-cli check-kosong check-pykaos check-codrus-sdk check-web ## Run linting and type checks for all packages.
check-codrus-cli: ## Run linting and type checks for CodrusCLI powered by Codrus models.
	@echo "==> Checking CodrusCLI powered by Codrus models (ruff + pyright + ty; ty is non-blocking)"
	@uv run ruff check
	@uv run ruff format --check
	@uv run pyright
	@uv run ty check || true
check-kosong: ## Run linting and type checks for kosong.
	@echo "==> Checking kosong (ruff + pyright + ty; ty is non-blocking)"
	@uv run --project packages/kosong --directory packages/kosong ruff check
	@uv run --project packages/kosong --directory packages/kosong ruff format --check
	@uv run --project packages/kosong --directory packages/kosong pyright
	@uv run --project packages/kosong --directory packages/kosong ty check || true
check-pykaos: ## Run linting and type checks for pykaos.
	@echo "==> Checking pykaos (ruff + pyright + ty; ty is non-blocking)"
	@uv run --project packages/kaos --directory packages/kaos ruff check
	@uv run --project packages/kaos --directory packages/kaos ruff format --check
	@uv run --project packages/kaos --directory packages/kaos pyright
	@uv run --project packages/kaos --directory packages/kaos ty check || true
check-codrus-sdk: ## Run linting and type checks for codrus-sdk.
	@echo "==> Checking codrus-sdk (ruff + pyright + ty; ty is non-blocking)"
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk ruff check
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk ruff format --check
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk pyright
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk ty check || true
check-web: ## Run linting and type checks for web.
	@echo "==> Checking web (biome + tsc)"
	@if command -v npm >/dev/null 2>&1; then \
		npm --prefix web run lint && npm --prefix web run typecheck; \
	else \
		echo "npm not found. Install Node.js (npm) to run web checks."; \
		exit 1; \
	fi
.PHONY: test test-codrus-cli test-kosong test-pykaos test-codrus-sdk
test: test-codrus-cli test-kosong test-pykaos test-codrus-sdk ## Run all test suites.
test-codrus-cli: ## Run CodrusCLI powered by Codrus models tests.
	@echo "==> Running CodrusCLI powered by Codrus models tests"
	@uv run pytest tests -vv
	@uv run pytest tests_e2e -vv
test-kosong: ## Run kosong tests (including doctests).
	@echo "==> Running kosong tests"
	@uv run --project packages/kosong --directory packages/kosong pytest --doctest-modules -vv
test-pykaos: ## Run pykaos tests.
	@echo "==> Running pykaos tests"
	@uv run --project packages/kaos --directory packages/kaos pytest tests -vv
test-codrus-sdk: ## Run codrus-sdk tests.
	@echo "==> Running codrus-sdk tests"
	@uv run --project sdks/codrus-sdk --directory sdks/codrus-sdk pytest tests -vv
.PHONY: build build-codrus-cli build-kosong build-pykaos build-codrus-sdk build-bin build-bin-onedir
build: build-web build-vis build-codrus-cli build-kosong build-pykaos build-codrus-sdk ## Build Python packages for release.
build-codrus-cli: build-web build-vis ## Build the codrus-cli and codrus-code sdists and wheels.
	@echo "==> Injecting build SHA"
	@uv run scripts/inject_build_sha.py
	@echo "==> Building codrus-cli distributions"
	@uv build --package codrus-cli --no-sources --out-dir dist
	@echo "==> Building codrus-code distributions"
	@uv build --package codrus-code --no-sources --out-dir dist
build-kosong: ## Build the kosong sdist and wheel.
	@echo "==> Building kosong distributions"
	@uv build --package kosong --no-sources --out-dir dist/kosong
build-pykaos: ## Build the pykaos sdist and wheel.
	@echo "==> Building pykaos distributions"
	@uv build --package pykaos --no-sources --out-dir dist/pykaos
build-codrus-sdk: ## Build the codrus-sdk sdist and wheel.
	@echo "==> Building codrus-sdk distributions"
	@uv build --package codrus-sdk --no-sources --out-dir dist/codrus-sdk
build-web: ## Build web UI and sync into codrus-cli package.
	@echo "==> Building web UI"
	@uv run scripts/build_web.py
build-vis: ## Build vis UI and sync into codrus-cli package.
	@echo "==> Building vis UI"
	@uv run scripts/build_vis.py
build-bin: build-web build-vis ## Build the standalone executable with PyInstaller (one-file mode).
	@echo "==> Injecting build SHA"
	@KIMI_BUILD_SHA=$$(git rev-parse HEAD 2>/dev/null | cut -c1-12) uv run scripts/inject_build_sha.py
	@echo "==> Building PyInstaller binary (one-file)"
	@KIMI_BUILD_SHA=$$(git rev-parse HEAD 2>/dev/null | cut -c1-12) uv run pyinstaller codrus.spec
	@mkdir -p dist/onefile
	@if [ -f dist/codrus.exe ]; then mv dist/codrus.exe dist/onefile/; elif [ -f dist/codrus ]; then mv dist/codrus dist/onefile/; fi
build-bin-onedir: build-web build-vis ## Build the standalone executable with PyInstaller (one-dir mode).
	@echo "==> Injecting build SHA"
	@KIMI_BUILD_SHA=$$(git rev-parse HEAD 2>/dev/null | cut -c1-12) uv run scripts/inject_build_sha.py
	@echo "==> Building PyInstaller binary (one-dir)"
	@rm -rf dist/onedir dist/codrus
	@KIMI_BUILD_SHA=$$(git rev-parse HEAD 2>/dev/null | cut -c1-12) PYINSTALLER_ONEDIR=1 uv run pyinstaller codrus.spec
	@if [ -f dist/codrus/codrus-exe.exe ]; then mv dist/codrus/codrus-exe.exe dist/codrus/codrus.exe; elif [ -f dist/codrus/codrus-exe ]; then mv dist/codrus/codrus-exe dist/codrus/codrus; fi
	@mkdir -p dist/onedir && mv dist/codrus dist/onedir/
.PHONY: ai-test
ai-test: ## Run the test suite with CodrusCLI powered by Codrus models.
	@echo "==> Running AI test suite"
	@uv run tests_ai/scripts/run.py tests_ai

.PHONY: gen-changelog gen-docs
gen-changelog: ## Generate changelog with CodrusCLI powered by Codrus models.
	@echo "==> Generating changelog"
	@uv run codrus --yolo --prompt /skill:gen-changelog
gen-docs: ## Generate user docs with CodrusCLI powered by Codrus models.
	@echo "==> Generating user docs"
	@uv run codrus --yolo --prompt /skill:gen-docs

include src/codrus_cli/deps/Makefile
