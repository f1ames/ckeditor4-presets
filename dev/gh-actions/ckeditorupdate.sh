#!/bin/bash
# Copyright (c) 2003-2020, CKSource - Frederico Knabben. All rights reserved.
# For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license

# Update ckeditor submodule in active branches.
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Updating ckeditor4 submodule on ckeditor4-presets $branch branch..."

# Checkout destination branch.
#git fetch --all -p
#git reset --hard "origin/$branch"
git submodule update --init --recursive

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
	git add ckeditor
	git commit -m "Update CKEditor 4 submodule HEAD."
	git push origin "$branch"
fi
