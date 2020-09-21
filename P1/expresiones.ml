( );;
(*unit*)
2 + 5 * 3;;
(*int 17*)
1.2;;
(*float*)
1.0 * 2;;
(*Error de compilación, tipos incompatibles (float * int)
# 1.0 * 2;;
Error: This expression has type float but an expression was
 expected of type int
Me imagino que se intentaba multiplicar 1.0 (float) por 2
la expresión correcta sería: 1.0 *. 2.0 *)
2-2.0;;
(*Error de compilación, tipos incompatibles (int - float)
# 2-2.0;;
Error: This expression has type float but an expression was
 expected of type int
Se intenta restar 2 (int) menos 2.0 (float) lo correcto sería:
2.0 -. 2.0 cuyo resultado es un float (0.)
*)
3.0 + 2.0;;
(*Error de compilación, no se está utilizando el operador 
adecuado para sumar floats (+.)
# 3.0 + 2.0;;
Error: This expression has type float but an expression was
 expected of type int.
Se está utilizando el operador de la suma entre valores de tipo 
int, lo correcto sería utilizar el de float (+.)
# 3.0 +. 2.0;;
- : float = 5. *)
5 / 3;;
(*El resultado será la división de dos int expresado como un
int, se pierde precisión ya que 5/3 es 1.66... y el compilador
probablemente de 1
# 5/3;;
- : int = 1 *)
5 mod 3;;
(*El resto de dividir 5 entre 3 (ambos int) es 2 (int)
# 5 mod 3;;
- : int = 2 *)
3.0 *. 2.0 ** 3.0;;
(*Una operacion de tres floats, se eleva primero 2 a 3, y después
se multiplica por 3, resultado 24(float)*)
3.0 = float_of_int 3;;
(*Dará true (bool)*)
sqrt 4;
(*Dará error de compilación, ya que la función sqrt solo acepta
valores de tipo float, lo correcto sería sqrt 4.0;;
# sqrt 4.0;;
- : float = 2. *)
int_of_float 2.1 + int_of_float (-2.9);;
(*La suma de dos ints (obtenidos a partir de aplicar la función
int_of_float sobre 2.1 y (-2.9) respectivamente)
Dará 0 (int) dado que int_of_float de 2.1 es 2 y de (-2.9) es -2 *)
truncate 2.1 + truncate (-2.9);;
(*Se trunca 2.1, que es dos, y se trunca (-2.9) que es -2 el 
resultado será 0 (int) *)
floor 2.1 +. floor (-2.9);;
(*Se redondea hacía abajo 2.1 y (-2.9) lo que dá 2 y (-3) 
respectivamente, el resultado es -1.(float) *)
ceil 2.1 +. ceil (-2.9);;
(*Se redondea hacía arriba 2.1 y (-2.9) lo que dá 3 y (-2)
respectivamente, el resultado es 1(float) *)
'B';;
(*El char 'B' *)
int_of_char 'A';;
(*Devolverá en forma de int la posición de la letra A (mayúscula) 
en la tabla ASCII, que si no me equivoco es la 65*)
char_of_int 66;;
(*Devolverá el char que ocupe la posición 66 en la tabla ASCII
que si no me equivoco es la B (mayúscula) *)
Char.code 'B';;
(*Devolverá la posición de 'B' mayúscula en la tabla ASCII, que 
es la 66. int_of_char y Char.code son funciones muy similares: 
# (Char.code);;
- : char -> int = <fun>
# (int_of_char);;
- : char -> int = <fun>
*)
Char.chr 67;;
(*Devuelve el char que se encuentra en la posición 67 de la tabla
ASCII, que es la C (mayúscula) *)
'\067';;
(*El char con el valor 67 en la tabla ASCII, la C (mayúscula)*)
Char.chr (Char.code 'A' + Char.code 'a' + Char.code 'Ñ');;
(*Probablemente de error dado que la tabla ASCII solo va hasta
el 255, y la suma de el código correspondiente a:
'A' -> 65
'a' -> 97
'Ñ' -> 165 Resultado=371.
Se sale de la tabla ASCII, por lo que Char.chr 371 dará error;
# Char.chr (Char.code 'A' + Char.code 'a' + Char.code 'Ñ');;
Exception: Invalid_argument "Char.chr".
*) 
Char.uppercase 'ñ';;
(*Devolverá la posición de la Ñ mayúscula en forma de int*)
Char.lowercase 'O';;
(*Devolverá la posición de la o minúscula en forma de int*)
"this is a string";;
(*Esto es un string, literalmente xdddyoksetio*)
String.length "longitud";;
(*Devolverá en forma de int el número de caracteres que hay en
ese string *)
"1999" + "1";;
(*Error, ya que ese operador de suma solo funciona con int
Si se quería concatenar string se utiliza ^:
# "1999" ^ "1";;
- : string = "19991" *)
"1999" ^ "1";;
(*Concatena los dos string y como resultado devuelve "19991"*)
int_of_string "1999" + 1;;
(*Se obtiene un int a partir de un string ("1999") y se le suma 1*)
"\064\065";;
(*Un string formado por los caracteres 64 y 65 de la tabla ASCII,
@ y A, respectivamente*)
string_of_int 010;;
(*Un string que representa el int 010, el resultado será "10"*)
not true;;
(*El resultado es false*)
true && false;;
(*El operador && se corresponde con la función lógica AND,
true and false es false*)
true || false;; 
(*El operador || se corresponde con la función lógica OR,
true or fale es true*)
(1 < 2) = false;;
(*1 < 2 siempre es true, y true = false es false, por lo tanto el
resultado es false*)
"1" < "2";;
(*El string "1" ocupa una posición anterior al string "2", por lo
tanto el resultado es true (bool)*)
2 < 12;;
(*2 siempre es menor que 12, por lo tanto el resultado es true*)
"2" < "12";;
(*La posición del string "2" es mayor  que la que ocupa el string
"12", por lo tanto el resultado de esa expresión es false*)
"uno" < "dos";;
(*
"uno" está compuesto de:
	- u -> 117
	- n -> 110
	- o -> 111
	total: 338

"dos" está compuesto de;
	- d -> 100
	- o -> 111
	- s -> 115
	total: 326

por lo que tendríamos algo como 338 < 326, lo cual da false*)
2,5;;
(*Una tupla de ints*)
"hola", "adios";;
(*Una tupla de strings*)
0, 0.0;;
(*Una tupla de un int y un float*)
fst('a',0);;
(*Se devuelve el primer elemento de una tupla formada por un char
y un int, el resultado es el char 'a'*)
snd (false, true);;
(*Se devuelve el segundo elemento de una tupla formada por dos 
booleanos, false y true, por lo tanto el resultado es true*)
(1,2,3);;
(*Una tupla formada por tres ints, 1, 2 y 3*)
(1,2),3;;
(*Una tupla cuyo primer elemento es una tupla que contiene los ints
1 y dos, y cuyo segundo elemento es el int 3 *)
fst (1,2),3;;
(*Devuelve el primer elemento de esa tupla, que es una tupla que
contiene los ints 1 y 2*)
if 3 = 4 then 0 else 4;;
(*Devuelve el int 4, puesto que 3!=4, por lo que se va por la 
rama del else*)
if 3 = 4 then "0" else "4";;
(*Devuelve el string "4", puesto que 3!=4, por lo que se va por
la rama del else*)
if 3 = 4 then 0 else "4";;
(*Dará un error, puesto que se ha de utilizar el mismo tipo de 
datos en las dos ramas del if, y en la primera estamos 
devolviendo int y en la segunda un string

# if 3 = 4 then 0 else "4";;
Error: This expression has type string but an expression was
 expected of type int

La solución sería poner el mismo tipo de dato en ambas ramas, o
int en ambas o string en ambas:
	- if 3 = 4 then "0" else "4";;
	- if 3 = 4 then 0 else 4;;
*)
(if 3 < 5 then 8 else 10) + 4;;
(*El resultado será 8 + 4 = 12*)
let pi = 2.0 *. asin 1.0;;
(*A partir de ahora la palabra pi contendrá el doble del 
valor del arco cuyo seno es 1, es decir, que tendremos
una aproximación de pi bastante buena*)
sin (pi /. 2.);;
(*Devolverá el seno de pi medios, es decir, 1, en formato float*)
