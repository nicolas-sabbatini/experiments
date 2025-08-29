export declare namespace JSX {
  interface IntrinsicElements {
    test: {};
    div: {
      className: string;
      children?: IntrinsicElements[];
    };
  }
}

// Esta función solo se llama cuando el elemento tiene 1 solo hijo
// ...children esto siempre tiene que venir vació porque se tiene que meter
// no entiendo, pero si le meto un assert se va todo a la verga y nos
// dejamos de joder
export function jsx(tag: any, props: any, ...children: any[]) {
  console.log(tag, props, children);
  return `<${tag}> ${children.join("\n")} </${tag}>`;
}

// Esta función se llama cuando el elemento tiene multiples hijos
// ...children esto siempre tiene que venir vació porque se tiene que meter
// no entiendo, pero si le meto un assert se va todo a la verga y nos
// dejamos de joder

export function jsxs(tag: any, props: any, ...children: any[]) {
  return jsx(tag, props, ...children);
}

// Esto nos permite crear tags <></> | <Fragment></Fragment> que no añaden
// nodos a nustro HTML
export const Fragment = ({ children }: any) => children;
