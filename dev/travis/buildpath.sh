#!/bin/bash
# Copyright (c) 2003-2020, CKSource - Frederico Knabben. All rights reserved.
# For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license

# Return CKEditor build path.

echo "./build/$(ls -1t ./build/ | head -n 1)/full-all/ckeditor/"
