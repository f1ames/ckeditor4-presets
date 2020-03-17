#!/bin/bash
# Copyright (c) 2003-2020, CKSource - Frederico Knabben. All rights reserved.
# For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license

# Update ckeditor submodule in master and major branches.
for branch in "master" "major"; do
	echo "Updating ckeditor4 submodule on ckeditor4-presets $branch branch..."

	# Checkout destination branch.
	git fetch --all -p
	git reset --hard "origin/$branch"

	# Update ckeditor submodule branch.
	cd "ckeditor"
	oldHash=$(git hash)
	git fetch --all -p
	git reset --hard "origin/$branch"
	newHash=$(git hash)

	# Check if anything changed and push to remote.
	if [ "$oldHash" = "$newHash" ]; then
		echo "Nothing changed (still on the latest $oldHash commit), aboritng..."
	else
		echo "Updating $branch branch from $oldHash to $newHash..."

		cd ".."
		git add ckeditor
		git commit -m "Update CKEditor 4 submodule HEAD."
		# git push origin "$branch"
	fi
done
