#include <math.h>
#include <stdio.h>
#include <stdlib.h>

double_t derivate(double_t value, double_t (*fun)(double_t)) {
  double_t step = 1e-5;
  double_t calculated = fun(value + step) - fun(value - step);
  return calculated / (2 * step);
}

double_t pow2(double_t x) { return x * x; }

int main(int argc, [[maybe_unused]] char *argv[argc + 1]) {
  printf("Derivada numérica en x=3: %f\n", derivate(3.0, pow2));
  printf("Derivada real esperada '(x*x):   %f\n", 2.0 * 3.0);

  printf("Derivada numérica en x=3: %f\n", derivate(3.0, sin));
  printf("Derivada real esperada 'sin(x):   %f\n", cos(3.0));

  printf("Derivada numérica en x=3: %f\n", derivate(3.0, cos));
  printf("Derivada real esperada 'cos(x):   %f\n", -sin(3.0));

  return EXIT_SUCCESS;
}
