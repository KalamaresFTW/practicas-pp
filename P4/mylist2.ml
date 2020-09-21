let hd = function
	 [] -> raise (Failure "hd")
	| h::_ -> h;;

let tl = function 
	 [] -> raise (Failure "tl")
	| _::t -> t;;

(*let rec length = function
	 [] -> 0
	| _::t -> 1 + length t;;*)
let length l = 
	let rec aux n = function 
		 [] -> n
		| _::t -> aux (n+1) t
	in aux 0 l;;

(*let rec nth l = function 
	 0 -> if (l == []) 
			then raise (Failure "nth") 
			else (hd l)
	| n -> if (n < 0) 
			then raise (Invalid_argument "nth") 
			else nth (tl l) (n-1);;*)
let nth l n = 
	if n>=0 then
		let rec aux l n = 
			match l with
			 [] -> raise(Failure "nth")
			| h::t -> if n=0 
						then h 
						else aux t (n-1)
		in aux l n
	else 
		raise (Invalid_argument "nth");;

let rec append l1 l2 = 
	match l1 with
	 [] -> l2
	| h::t -> h::(append t l2);;

(*let rec rev = function
	 [] -> []
	| h::t -> append (rev t) [h];;*)
let rev l = 
	let rec aux a = function 
		[] -> a
		| h::t -> aux (h::a) t
	in aux [] l;;

(*let rev_append l1 l2 = append (rev l1) l2;;*)
let rev_append l1 l2 = 
	let rec aux a b =
		match a with
		 [] -> b
		| h::t -> aux t (h::b)
	in aux l1 l2;;

let rec concat = function 
	 [] -> []
	| h::t -> append h (concat t);;

let flatten = concat;;

let rec map f = function
	 [] -> []
	| h::t -> (f h)::(map f t);;

let rec map2 f l1 l2 = 
	match l1,l2 with
  	 [], [] -> []
  	| h1::t1, h2::t2 -> (f h1 h2)::(map2 f t1 t2)
  	| _ -> raise (Invalid_argument "map2");;

let rec fold_left f n l = 
	match l with
  	 [] -> n 
  	| h::t -> fold_left f (f n h) t;;

let rec fold_right f l a =
  match l with
    [] -> a
| h::t -> f h (fold_right f t a);;

let rec find f l = 
	match l with
	 [] -> raise (Not_found)
	| h::t -> if (f h) 
				then h 
				else find f t;;

let rec for_all f l = 
	match l with
	 [] -> true
	| h::t -> (f h) && (for_all f t);;

let rec exists f l =
	match l with
	 [] -> false
	| h::t -> (f h) || (exists f t);;

let rec mem n l = 
	match l with
	 [] -> false
	| h::t -> (h==n) || (mem n t);;

(*let rec filter f l =
	match l with
	 [] -> []
	| h::t -> if (f h) 
					then h::(filter f t)
					else (filter f t);;*)
let filter f l =
	let rec aux n = function
		  [] -> rev n 
		 | h::t -> if (f h)
		 			then aux (h::n) t
		 			else aux n t
	in aux [] l;;

let rec find_all = filter;;

let partition f l = 
	let rec part (l1,l2) = function
		 [] -> rev l1, rev l2
		| h::t -> if (f h) 
					then part ((h::l1), l2) t 
					else part (l1, (h::l2)) t
		in part ([],[]) l;;

let split l = 
	let rec aux (l1,l2) = function
		 [] -> (rev l1, rev l2)
		| (a1,a2)::t -> (aux (a1::l1,a2::l2) t)
	in aux ([],[]) l;;

let rec combine l1 l2 = 
	match (l1,l2) with
	 ([],[]) -> []
	| (h1::t1), (h2::t2) -> (append [(h1,h2)] (combine t1 t2))
	| (_,_) -> raise (Invalid_argument "combine");;

(*let rec remove e = function
	 [] -> []
	| h::t -> if (e == h) 
				then t
				else h::remove e t;;*)
let remove e l =
	let rec aux n = function 
		 [] -> rev n
		| h::t -> if (h<>e) 
					then aux (h::n) t
					else rev_append n t
	in aux [] l;; 

let rec remove_all e = function
	 [] -> []
	| h::t -> if (e == h) 
				then remove_all e t
				else h::remove_all e t;;

 let rec ldif l1 l2 = 
 	match (l1, l2) with
 	 ([], []) -> []
 	| (l1, []) -> l1
 	| (l1, h::t) -> ldif (remove_all h l1) t;;

let rec lprod l1 l2 =
	match l1 with
	 [] -> [] 
	| h::t -> append (map (function x -> (h,x)) l2) (lprod t l2);;

(*let rec divide = function 
	 h1::h2::t -> let t1,t2 = 
				divide t in (h1::t1, h2::t2)
	| [] -> [],[]
	| [h] -> [h],[];;*)
let divide l =
	let rec aux a (l1,l2) = match a with
			 [] -> (rev l1), (rev l2) (*Este caso se dará al final de las listas de longitud par*)
			| h1::h2::t -> aux t (h1::l1, h2::l2)
			| h::[] -> rev (h::l1), rev l2 (*Este caso se dará al final de las de longitud impar*)
	in aux l ([],[]);;