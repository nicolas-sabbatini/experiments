#!/bin/bash

luajit builder.lua >input.lua

hyperfine -i --shell=none --runs 7 --warmup 2 \
  --export-markdown benchmark_results.md \
  --command-name "luajit table" 'luajit table.lua' \
  --command-name "luajit if" 'luajit if.lua' \
  --command-name "lua5.1 table" 'lua table.lua' \
  --command-name "lua5.1 if" 'lua if.lua'

echo "return {}" >input.lua
