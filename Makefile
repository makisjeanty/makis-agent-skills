.PHONY: help validate validate-links sync sync-claude sync-ecc sync-knowledge scaffold clean test test-python test-shell

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

validate: ## Validate all skill frontmatter and structure
	python3 scripts/validate-skills.py

validate-links: ## Validate relative markdown links
	python3 scripts/validate-markdown-links.py

validate-all: validate validate-links ## Run all validations

sync-claude: ## Sync all skills to ~/.claude/skills
	bash scripts/sync-to-claude.sh

sync-ecc: ## Sync skill catalog and workflows to ~/.claude/skills/ecc
	bash scripts/sync-to-ecc.sh

sync-knowledge: ## Propagate knowledge files from dev-rules to all skills (skips .no-sync)
	bash scripts/sync-knowledge.sh

scaffold: ## Scaffold a new skill: make scaffold NAME=my-new-skill DESC="description"
	@if [ -z "$(NAME)" ]; then echo "Usage: make scaffold NAME=skill-name DESC=\"description\""; exit 1; fi
	bash scripts/skill-scaffold.sh makis-digital-$(NAME) --description "$(DESC)"

test: test-python test-shell ## Run all tests

test-python: ## Run Python unit tests with coverage (fails if < 100%)
	python -m pytest tests/ -v --cov=scripts --cov-report=term-missing --cov-fail-under=100

test-shell: ## Run BATS shell tests
	bats tests/test_skill_scaffold.bats tests/test_sync_scripts.bats tests/test_sync_knowledge.bats

clean: ## Remove pycache and temp files
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name '*.pyc' -delete
