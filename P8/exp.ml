type ari_exp = 
	| Const of int
	| Sum of ari_exp * ari_exp
	| Pro of ari_exp * ari_exp
	| Dif of ari_exp * ari_exp
	| Quo of ari_exp * ari_exp
	| Mod of ari_exp * ari_exp;;

(*La expresión 2 * 3 + 1 tendría la forma: 
 let e1 = Sum(Pro(Const 2, Const 3), Const 1)*)

let rec eval = function
	| Const n -> n
	| Sum(e1,e2) -> eval e1 + eval e2
	| Pro(e1,e2) -> eval e1 * eval e2
	| Dif(e1,e2) -> eval e1 - eval e2
	| Quo(e1,e2) -> eval e1 / eval e2
	| Mod(e1,e2) -> (eval e1) mod (eval e2);;
(*val eval : ari_exp -> int = <fun>*)

(*# eval (Sum(Pro(Const 2, Const 3), Const 1));;
- : int = 7*)

type biOper = Sm | Pr | Df | Qt | Md;;
type exp = C of int | Op of biOper * exp * exp;;

(*# Op(Sm, Op(Pr, C 2, C 3), C 1);;
- : exp = Op (Sm, Op (Pr, C 2, C 3), C 1)*)

(*(a.) Defina las funciones:
 exp_of_ari_exp : ari_exp -> exp 
 ari_exp_of_exp: exp -> ari_exp *)

let rec exp_of_ari_exp = function
	| Const n -> C n
	| Sum(e1,e2) -> Op(Sm, exp_of_ari_exp e1, exp_of_ari_exp e2)
	| Pro(e1,e2) -> Op(Pr, exp_of_ari_exp e1, exp_of_ari_exp e2)
	| Dif(e1,e2) -> Op(Df, exp_of_ari_exp e1, exp_of_ari_exp e2)
	| Quo(e1,e2) -> Op(Qt, exp_of_ari_exp e1, exp_of_ari_exp e2)
	| Mod(e1,e2) -> Op(Md, exp_of_ari_exp e1, exp_of_ari_exp e2);;
  (*val exp_of_ari_exp : ari_exp -> exp = <fun>*)
  (*# exp_of_ari_exp (Sum(Pro(Const 2, Const 3), Const 1));;
  - : exp = Op (Sm, Op (Pr, C 2, C 3), C 1)*)

let rec ari_exp_of_exp = function
	| C n -> Const n
	| Op(Sm,e1,e2) -> Sum(ari_exp_of_exp e1, ari_exp_of_exp e2)
	| Op(Pr,e1,e2) -> Pro(ari_exp_of_exp e1, ari_exp_of_exp e2)
	| Op(Df,e1,e2) -> Dif(ari_exp_of_exp e1, ari_exp_of_exp e2)
	| Op(Qt,e1,e2) -> Quo(ari_exp_of_exp e1, ari_exp_of_exp e2)
	| Op(Md,e1,e2) -> Mod(ari_exp_of_exp e1, ari_exp_of_exp e2);;
  (*val ari_exp_of_exp : exp -> ari_exp = <fun>*)
  (*# ari_exp_of_exp (Op (Sm, Op (Pr, C 2, C 3), C 1));;
  - : ari_exp = Sum (Pro (Const 2, Const 3), Const 1)*)

(*(b.) Implemente, utilizando la función opval, una función 
eval : exp -> int que calcule el valor de cada expresión 
aritmética en el nuevo tipo*)

let opVal = function
	| Sm -> (+)
	| Pr -> ( * )
	| Df -> (-)
	| Qt -> (/)
	| Md -> (mod);;
 (*(*val opVal : biOper -> int -> int -> int = <fun>*)*)

let rec eval = function
	| C n -> n
	| Op(oper,e1,e2) -> opVal(oper) (eval e1) (eval e2);;
  (*val eval : exp -> int = <fun>*)
  (*# eval (Op (Sm, Op (Pr, C 2, C 3), C 1));;
  - : int = 7*)

(*(c.) Implemente, para el nuevo tipo, funciones equivalente a
 las siguientes, que había definido para el tipo antiguo el 
 primer equipo:*)

  (*let conmut = function 
    Const n -> Const n
  | Sum (e1,e2) -> Sum (e2,e1)
  | Pro (e1,e2) -> Pro (e2,e1)
  | Dif (e1,e2) -> Dif (e2,e1)
  | Quo (e1,e2) -> Quo (e2,e1)
  | Mod (e1,e2) -> Mod (e2,e1);;*)
let conmut = function
	| C n -> C n
	| Op(oper,e1,e2) -> Op(oper,e2,e1);;

  (*let rec mirror = function 
    Const n -> Const n
  | Sum (e1,e2) -> Sum (mirror e2, mirror e1)
  | Pro (e1,e2) -> Pro (mirror e2, mirror e1)
  | Dif (e1,e2) -> Dif (mirror e2, mirror e1)
  | Quo (e1,e2) -> Quo (mirror e2, mirror e1)
  | Mod (e1,e2) -> Mod (mirror e2, mirror e1);;*)
