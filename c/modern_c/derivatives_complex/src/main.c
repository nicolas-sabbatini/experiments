#include <complex.h>
#include <stdio.h>
#include <stdlib.h>

double complex derivate(double complex value,
                        double complex (*fun)(double complex)) {
  double complex step = CMPLXF(1e-5, 1e-5);
  double complex calculated = fun(value + step) - fun(value - step);
  return calculated / (2 * step);
}

double complex pow2(double complex x) { return x * x; }

double complex poly(double complex z) { return (z * z * z) + (2 * z); }
double complex poly_deri(double complex z) { return 3 * (z * z) + 2; }

int main(int argc, [[maybe_unused]] char *argv[argc + 1]) {
  printf("Función: 'x*x' en x=3+3*I\n");
  double complex pow_derivate = derivate(CMPLXF(3.0, 3.0), pow2);
  printf("Derivada utilizando 'derivate': %lf%+lfi\n", creal(pow_derivate),
         cimag(pow_derivate));
  double complex pow_expected = CMPLXF(3.0, 3.0) * 2.0;
  printf("Derivada manual '(x*x):         %lf%+lfi\n", creal(pow_expected),
         cimag(pow_expected));

  printf("Función: '(x * x * x) + (2 * x)' en x=5+5*I\n");
  double complex poly_derivate = derivate(CMPLXF(5.0, 5.0), poly);
  printf("Derivada utilizando 'derivate':   %lf%+lfi\n", creal(poly_derivate),
         cimag(poly_derivate));
  double complex poly_expected = poly_deri(CMPLXF(5.0, 5.0));
  printf("Derivada manual '3 * (x * x) + 2: %lf%+lfi\n", creal(poly_expected),
         cimag(poly_expected));

  return EXIT_SUCCESS;
}
