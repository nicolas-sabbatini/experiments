#include <stdio.h>
#include <stdlib.h>

int main(int argc, [[maybe_unused]] char *argv[argc + 1]) {
  // If
  if (!0) {
    printf("El 0 es false\n");
  }
  if (1) {
    printf("El 1 es true\n");
  }
  int not_defined;
  if (!not_defined) {
    printf("Una variable no definida es false\n");
  }
  if (!NULL) {
    printf("NULL es false\n");
  }
  // For
  for (size_t i = 0, stop = 2; i < stop; ++i) {
    if (i % 2 == 0) {
      ++stop;
    }
    printf("i = %zu, stop = %zu\t", i, stop);
  }
  printf("\n");
  for (size_t i = 9; i <= 9; --i) {
    printf("i = %zu\t", i);
  }
  printf("\n");

  return EXIT_SUCCESS;
}