let rec mirror = function
	| C n -> C n
	| Op(oper,e1,e2) -> Op(oper, (mirror e2), (mirror e1));;

(*let rec shift_left = function 
| Sum (x, Sum (y,z)) -> shift_left (Sum (Sum (x,y), z))
| Pro (x, Pro (y,z)) -> shift_left (Pro (Pro (x,y), z))
| Sum (e1,e2) -> Sum (shift_left e1, shift_left e2)
| Pro (e1,e2) -> Pro (shift_left e1, shift_left e2)
| Dif (e1,e2) -> Dif (shift_left e1, shift_left e2)
| Quo (e1,e2) -> Quo (shift_left e1, shift_left e2)
| Mod (e1,e2) -> Mod (shift_left e1, shift_left e2)
| e -> e;;
val shift_left : ari_exp -> ari_exp = <fun>*)
let rec shift_left = function
 | Op (oper1, C x, Op (oper2, C y, C z)) -> 
 	Op (oper1, Op (oper2, C x, C y), C z)
 | Op(oper, e1, e2) -> 
 	Op(oper, shift_left e1,  shift_left e2)
 | e -> e;;

(* Función que devuelve el string correspondiente 
a cada uno de los distintos tipos de operación del 
del tipo biOper.
- : biOper -> string = <fun>*)
let str_of_biOper = function
 | Sm -> "+" 
 | Pr -> "*"
 | Df -> "-"
 | Qt -> "/"
 | Md -> "%";;

(*let rec str_of_exp = function 
  Const n -> string_of_int n
| Sum (x,y) -> "(" ^ str_of_exp x ^ " + " ^ str_of_exp y ^ ")"
| Pro (x,y) -> "(" ^ str_of_exp x ^ " * " ^ str_of_exp y ^ ")"
| Dif (x,y) -> "(" ^ str_of_exp x ^ " ­ " ^ str_of_exp y ^ ")"
| Quo (x,y) -> "(" ^ str_of_exp x ^ " / " ^ str_of_exp y ^ ")"
| Mod (x,y) -> "(" ^ str_of_exp x ^ " % " ^ str_of_exp y ^ ")";;*)
(*# str_of_exp (Sum(Pro(Const 2, Const 3), Const 1));;
- : string = "((2 * 3) + 1)"*)
let rec str_of_exp = function
 | C n -> string_of_int n
 | Op(oper,x,y) ->	
    "(" ^ str_of_exp x ^ " " ^ (str_of_biOper oper) 
    ^ " " ^str_of_exp y ^ ")";;

(*let rec rpn = function 
  Const n -> " " ^ string_of_int n
| Sum (e1,e2) -> rpn e1 ^ rpn e2 ^ " +"
| Pro (e1,e2) -> rpn e1 ^ rpn e2 ^ " *"
| Dif (e1,e2) -> rpn e1 ^ rpn e2 ^ " ­"
| Quo (e1,e2) -> rpn e1 ^ rpn e2 ^ " /"
| Mod (e1,e2) -> rpn e1 ^ rpn e2 ^ " %";;*)
(*# rpn (Sum(Pro(Const 2, Const 3), Const 1));;
- : string = " 2 3 * 1 +"*)
let rec rpn = function
  | C n -> " " ^ string_of_int n
  | Op(oper,e1,e2) -> 
      rpn e1 ^ rpn e2 ^ " " ^ (str_of_biOper oper);;


(*(d.) Ponga ejemplos (ilustrativos, pero lo más sencillos 
que pueda) de valores e: exp tales que*)

(*conmut e = e*)
let e = Op(Sm, C 2, C 2);;
conmut e = e;;
(*conmut e <> e*)
let e = Op (Sm, Op (Sm, C 2, C 3), C 1);;
conmut e <> e;;
(*conmut e = mirror e*)
let e = Op(Sm, C 2, C 2);;
conmut e = mirror e;;
(*conmut e <> mirror e*)
let e = Op(Sm, Op(Sm, C 2, C 3), C 2);;
conmut e <> mirror e;;
(*eval e = eval(conmut e)*)
let e = Op(Sm, C 2, C 2);;
eval e = eval(conmut e);;
(*eval e <> eval(conmut e)*)
let e = Op(Df, C 3, C 2);;
eval e <> eval(conmut e);;
(*eval e = eval(mirror e)*)
let e = Op(Sm, C 2, C 2);;
eval e = eval(mirror e);;
(*eval e <> eval(mirror e)*)
let e = Op(Df, C 3, C 2);;
eval e <> eval(mirror e);;
(*eval e = eval (conmut e) && eval e <> eval (mirror e)*)
let e  = Op(Sm, Op(Df, C 3, C 5), C 2);;
eval e = eval (conmut e) && eval e <> eval (mirror e);;
(*eval e = eval (shift_left e)*)
let e = Op (Sm, Op (Pr, C 2, C 3), C 1);;
eval e = eval (shift_left e);;
(*eval e <> eval (shift_left e)*)
let e = Op (Qt, C 2, Op(Pr, C 2, C 4));;
eval e <> eval (shift_left e);; 