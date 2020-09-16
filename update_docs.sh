#!/bin/bash
rm -rf docs
cp -r build/html/ docs
touch docs/.nojekyll
git add docs
