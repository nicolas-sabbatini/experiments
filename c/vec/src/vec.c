#include <stdio.h>
#include <stdlib.h>

#define Vec(T)                                                                 \
  typedef struct {                                                             \
    T *items;                                                                  \
    size_t size;                                                               \
    size_t capacity;                                                           \
  } Vec_##T;

#define VecCreate(T) (Vec_##T){.items = NULL, .size = 0, .capacity = 0}

#define VecPrint(vec, format)                                                  \
  do {                                                                         \
    printf("[ ");                                                              \
    for (size_t i = 0; i < vec.size; i++) {                                    \
      printf(format, vec.items[i]);                                            \
    }                                                                          \
    printf(" ]\n");                                                            \
  } while (0)

#define VecPush(vec, element)                                                  \
  do {                                                                         \
    if (vec.size >= vec.capacity) {                                            \
      if (vec.capacity == 0)                                                   \
        vec.capacity = 10;                                                     \
      else                                                                     \
        vec.capacity *= 2;                                                     \
    }                                                                          \
    vec.items = realloc(vec.items, vec.capacity * sizeof(*vec.items));         \
    vec.items[vec.size++] = element;                                           \
  } while (0)

Vec(int);
Vec(float);

int main(void) {

  Vec_int test = VecCreate(int);
  for (int i = 0; i < 10; i++) {
    VecPush(test, i);
  }
  VecPrint(test, " %i ");

  Vec_float test2 = VecCreate(float);
  for (int i = 0; i < 10; i++) {
    VecPush(test2, (float)i);
  }
  VecPrint(test2, " %f ");

  return 0;
}
