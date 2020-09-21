(*let rec suml = function 
    [] ­> 0
  | h::t ­> h + suml t;;*)
let suml l = 
	let rec aux l a =
		match l with 
		 [] -> a
		| h::t -> aux t (a+h)
	in aux l 0;;

(*let rec maxl = function 
    [] ­> raise (Failure "maxl")
  | h::[] -­> h
  | h::t -> max h (maxl t);;*)
let maxl l = 
	let rec aux l n = 
		match l with
		 [] -> raise (Failure "max")
		| h::[] -> max h n
		| h::t -> aux t (max h n)
	in aux l 0;;

(*let rec to0from n = 
    if n<0 then []
    else n :: to0from (n­1);;*)
let to0from n =
	let rec aux l = function
			 0 -> List.rev (0::l)
			| n -> aux (n::l) (n-1)
	in aux [] n;;

(*let rec fromto m n =
    if m > n then []
    else m :: fromto (m+1) n;;*)
let rec fromto m n =
        let rec aux (i,l) =
            if i < m 
            	then l
            	else aux (i-1, i::l)
        in aux (n, []);;

(*let rec from1to n =
    if n < 1 then []
    else from1to (n­1) @ [n];;*)
let from1to n = fromto 1 n;;

(*let append = List.append;;*)
let append l1 l2 =
	let rec aux la l1 l2 = 
		match l1 with
			 [] -> List.rev_append la l2
			| h::t -> aux (h::la) t l2
	in aux [] l1 l2;;

(*let concat = List.concat;;*)
let concat l1 = 
	let rec aux l1 la =
		match l1 with
			 [] -> la 
			| h::t -> aux t (append la h)
	in aux l1 [];;

(*let map = List.map;;*)
let map f l = 
	let rec aux f l la =
		match l with 
			 [] -> List.rev la
			| h::t -> aux f t (f(h)::la)
	in aux f l [];;

(*let power x y = 
    let rec innerpower x y =
        if y = 0 then 1 
        else x * innerpower x (y­1)
    in 
    if y >= 0 then innerpower x y
    else invalid_arg "power";;*)
let power x y = 
	if y<0
		then invalid_arg "power"
		else
			let rec aux x y z = 
				match y with
					 0 -> z
					| y -> aux x (y-1) (x*z)
			in aux x y 1;;

(*let fib n =
    let rec innerfib n =
        if n < 2 then n
        else innerfib (n­1) + innerfib (n­2)
    in
    if n >= 0 then innerfib n
    else invalid_arg "fib";;*)
let fib n = 
	if (n < 0)
		then invalid_arg "fib"
		else 
			let rec aux x y = function 
				 0 -> x
				| n -> aux y (x+y) (n-1)
			in aux 0 1 n;;

(*let fact n =
    let rec innerfact n =
        if n = 0 then 1.
        else float n *. innerfact (n)
    in 
    if n >= 0 then innerfact n
    else invalid_arg "fact";;*)
let fact n = 
	if n<0 
		then invalid_arg "fact"
		else
			let rec aux a = function
			 	 0 -> a 
			 	| n -> aux(float n *. a) (n-1)
			in aux 1. n;;

(*let incseg l = List.fold_right (fun x t -> x::List.map ((+) x) t) l [];;*)
let incseg l = 
	let rec aux l1 l2 a = 
		match l1 with 
			 [] -> List.rev l2
			| h::t -> aux t ((h+a)::l2) (h+a) 
	in aux l [] 0;;

(*let rec multicomp l x = match l with
    [] -> x
  | f::t -> f (multicomp t x);;*)
let multicomp l x = 
	let rec aux l x =
		match l with
			 [] -> x
			| h::t -> aux t (h x)
	in aux (List.rev l) x;;

(*let rec insert x = function 
        [] ­> [x]
      | h::t -> if x <= h then x::h::t
                else h :: insert x t;;*)
let insert x l = 
	let rec aux x l la = 
		match l with 
			 [] -> List.rev_append la (x::l)
			| h::t -> if (x <= h)
						then List.rev_append la (x::l)
						else aux x t (h::la)
	in aux x l [];;

(*let rec insert_gen f x l = match l with
        [] -> [x]
      | h::t -­> if f x h then x::l
                else h :: insert_gen f x t;;*)
let insert_gen f x l = 
	let rec aux f x l la = 
		match l with 
			 [] -> List.rev_append la (x::l)
			| h::t -> if f x h 
						then List.rev_append la (x::l)
						else aux f x t (h::la)
	in aux f x l [];;


























