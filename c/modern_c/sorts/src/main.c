#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct {
  size_t comp;
  size_t swaps;
  size_t moves;
} response;

bool is_sorted(size_t *arr, size_t size) {
  for (size_t i = 0; i < size - 1; i++) {
    if (arr[i] > arr[i + 1]) {
      printf("The array \033[31mIS NOT\033[0m sorted\n");
      return false;
    }
  }
  printf("The array \033[32mIS\033[0m sorted\n");
  return true;
}

void print_array(size_t *arr, size_t from, size_t to) {
  for (size_t i = from; i < to; i++) {
    printf("%zu\t", arr[i]);
  }
  printf("\n");
}

void print_res(response res) {
  printf("In - comparisons %zu - swaps %zu - moves %zu\n", res.comp, res.swaps,
         res.moves);
}

void swap(size_t *arr, size_t a, size_t b) {
  size_t temp = arr[a];
  arr[a] = arr[b];
  arr[b] = temp;
}

response select_sort(size_t *arr, size_t size) {
  response res = {};
  for (size_t i = 0; i < size - 1; i++) {
    size_t min = i;
    for (size_t needle = i + 1; needle < size; needle++) {
      res.comp += 1;
      if (arr[min] > arr[needle]) {
        min = needle;
      }
    }
    if (i != min) {
      res.swaps += 1;
      swap(arr, min, i);
    }
  }
  return res;
}

response bubble_sort(size_t *arr, size_t size) {
  response res = {};
  bool has_swap = true;
  for (size_t i = size; i > 0 && has_swap; i--) {
    has_swap = false;
    for (size_t needle = 1; needle < i; needle++) {
      res.comp += 1;
      if (arr[needle - 1] > arr[needle]) {
        has_swap = true;
        res.swaps += 1;
        swap(arr, needle - 1, needle);
      }
    }
  }
  return res;
}

response cocktail_sort(size_t *arr, size_t size) {
  response res = {};
  size_t left = 0;
  size_t right = size;
  bool first_swap = true;
  bool second_swap = true;
  while (left < right && (first_swap || second_swap)) {
    first_swap = false;
    for (size_t needle = left; needle < right - 1; needle++) {
      res.comp += 1;
      if (arr[needle] > arr[needle + 1]) {
        res.swaps += 1;
        first_swap = true;
        swap(arr, needle + 1, needle);
      }
    }
    right -= 1;
    second_swap = false;
    for (size_t needle = right - 1; needle > left; needle--) {
      res.comp += 1;
      if (arr[needle - 1] > arr[needle]) {
        res.swaps += 1;
        second_swap = true;
        swap(arr, needle - 1, needle);
      }
    }
    left += 1;
  }
  return res;
}

response insertion_sort(size_t *arr, size_t size) {
  response res = {};
  for (size_t i = 0; i < size - 1; i++) {
    for (size_t needle = i + 1; needle > 0; needle--) {
      res.comp += 1;
      if (arr[needle - 1] > arr[needle]) {
        res.swaps += 1;
        swap(arr, needle - 1, needle);
      } else {
        break;
      }
    }
  }
  return res;
}

