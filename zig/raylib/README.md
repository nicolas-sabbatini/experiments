# Build windows from linux

```bash
zig build -Dtarget=x86_64-windows -Doptimize=ReleaseSafe
```

# Build linux

```bash
zig build -Doptimize=ReleaseSafe
```

# Build WASM

```bash
zig build -Dtarget=wasm32-emscripten --sysroot ~/.local/emsdk/upstream/emscripten -Doptimize=ReleaseSafe
```
