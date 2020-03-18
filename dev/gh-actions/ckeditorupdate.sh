#!/bin/bash
# Copyright (c) 2003-2020, CKSource - Frederico Knabben. All rights reserved.
# For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license

# Used actions
# https://github.com/marketplace/actions/checkout
# https://github.com/marketplace/actions/github-push

# Update ckeditor submodule in active branch.
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Updating ckeditor4 submodule on ckeditor4-presets $branch branch..."

# Update ckeditor submodule branch.
echo "Fetching latest ckeditor4 changes from $branch branch..."

cd "ckeditor"
oldHash=$(git log -1 --format="%h")
git fetch --all -p
git reset --hard "origin/$branch"
newHash=$(git log -1 --format="%h")

# Check if anything changed and push to remote.
if [ "$oldHash" = "$newHash" ]; then
	echo "Nothing changed (still on the latest $oldHash commit), aboritng..."
else
	echo "Updating $branch branch from $oldHash to $newHash..."

	cd ".."
	git config --local user.email "gh-actions@cksource.com"
	git config --local user.name "CKSource GitHub Actions Bot"
	git add ckeditor
	git commit -m "Update CKEditor 4 submodule HEAD."
fi
