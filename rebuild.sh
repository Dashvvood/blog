#!/bin/bash

find public -mindepth 1 ! -path 'public/.git*' -delete
hugo --config hugo.yaml
npx -y pagefind --site public
