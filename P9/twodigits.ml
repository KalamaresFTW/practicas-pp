(*APARTADO 1*)
(*El número de sublistas generadas se deduce la expresión 2^n, 
	siendo n el número de elementos de la lista original*)
let rec sublists = function
	| [] -> [[]]
	| h::t -> let st = sublists t in
	 			List.map (function l -> h::l) st @ st;;
(*Función mem : 'a -> 'a list -> bool 
	que utilizaremos para saber si un elemento está 
	contenido en una lista*)
let rec mem x = function
	| [] -> false
	| h::t -> (h = x) || (mem x t);;
(*Función remove : 'a -> 'a list -> 'a list 
	elimina la primera aparición de un elemento en una lista*)
let remove e l =
	let rec aux n = function 
		| [] -> List.rev n
		| h::t -> if h <> e 
					then aux (h::n) t
					else List.rev_append n t
	in aux [] l;;
(*Función intersect : 'a list -> 'a list -> 'a list
	devuelve la intersección de l1 y l2*)
let rec intersect l1 l2 = 
	match l1 with
	| [] -> if l2 = [] 
			 then [] 
			 else intersect l2 l1
	| h::t ->
	    if mem h l2 
			then let l2' = remove h l2 
				  in h::(intersect t l2')
	      	else intersect t l2;;
(*Función is_sublist_of : 'a list -> 'a list -> bool 
	Por definición la intersección de dos conjuntos disjuntos A y B 
	es el conjunto vacío.
	Si las listas l1 y l2 son subconjuntos disjuntos, la 
	intersección de ambas es el conjunto vacío (la lista vacía).
	Por lo tanto, si las dos listas tienen algún elemento en común
	su intersección será distinta de la lista vacía.*)
let is_sublist_of l1 l2 = (intersect l1 l2) <> [];;
(*análogamente he definido también la función not_sublist_of*)
let not_sublist_of l1 l2 = (intersect l1 l2) = [];;
(*Función search_one
	('a  list -> ‘a list -> bool) -> 'a list -> 'a list * 'a list
	devuelve un par de sublistas de (l1,l2) que 
	cumplen la propiedad p indicada.
	Si no existe tal par, se activa la excepción Not_found.*)
let search_one p l = 
	let sl = sublists l in 
		let rec aux1 = function
			| [] -> raise Not_found
			| h1::t1 -> 
				let rec aux2 h1 = function
					| [] -> aux1 t1
					| h2::t2 -> 
						if p h1 h2 && (h1 <> h2)
						 then (h1,h2)
						 else (aux2 h1 t2)  
				in aux2 h1 sl
		in aux1 sl;;
(*Función search_all
	('a list -> 'a list -> bool) -> 'a list -> ('a list * 'a list) list
	similar a la anterior, solo que esta vez vamos acumulando los 
	resultados que encontremos y lo devolvemos todos juntos al final.*)
let search_all p l =
	let sl = sublists l in 
		let rec aux1 accu = function
			| [] -> if accu <> [] 
			 		 then accu
			 		 else raise Not_found
			| h1::t1 -> 
				let rec aux2 h1 accu = function
					| [] -> aux1 accu t1
					| h2::t2 -> 
						if p h1 h2 && (h1 <> h2)
						 then aux2 h1 ((h1,h2)::accu) t2
						 else aux2 h1 accu t2
				in aux2 h1 accu sl
		in aux1 [] sl;; 

(*APARTADO 2*)
(*Función suml : int list -> int
	suma todos los elementos de una lista de ints.*)
let suml l = 
	let rec aux l a =
		match l with 
		 [] -> a
		| h::t -> aux t (a+h)
	in aux l 0;;
(*Función test_suml : int list -> int list -> bool 
	es la propiedad de test del juego "Two Digits".*)
let test_twodigits l1 l2 = (not_sublist_of l1 l2) && (suml l1 = suml l2);;

(*Función valid_question : int list -> bool
	para que una lista represente una pregunta/puzzle válida/o en
	el "Two Digits" este debe tener nueve números enteros, que todos 
	sean menores que 100 y que además la pregunta tenga al menos
	una respuesta válida. (no considero ([],[]) como respuesta válida).*)
let valid_question l = 	
	try 
		let sol = (search_one test_twodigits l)
		in (List.length l = 9)
			&& not(mem false (List.map (function x -> x<100) l))
			&& (sol <> ([],[]))
	with Not_found -> false;;
(*Función solve_twodigits : int list -> (int list * int list) option
	si la lista l es un puzzle válido según la definición anterior 
	entonces devuelve una solución válida, si no devuelve None.*)
let solve_twodigits l = if (valid_question l)
						 then Some(search_one test_twodigits l)
					     else None;;
(*Pseudo-función rlist : int -> int -> int list
	devuelve una lista de n números enteros "aleatorios" que 
	varian desde 1 a r-1 (he excluido el 0 por ser un número
	que no tiene gracia en el contexto de este juego)*)
let rlist r n = 
	if r>0 && n>=0 then
		let rec aux r n l = 
			if n<1 
			 then l
			 else let random = Random.int r 
					in if random <> 0 (*esto es para que se no generen
										listas que contengan algún 0*)
						then aux r (n-1) ((random)::l)
						else aux r (n-1) ((random+1)::l)
		in aux r n []
	else raise (Invalid_argument "rlist");;
(*Pseudo-función twodigits_puzzle : unit -> int list 
	genera puzzles hasta que encuentra uno válido según la definición
	que hemos postulado anteriormente de puzzle válido*)
let rec twodigits_puzzle () =
	let puzzle = rlist 100 9
		in if valid_question puzzle 
			then puzzle
			else twodigits_puzzle ();;
(*Pseudo-función crono : ('a -> 'b) -> 'a -> 'b * float
	versión modificada de crono que devuelve en el primer
	elemento de una tupla el resultado de aplicar a una 
	función f un argumento x y en el segundo elemento
	el tiempo que ha tardado en realizar esa operación.*)
let crono f x = 
		let t = Sys.time () in
		let resultado = f x in
		resultado,(Sys.time () -. t);;
(*Medimos el tiempo y podemos ver si los resultados tienen sentido
let crono f x = 
		let t = Sys.time () in
		let resultado = f x in
		resultado,(Sys.time () -. t);;
crono solve_twodigits (twodigits_puzzle ());;

List.length (search_all test_suml (twodigits_puzzle ()));;
Si ejecutamos esto varias veces podemos ver como mas o menos el
número de soluciones de un puzzle generado con twodigits_puzzle
oscila valores mayores de 20 y menores de 70 *)

(*APARTADO 3*)
let n = 9;;
(*Función suml_mod256 : int list -> int
	Esta función suma todos los elementos de una lista en módulo 256*)
let suml_m256 l = 
	let rec aux l a =
		match l with 
		 [] -> ((mod) a 256)
		| h::t -> aux t (a+h)
	in aux l 0;;
(*Función suml_mod_eq : int list -> int list -> bool
	Comprueba si dos listas suman lo mismo en módulo 256*)
let test_bytes l1 l2 = (not_sublist_of l1 l2) && (suml_m256 l1 = suml_m256 l2);;

(*Función valid_question_bytes : int list -> bool
	Nos dice si una lista de enteros representa un puzzle válido.
	Para que un puzzle sea válido ha de tener n elementos y 
	por lo menos una solución.*)
let valid_question_bytes l = 	
	try 
		let sol = (search_one test_bytes l)
		in (List.length l = n) && (sol <> ([],[]))
	with Not_found -> false;;
(*Pseudo-función bytes_puzzle: unit -> int list
	genera aleatoriamente puzzles para esta variante del juego.
	Evidentemente, sólo se generarán puzzles que puedan ser 
	resueltos.*)
let rec bytes_puzzle () =
	let puzzle = rlist 256 n
		in if valid_question_bytes puzzle 
			then puzzle
			else bytes_puzzle ();;
(*Función solve_bytes: int list -> (int list * int list) option
	busca soluciones para esta variante del problema.*)
let solve_bytes l = if (valid_question_bytes l)
						then Some(search_one test_bytes l)
						else None;;

(*crono solve_bytes (bytes_puzzle ());;
List.length (search_all test_bytes (bytes_puzzle ()));;
Si ejecutamos esto varias veces podemos ver como mas o menos el
número de soluciones de un puzzle generado con bytes_puzzle
es similar al de twodigits*)