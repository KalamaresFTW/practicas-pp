let x = 1;;
(*A partir de ahora el 1 (int) queda asociado con el nombre x*)
let y = 2;;
(*A partir de ahora el 2 (int) queda asociado con el nombre y*)
x - y;;
(*El resultado es -1 (int) *)
let x = y in x - y;;
(*El resultado se obtiene de aplicar x en y, que da 2,después 
se le resta y, por lo que el resultado final es 0 (int)*)
x - y;;
(*El resultado es: 1 - 2 = -1 *)
z;;
(*Dará un error de compilación, dado que z no está definido
# z;;
Error: Unbound value z
*)
let z = x + y;;
(*A partir de ahora la palabra z queda asociado con el valor 
al que está asociado x + y, que es 3 (int) *)
z;;
(*El resultado es 3 (int) *)
let x = 5;;
(*A partir de ahora el 5 (int) queda asociado con el nombre x*)
z;;
(*El resultado seguirá siendo 3 (int), dado que cuando se 
hizo la definición de z, su resultado era 3 (int) *)
let y = 5 in x + y;;
(*Se evalua el 5, y se le asocia a y, después se le aplica x 
(que es 5) y el resultado es 5, finalmente se le suma y, el 
resultado final es 5 + 5 = 10 (int) *)
x + y;;
(*El resultado es 5 + 2 = 7 (int) *)
let p = 2,5;;
(*A partir de ahora la tupla 2,5 (int * int) queda asociada con
el nombre p *)
snd p, fst p;;
(*El resultado es la tupla 5,2 (int * int) *)
p;;
(*La tupla 2,5 (int * int) *)
let p = 0,1 in snd p, fst p;;
(*El resultado será la tupla 1,0 (int * int) *)
p;;
(*La tupla 2,5 (int * int) *)
let x,y = p;;
(*Ahora x quedará asociado con 2 (int) e y con 5 (int)*)
let z = x + y;;
(*A partir de ahora el resultado de la suma de x + y 
(que es 7 (int)) quedará asociada con el nombre z*)
let x,y = p, x;;
(*El nombre x quedará asociado con la p (que es el nombre que 
le hemos dado a la tupla 2,5 (int * int)) y el nombre 
y quedará asociado con el valor con el que estaba 
asociado x (2 (int)) *)
let x = let x,y = 2,3 in x * x + y;;
(*A partir de ahora x será asociado con 7 (int) *)
x + y;;
(*El resultado de la suma de x + y: 7 + 2 = 9 (int) *)
z;;
(*El resultado es el valor con el que quedó asociado z, 7 (int)*)
let x = x + y in let y = x * y in x + y + z;;
(*El resultado es 34 (int) *)
x + y + z;;
(*El resultado es 16 (int)*)
int_of_float;;
(*float -> int*)
float_of_int;;
(*int -> float*)
int_of_char;;
(*char -> int*)
char_of_int;;
(*char -> int*)
char_of_int;;
(*int -> char*)
abs;;
(*int -> int*)
sqrt;;
(*float -> float*)
truncate
(*float -> int*)
ceil;;
(*float -> float*)
floor;;
(*float -> float*)
Char.code;;
(*char -> int*)
String.lenght;;
(*string -> int*)
fst;;
(*'a * 'b -> 'a*)
snd;;
(*'a * 'b -> 'b'*)
function x -> 2 * x;;
(*int -> int*)
(function x -> 2 * x) (2 + 1);;
(* 6 (int) *)
function (x,y) -> x;;
(* 'a * 'b -> 'a *)
let f = function x -> 2 * x;;
(* Se define como f una en la que dado un x el 
resultado es 2 * x*)
f (2 + 1);;
(*6 (int) *)
f 2 + 1;;
(*5 (int) *)
let n = 10;;
(*Se define n = 10 (int)*)
let sum n = function x -> n + x;;
(*Se define una función sum de tipo: int -> int -> int*)
sum 5;;
(*Una función que devuelve una función que suma 5, int -> int *)
sum 1 2;;
(*3 (int) *)
let n = 1;;
(*se define n = 10 (int)*)
sum n 10;;
(*11 int*)
let sumn = sum n;;
(*Se define sumn como una función int -> int*)
sumn 100;;
(*101 (int)*)
let n = 1000;;
(*Se define n como 1000 (int)*)
sumn 100;;
(*101 (int)*)
