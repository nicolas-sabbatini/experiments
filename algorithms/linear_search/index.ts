const arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

console.log("Test linar");
function searchLinear(arr: any[], target: any): number {
  for (let i = 0; i < arr.length; i++) {
    if (arr[i] === target) {
      return i;
    }
  }
  return -1;
}
console.log(searchLinear(arr, 0));
console.log(searchLinear(arr, 5));
console.log(searchLinear(arr, -1));

console.log("Test binary");
function searchBinary(arr: any[], target: any): number {
  let low = 0;
  let high = arr.length;
  while (low < high) {
    const pivot = Math.floor((high - low) / 2) + low;
    if (arr[pivot] === target) {
      return pivot;
    } else if (arr[pivot] < target) {
      low = pivot + 1;
    } else {
      high = pivot;
    }
  }
  return -1;
}
console.log(searchBinary(arr, 0));
console.log(searchBinary(arr, 5));
console.log(searchBinary(arr, 9));
console.log(searchBinary(arr, -1));
