// Cree un arreglo
const array = new ArrayBuffer(6);
console.log("Empty untype array", array);
// Cree una ventana de 8 bits
const u8Array = new Uint8Array(array);
console.log("Untype as u8Array", u8Array, array);
u8Array[0] = 42;
console.log("Change u8Array[0] = 42", u8Array, array);
u8Array[2] = 10;
console.log("Change u8Array[2] = 10", u8Array, array);
// Cree una ventana de 16 bits
const u16Array = new Uint16Array(array);
console.log("Untype as u16Array", u16Array, array);
u16Array[2] = 0XFFFF;
console.log("Change u16Array[2] = 0XFFFF", u16Array, u8Array, array);
