#!/bin/bash

rm -rf public/
hugo --config hugo.yaml
npx pagefind --site "public"
