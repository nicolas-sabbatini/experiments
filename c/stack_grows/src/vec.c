#include <stdbool.h>
#include <stdio.h>

bool growsUp(int *b) {
  int a;
  if (b == NULL) {
    return growsUp(&a);
  }
  return &a > b;
}

int main(void) {
  if (growsUp(NULL)) {
    printf("Grow Up\n");
  } else {
    printf("Grow Down\n");
  }
  return 0;
}
