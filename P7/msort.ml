(*1)  Implemente (con el mismo tipo) una versión r_list_t
recursiva terminal.*)
let r_list_t r n = 
 if r>0 && n>=0 then
  let rec aux r n l = 
   if n<1 
    then l
    else aux r (n-1) ((Random.int r)::l)
  in aux r n []
 else raise (Invalid_argument "rlist");;

(*La función divide sirve para repartir equitativamente,
en dos, los elementos de una lista.*)
let rec divide = function 
  | h1::h2::t -> let t1,t2 = divide t in (h1::t1, h2::t2)
  | l -> l,[];;

(*La función merge sirve para reunir, respetando una relación 
de orden dada, en una lista, los elementos de dos listas, 
si estas están ordenadas según esa misma relación de orden.*)
let rec merge ord (l1,l2) = 
  match l1,l2 with
  | [],l | l,[] -> l
  | h1::t1,h2::t2 -> if ord h1 h2 
                     then h1::merge ord (t1,l2)
                     else h2::merge ord (l1,t2);;

(*2) Defina, utilizando las funciones divide y merge, 
una función m_sort: ('a -> 'a -> bool) -> 'a list -> 'a list
que implemente el método de ordenación por fusión*)
let rec m_sort ord = function
  | [] -> []
  | [h] -> [h]
  | list -> let l1, l2 = divide list in
              merge ord ((m_sort ord l1),(m_sort ord l2));;

(*3. Defina de modo recursivo terminal funciones divide_t y merge_t 
(con el mismo tipo que divide y merge, respectivamente) que sirvan 
para el mismo objetivo.*)
let divide_t l =
 let rec aux a (l1,l2) =
  match a with
  | [] -> (List.rev l1), (List.rev l2)
  | h1::h2::t -> aux t (h1::l1, h2::l2)
  | h::[] -> List.rev (h::l1), List.rev l2
 in aux l ([],[]);;

let merge_t ord (l1,l2) =
  let rec aux ord a = function
    | [], [] -> List.rev a
    | [], h :: t -> aux ord (h :: a) ([],t)
    | h :: t, [] -> aux ord (h :: a) (t,[])
    | h1 :: t1, h2 :: t2 -> if ord h1 h2
                        then aux ord (h1 :: h2 :: a) (t1,t2)
                        else aux ord (h2 :: h1 :: a) (t2,t1)
  in aux ord [] (l1,l2);;

(*4. Realice una nueva implementación del método de ordenación por 
fusión, m_sort2: ('a -> 'a -> bool) -> 'a list -> 'a list, utilizando 
ahora las funciones divide_t y merge_t*)
let rec m_sort2 ord l = 
  match l with
  | [] -> []
  | [h] -> [h]
    | list -> let l1, l2 = divide_t list 
        in merge_t ord ((m_sort2 ord l1),(m_sort2 ord l2));;