response strand_sort(size_t *arr, size_t size) {
  response res = {};

  bool *flags = calloc(size, sizeof(bool));
  size_t remaining_elements = size;
  size_t *bucket_1 = malloc(size * sizeof(size_t));
  size_t *bucket_2 = malloc(size * sizeof(size_t));
  size_t *bucket_solution = malloc(size * sizeof(size_t));

  size_t bucket_2_index = 0;
  while (remaining_elements > 0) {
    // Search the first element
    for (size_t i = 0; i < size; i++) {
      if (!flags[i]) {
        flags[i] = true;
        bucket_1[0] = arr[i];
        remaining_elements -= 1;
        break;
      }
    }
    // Build bucket 1
    size_t bucket_1_index = 1;
    for (size_t i = 0; i < size; i++) {
      if (!flags[i]) {
        res.comp += 1;
        if (bucket_1[bucket_1_index - 1] <= arr[i]) {
          res.moves += 1;
          flags[i] = true;
          bucket_1[bucket_1_index] = arr[i];
          remaining_elements -= 1;
          bucket_1_index += 1;
        }
      }
    }
    // Merge bucket 1 and bucket 2 in solution bucket
    size_t solution_index = 0;
    size_t bucket_1_offset = 0;
    size_t bucket_2_offset = 0;
    while (bucket_1_offset < bucket_1_index ||
           bucket_2_offset < bucket_2_index) {
      if (bucket_1_offset < bucket_1_index &&
          bucket_2_offset >= bucket_2_index) {
        bucket_solution[solution_index] = bucket_1[bucket_1_offset];
        bucket_1_offset += 1;
      } else if (bucket_1_offset >= bucket_1_index &&
                 bucket_2_offset < bucket_2_index) {
        bucket_solution[solution_index] = bucket_2[bucket_2_offset];
        bucket_2_offset += 1;
      } else if (bucket_1[bucket_1_offset] <= bucket_2[bucket_2_offset]) {
        res.comp += 1;
        bucket_solution[solution_index] = bucket_1[bucket_1_offset];
        bucket_1_offset += 1;
      } else {
        res.comp += 1;
        bucket_solution[solution_index] = bucket_2[bucket_2_offset];
        bucket_2_offset += 1;
      }
      res.moves += 1;
      solution_index += 1;
    }

    // Swap solution and bucket_2
    if (remaining_elements > 0) {
      bucket_2_index = solution_index;
      size_t *temp = bucket_solution;
      bucket_solution = bucket_2;
      bucket_2 = temp;
    }
  }

  // Copy solution to arr
  for (size_t i = 0; i < size; i++) {
    arr[i] = bucket_solution[i];
  }
  res.moves += size;

  free(flags);
  free(bucket_1);
  free(bucket_2);
  free(bucket_solution);

  return res;
}

int main(int argc, char *argv[argc + 1]) {
  // Load arguments
  if (argc == 1) {
    printf("Not enough arguments\n");
    return EXIT_FAILURE;
  }
  size_t sort_size = (argc - 1) * sizeof(size_t);
  size_t *to_sort = malloc(sort_size);
  size_t sort_length = argc - 1;
  for (int i = 1; i < argc; i++) {
    to_sort[i - 1] = atoi(argv[i]);
  }

  // Attempt select sort
  size_t *to_select = malloc(sort_size);
  memcpy(to_select, to_sort, sort_size);
  printf("==========================================\n");
  printf("Select Sort\n");
  response res_select = select_sort(to_select, sort_length);
  is_sorted(to_select, sort_length);
  print_res(res_select);
  free(to_select);
  printf("==========================================\n");

  // Attempt bubble sort
  size_t *to_bubble = malloc(sort_size);
  memcpy(to_bubble, to_sort, sort_size);
  printf("==========================================\n");
  printf("Bubble Sort\n");
  response res_bubble = bubble_sort(to_bubble, sort_length);
  is_sorted(to_bubble, sort_length);
  print_res(res_bubble);
  free(to_bubble);
  printf("==========================================\n");

  // Attempt cocktail sort
  size_t *to_cocktail = malloc(sort_size);
  memcpy(to_cocktail, to_sort, sort_size);
  printf("==========================================\n");
  printf("Cocktail Sort\n");
  response res_cocktail = cocktail_sort(to_cocktail, sort_length);
  is_sorted(to_cocktail, sort_length);
  print_res(res_cocktail);
  free(to_cocktail);
  printf("==========================================\n");

  // Attempt insertion sort
  size_t *to_insertion = malloc(sort_size);
  memcpy(to_insertion, to_sort, sort_size);
  printf("==========================================\n");
  printf("Insertion Sort\n");
  response res_insertion = insertion_sort(to_insertion, sort_length);
  is_sorted(to_insertion, sort_length);
  print_res(res_insertion);
  free(to_insertion);
  printf("==========================================\n");

  // Attempt strand sort
  size_t *to_strand = malloc(sort_size);
  memcpy(to_strand, to_sort, sort_size);
  printf("==========================================\n");
  printf("Strand Sort\n");
  response res_strand = strand_sort(to_strand, sort_length);
  is_sorted(to_strand, sort_length);
  print_res(res_strand);
  free(to_strand);
  printf("==========================================\n");

  free(to_sort);
  return EXIT_SUCCESS;
}
