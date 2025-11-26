#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define ARRAY_SIZE 8

void print_array(size_t *arr) {
  for (size_t i = 0; i < ARRAY_SIZE; i++) {
    printf("%20zu|", arr[i]);
  }
  printf("\n");
  for (size_t i = 0; i < ARRAY_SIZE; i++) {
    printf("%20zu|", i);
  }
  printf("\n");
}

void init_parent(size_t *parent) {
  for (size_t i = 0; i < ARRAY_SIZE; i++) {
    parent[i] = SIZE_MAX;
  }
}

size_t find(size_t *parent, size_t index) {
  while (parent[index] != SIZE_MAX && index != parent[index]) {
    index = parent[index];
  }
  return index;
}

void find_replace(size_t *parent, size_t index, size_t value) {
  do {
    size_t temp_index = parent[index];
    parent[index] = value;
    index = temp_index;
  } while (index != SIZE_MAX && index != parent[index]);
}

void find_compress(size_t *parent, size_t index) {
  size_t root = find(parent, index);
  find_replace(parent, index, root);
  parent[root] = SIZE_MAX;
}

void union_trees(size_t *parent, size_t index_a, size_t index_b) {
  size_t root_a = find(parent, index_a);
  find_compress(parent, index_a);
  find_replace(parent, index_b, root_a);
}

int main(int argc, [[maybe_unused]] char *argv[argc + 1]) {
  size_t parent[ARRAY_SIZE];
  init_parent(parent);

  printf(" => Inicialización\n");
  init_parent(parent);
  print_array(parent);
  assert(parent[0] == SIZE_MAX);
  assert(parent[7] == SIZE_MAX);

  printf("=> Find en camino 2 -> 1 -> 0\n");
  parent[0] = SIZE_MAX;
  parent[1] = 0;
  parent[2] = 1;
  print_array(parent);
  assert(find(parent, 2) == 0);
  printf("Root del 2: %zu\n", find(parent, 2));
  assert(find(parent, 1) == 0);
  printf("Root del 1: %zu\n", find(parent, 1));
  assert(find(parent, 0) == 0);
  printf("Root del 0: %zu\n", find(parent, 0));

  printf("=> Find replace a 5 del camino 2->1->0\n");
  init_parent(parent);
  parent[0] = SIZE_MAX;
  parent[1] = 0;
  parent[2] = 1;
  printf("=Pre===================================\n");
  print_array(parent);
  find_replace(parent, 2, 5);
  printf("=Post======= find_replace(parent, 2, 5)\n");
  print_array(parent);
  assert(parent[2] == 5);
  assert(parent[1] == 5);
  assert(parent[0] == 5);
  assert(parent[5] == SIZE_MAX);

  printf("=> Find compress 4->3->2->1->0\n");
  init_parent(parent);
  parent[0] = SIZE_MAX;
  parent[1] = 0;
  parent[2] = 1;
  parent[3] = 2;
  parent[4] = 3;
  printf("=Pre===================================\n");
  print_array(parent);
  find_compress(parent, 4);
  printf("=Post======= find_compress(parent, 4)\n");
  print_array(parent);
  assert(parent[4] == 0);
  assert(parent[3] == 0);
  assert(parent[2] == 0);
  assert(parent[1] == 0);
  assert(parent[0] == SIZE_MAX);

  printf("=> Union tree\n");
  init_parent(parent);
  union_trees(parent, 0, 1);
  assert(find(parent, 1) == 0);
  union_trees(parent, 1, 2);
  assert(find(parent, 2) == 0);

  return EXIT_SUCCESS;
}
