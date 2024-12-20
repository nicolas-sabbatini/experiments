#! /bin/bash

clang loop.c -O3 -o clang.out
gcc loop.c -O3 -o gcc.out
stack ghc -- -O3 loop.hs -o haskell.out

hyperfine -i --shell=none --runs 7 --warmup 2 \
  --export-markdown benchmark_results.md \
  --command-name "C gcc" './gcc.out 40' \
  --command-name "C clang" './clang.out 40' \
  --command-name "haskell" './haskell.out 40' \
  --command-name "luajit, arithmetic remainder, index 0, chekin nill" 'luajit loop1.lua 40' \
  --command-name "luajit, arithmetic remainder, index 1, chekin nill" 'luajit loop2.lua 40' \
  --command-name "luajit, arithmetic remainder, index 0" 'luajit loop3.lua 40' \
  --command-name "luajit, arithmetic remainder, index 0" 'luajit loop4.lua 40' \
  --command-name "luajit, from repo https://github.com/bddicken/languages" 'luajit loop5.lua 40' \
  --command-name "luajit, modulo, index 1, chekin nill" 'luajit loop6.lua 40' \
  --command-name "luajit, modulo, index 0" 'luajit loop7.lua 40' \
  --command-name "luajit, modulo, index 1" 'luajit loop8.lua 40'

rm gcc.out clang.out haskell.out loop.hi loop.o
