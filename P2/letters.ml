(*Ejercicio 2: hacer nuestras propias versiones del:
	-Char.uppercase
	-Char.lowercase
Tener en cuenta que este ejercicio ha sido realizado 
teniendo en cuenta que la codificación de caracteres utilizada
es la: ISO8859-1, también funcionaría con la ISO8859-15*)

(*Nombre de la función: lowercase
Tipo: char -> char*
Uso: Toma un carácter c y devuelve, si lo hay, su minúscula, 
si no tiene minúscula devuelve c*)

let lowercase c =
	if (c >= '\065' && c <='\090') (*Carácteres de la A a la Z*)
	|| (c >= '\192' && c <='\214')
	|| (c >= '\216' && c <='\222')
	then Char.chr( (Char.code c) + 32)
	else  c;;


(*Nombre de la función: uppercase
Tipo: char -> char*
Uso: Toma un carácter c y devuelve, si lo hay, su mayúscula,
si no tiene mayúscyla devuelve c*)

let uppercase c =
	if (c >= '\097' && c <='\122') (*Carácteres de la a a la z*)
	|| (c >= '\224' && c <='\246')
	|| (c >= '\248' && c <='\254') 
	then Char.chr( (Char.code c) - 32)
	else  c;;

let rec compare f1 f2 c =
  if c = 0 then f1 (Char.chr c) = f2 (Char.chr c)
  else f1 (Char.chr c) = f2 (Char.chr c) && compare f1 f2 (c-1);;

(* Podemos comprobar que las funciones del modulo Char y las que hemos
definido ahora son tienen la misma imagen acotadas en el rango (0,254)

# compare Char.uppercase uppercase 254;;
- : bool = true

# compare Char.lowercase lowercase 254;;
- : bool = true 
*)