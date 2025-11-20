#!/bin/bash

# Define cuántos números aleatorios quieres generar
NUM_VALUES=10 #261515

# Rango: de 1 a 100
MIN=1
MAX=50

# Array para almacenar los números
random_numbers=()

# Genera los números aleatorios
for _ in $(seq 1 $NUM_VALUES); do
  # Fórmula para un número en el rango [MIN, MAX]
  num=$((MIN + RANDOM % (MAX - MIN + 1)))
  random_numbers+=("$num")
done

echo "Números generados: ${random_numbers[*]}"

# Ejecuta tu programa pasando la lista como argumentos
# Reemplaza './tu_programa' con la ruta real a tu ejecutable
./bin/main "${random_numbers[@]}"
