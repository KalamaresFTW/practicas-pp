(*Compilar con:
	ocamlc -o fib nums.cma fib.ml
	donde:
		-o: indica el nombre del ejecutable a generar
		fib: el nombre del ejecutable
		nums.cma: biblioteca para trabajar con números 
					absurdamente grandes, tenemos que linkearla
					desde aquí. Para hacerlo desde el intérprete 
					escribimos: #load "nums.cma"
		fib.ml: el nombre del fichero con el fuente*)
open Num;;
let arg = num_of_string Sys.argv.(1);;

let zero = num_of_int 0;;
let uno = num_of_int 1;;

(*Versión original del algoritmo
let rec fib n =
	if n > 1 
		then fib (n­1) + fib (n­2) 
		else n;;*)


(*Versión recursiva terminal de la función anterior
let fib n = 
	if (n < 0)
		then invalid_arg "fib"
		else 
		let rec aux x y = function 
			| 0 -> x
			| n -> aux y (x+y) (n-1)
		in aux 0 1 n;;*)

(*Esta es la versión recursiva terminal que trabaja con Num.
  En este caso utilizo una definición local para obtener 
  directamente el término proporcionado por paŕámetro.*)
let fibn =
	let fib n = 
		if (n < zero)
			then invalid_arg "fib"
			else 
			let rec aux x y n = 
				if n = zero 
					then x
					else aux y (x+/y) (n-/uno)
			in aux zero uno n
in fib arg;;

(*Versión utilizando matrices, no es recursiva terminal
let fib n = 
   let rec fibonacci n = 
     match n with 
     | 0 -> (0, 0)
     | 1 -> (0, 1) 
     | m -> let (a, b) = fibonacci (m-1) in (b, a+b) 
     			in let (_, k) = fibonacci n 
     				in k;;*)

print_endline (string_of_num fibn);;