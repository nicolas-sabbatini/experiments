# Table vs If

Is faster to execute an if or access a table to execute a function

## Results

- Total off iterations: 15
- Access/If: 100_000_000

### LuaJIT

- Table:
  - Total: 30.342424s
  - Average: 2.0228282666667s
- If:
  - Total: 39.917788s
  - Average: 2.6611858666667s

Table is faster

### Lua 5.1.5

- Table:
  - Total: 105.154161s
  - Average: 7.0102774s
- If:
  - Total: 111.303603s
  - Average: 7.4202402s

Table is faster
