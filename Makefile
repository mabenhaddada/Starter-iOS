M = $(shell printf "\033[34;1m▶\033[0m")

all: deps

clean: ; $(info $(M) Cleaning…)
	xcodebuild -workspace Starter.xcworkspace -scheme Starter clean | xcpretty
	
deps: env pods
	touch Starter/Generated/Scenes.swift
	touch Starter/Generated/L10n.swift
	touch Starter/Generated/Assets.swift


env: bundler; $(info $(M) Installing Gems…)
	bundle update --bundler && \
	bundle install

bundler: ; $(info $(M) Installing Bundler…)
	gem install bundler

pods: ; $(info $(M) Installing CocoaPods…)
	bundle exec pod install --repo-update

.PHONY: clean env pods
