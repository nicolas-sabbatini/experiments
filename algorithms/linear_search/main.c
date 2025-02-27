#include <math.h>
#include <stdint.h>
#include <stdio.h>

#define SIZE 10

int32_t searchLinear(uint32_t arr[], uint32_t target, int32_t size) {
  for (int32_t i = 0; i < size; i++) {
    if (target == arr[i]) {
      return i;
    }
  }
  return -1;
}

int32_t searchBinary(uint32_t arr[], uint32_t target, int32_t size) {
  int32_t low = 0;
  int32_t high = size;
  while (low < high) {
    int32_t pivot = (high - low) / 2 + low;
    if (arr[pivot] == target) {
      return pivot;
    } else if (arr[pivot] < target) {
      low = pivot + 1;
    } else {
      high = pivot;
    }
  }
  return -1;
}

int main(void) {
  uint32_t nums[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
  // Linear
  printf("Linear search example\n");
  uint32_t res = searchLinear(nums, 0, SIZE);
  printf(" %d \n", res);
  res = searchLinear(nums, 5, SIZE);
  printf(" %d \n", res);
  res = searchLinear(nums, UINT32_MAX, SIZE);
  printf(" %d \n", res);
  // Binary
  printf("\nBinary search example\n");
  res = searchBinary(nums, 0, SIZE);
  printf(" %d \n", res);
  res = searchBinary(nums, 5, SIZE);
  printf(" %d \n", res);
  res = searchBinary(nums, 9, SIZE);
  printf(" %d \n", res);
  res = searchBinary(nums, UINT32_MAX, SIZE);
  printf(" %d \n", res);

  return 0;
}
