// deno-lint-ignore-file no-explicit-any

// Monads are a way to structure computations as a sequence of steps, where
// each step not only produces a value but also some extra information about
// the computation, such as a potential failure, non-determinism, or side effect.
//
// Example
let square: (x: any) => any = (x: number): number => x * x;
let add_one: (x: any) => any = (x: number): number => x + 1;

console.log(add_one(square(2)));

// Now for audit we want how we get to the result
// add_one(square(2)) => {
//    result: 5
//    logs: [
//        "square 2 to get 4",
//        "add 1 to 4 to get 5"
//    ]
// }

interface Logs {
  result: number;
  logs: string[];
}
square = (x: number): Logs => ({
  result: x * x,
  logs: [
    `square ${x} to get ${x * x}`,
  ],
});
add_one = (x: Logs): Logs => ({
  result: x.result + 1,
  logs: [
    ...x.logs,
    `add 1 to ${x.result} to get ${x.result + 1}`,
  ],
});

console.log(add_one(square(2)));

// Probema con esto, que pasa si quiero hacer `square(add_one(1))`
// o `square(2)`, no voy a poder realizar ninguna operación ya que los tipos
// son incompatibles

const wrap_logs = (x: number): Logs => ({
  result: x,
  logs: [],
});

square = (x: Logs): Logs => ({
  result: x.result * x.result,
  logs: [
    ...x.logs,
    `square ${x.result} to get ${x.result * x.result}`,
  ],
});

console.log(add_one(square(wrap_logs(2))));

// Con esa función resolvimos el problema, pero tenemos logica duplcada en las
// 2 funciones, respecto a la concatenación de logs. Podemos solucionar el problema
// creando una funcion que ejecuta nuestra serie de pasos y vaya armando la receta

const run_with_logs = (x: Logs, fn: (x: number) => Logs): Logs => {
  const result = fn(x.result);
  return {
    result: result.result,
    logs: [
      ...x.logs,
      ...result.logs,
    ],
  };
};

// Ademas podemos simplificar square y add_one para que funcionen con números por si
// queremos ejecutar las funciones fuera de una cadena
square = (x: number): Logs => ({
  result: x * x,
  logs: [
    `square ${x} to get ${x * x}`,
  ],
});

add_one = (x: number): Logs => ({
  result: x + 1,
  logs: [
    `add 1 to ${x} to get ${x + 1}`,
  ],
});

console.log(run_with_logs(square(2), add_one));

// Gracias a nuestro trabajo podemos ahora aplicar transformaciones en cualquer orden
// y aplicar la cantidad que querramos

const multiply_by_3 = (x: number): Logs => ({
  result: x * 3,
  logs: [
    `multiply by 3 ${x} to get ${x * 3}`,
  ],
});

let a = wrap_logs(1);
a = run_with_logs(a, add_one);
a = run_with_logs(a, multiply_by_3);
a = run_with_logs(a, square);
console.log(a);

// Esto que constuimos es una mónada, lo que es basicamente una forma de concatenar
// operaciones.
// Toda monada contine 3 partes:
// - Un typo warper, en nuestro caso Logs
// - Una función creadora (retunr, pure o unit, se llama normalmente) que nos
// permite entrar al ecosistema "monadico", wrap_logs
// - Función de ejecución, que nos permite ejecutar nuestras transformacioes, run_with_logs (bind, flatMap, >>=)
