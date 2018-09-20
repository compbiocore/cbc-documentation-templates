#!/bin/bash
mkdir docs/styles docs/images
curl -H 'Authorization: token $GITHUB_TOKEN' -H 'Accept: application/vnd.github.v3.raw' -o docs/styles/dark_mode.css -L https://api.github.com/repos/compbiocore/cbc-documentation-templates/contents/docs/assets/styles/dark_mode.css
curl -H 'Authorization: token $GITHUB_TOKEN' -H 'Accept: application/vnd.github.v3.raw' -o docs/images/cbc-logo.svg -L https://api.github.com/repos/compbiocore/cbc-documentation-templates/contents/docs/assets/img/cbc-logo.svg
mkdocs build --verbose --clean --strict
