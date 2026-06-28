.PHONY: help validate validate-links sync sync-claude sync-ecc scaffold clean

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

scaffold: ## Scaffold a new skill: make scaffold NAME=my-new-skill DESC="description"
	@if [ -z "$(NAME)" ]; then echo "Usage: make scaffold NAME=skill-name DESC=\"description\""; exit 1; fi
	bash scripts/skill-scaffold.sh makis-digital-$(NAME) --description "$(DESC)"

clean: ## Remove pycache and temp files
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name '*.pyc' -delete
