(*Una expresión de tipo int, que, al menos, contenga 4 operadores
infijos*)
(((4 + 4) * 4) / 2) - 3;; (*El resultado es 13 (int) *)
(*Una expresión de tipo float que contenga una función 
predefinida*)
floor(2.8);; (*El resultado es 2.0(float) *)
(*Una expresión de tipo char que contenga al menos una 
subexpresión de tipo int*)
Char.chr ((Char.code 'A') + 3);; (*El resultado es 'D' (char)*)
(*Una expresión no trivial de tipo bool*)
if 3 + 5 > 8 then true else false;; (*El resultado es false (bool)*)
(*Una expresión de tipo string que contenga una estructura
 if-then-else*)
if 2 + 3 >= 5 then "true" else "false";;
(*El resultado es "true" (string) *)
(*Una expresión no trivial de tipo int * int *)
fun n -> 2 * n;;
(*El resultado es (int * int)*)
