SHELL := /bin/bash
VENDOR_DIR = assets/vendor/
BUNDLER := bundler
JEKYLL := jekyll
CURL := curl
GEM := gem
GIT := git


jQueryVer := `grep jquery-ver _config.yml |sed 's/"//g' |awk '{ print $$2 }'`
BoostrapVer := `grep bootstrap-ver _config.yml |sed 's/"//g' |awk '{ print $$2 }'`

default: 
	@echo ""
	@echo "This is the build script for Loki's Stories website's Jekyll source."
	@echo ""
	@echo "make check - Checks that Jekyll is ready to run, also runs the 'vendor' command that downloads needed vendor files."
	@echo ""
	@echo "make install"
	@echo ""
	@echo "make pull - Command to update via the git command (git install required)"
	@echo ""
	@echo "make vendor - Command to download the needed vendor files (jQuery, Bootstrap."
	@echo ""
	@echo "make update - Command to run 'git pull' then 'gem update' then 'bundler update'"
	@echo ""
	@echo "make build - Command ro run 'bundler exec jekyll build'"
	@echo ""
	@echo "make run - Command to run "
	@echo ""
	@echo "make publish"

check:
	@$(BUNDLER) exec $(JEKYLL) doctor

clean:
	@$(BUNDLER) exec $(JEKYLL) clean
	@rm -rf assets/vendor

install:
	@$(BUNDLER) install

pull:
	@$(GIT) pull

update:
	@$(GIT) pull
	@$(GEM) update
	@$(BUNDLER) update

build:
	@$(BUNDLER) exec $(JEKYLL) build

b: build

publish:
	@JEKYLL_ENV=production $(BUNDLER) exec $(JEKYLL) build --trace

p: publish

run: pull publish
