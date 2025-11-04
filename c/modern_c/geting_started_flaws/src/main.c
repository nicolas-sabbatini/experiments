#include <stdio.h>
#include <stdlib.h>

int main(int argc, [[maybe_unused]] char *argv[argc + 1]) {
  int i;
  // The order of the array is diferent
  double A[5] = {
      9.0,
      2.9,
      3.E+25,
      .00007,
  };

  for (i = 0; i < 5; i++) {
    printf("Element %d is %g\tits square is %g\n", i, A[i], A[i] * A[i]);
  }

  return EXIT_SUCCESS;
}

/* base
void main(int argc, [[maybe_unused]] char *argv[argc + 1]) {
  int i;
  double A[5] = {
      9.0,
      2.9,
      3.E+25,
      .00007,
  };

  for (i = 0; i < 5; i++) {
    printf("Element %zu is %g\tits square is %g\n", i, A[i], A[i] * A[i]);
  }
}
*/
