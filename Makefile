.SHELL := bash

.PHONY: all
all: ## AppImage のビルド
	docker buildx build --output type=local,dest=dist .

.PHONY: install
install: ## ローカルに AppImage をインストール
	sudo cp dist/*.AppImage /usr/local/bin/mysql-workbench
	sudo chmod 755 /usr/local/bin/mysql-workbench
	bash scripts/make-desktop-icon.sh


# Self-Documented Makefile
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
