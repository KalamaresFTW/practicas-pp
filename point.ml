class point (x_init, y_init) = 
    object (this)
        (*Si no hacemos estas asignaciones, el intérprete determinará
            que la clase point es una clase abstracta, imaginaria*)
        val mutable x = x_init
        val mutable y = y_init
        (*No estamos utilizando el operador (!) para acceder
            al valor de x como si este fuese un ref*)
        method get_x = x
        method get_y = y
        (*Para los setters estamos utilizando el 
            operador (<-) para almacenar el nuevo valor de x(x')*)
        method set_x x' = x <- x'
        method set_y y' = y <- y'
        method moveto (x',y') = x <- x'; y <- y'
        (*Este es el primer método del que se puede inferir el tipado 
            de x e y, son int, dado que estás utilizando el operador de suma
            de enteros (+) *)
        method movetor (dx,dy) = x <- -x + dx;  y <- -y + dy
        (*Lo de ponerle unit es porque es un procedimiento que no 
            toma ningún parámetro de entrada*)
        (*El to_string tenemos que definirlo a mano, como animales*)
        method to_string () = "(x=" ^ (string_of_int x) ^
                              " - y=" ^ (string_of_int y) ^ ")"
        method distance () = sqrt(float(abs(x*x-y*y)))
        (*Método privado, solo será accesible desde métodos de la propia clase
            y desde las posibles subclases de point*)
        method private mprivado () = "metodo privado" 
        method mpublico () = "Estamos llamando a un " ^ this#mprivado ()
end;;

(*Para instanciar objetos de la clase point hacemos lo siguiente: *)
    let p1 = new point(1,2);;
    (*val p1 : point = <obj>*)
    let p2 = new point(1,3);;
    (*val p2 : point = <obj>*)
    let l = [p1,p2];;
    (*val l : (point * point) list = [(<obj>, <obj>)]*)
    let fid x = x;;
    (*val fid : 'a -> 'a = <fun>*)
    fid l;;
    (*- : (point * point) list = [(<obj>, <obj>)]*)
    fid p1;;
    (*- : point = <obj>*)

(*Para llamar a los métodos de la instancia del punto*)
    p1#set_y 10;;
    (*- : unit = ()*)
    p1#to_string ();;
    (*- : string = "(x=1 - y=10)"*)
    p1#distance ();;
    (*- : float = 9.9498743710662*)
    p1#to_string;;
    (*- : unit -> string = <fun>*)
    let f = p1#to_string;;
    (*val f : unit -> string = <fun>*)
    let afs = [|f; (fun () -> "hola")|];;
    (*val afs : (unit -> string) array = [|<fun>; <fun>|]*)
    (*El método f siempre estará ligado al to_string de p1, de 
        forma que si modificas el valor de alguno de sus atributos 
        este cambio se verá reflejado al llamar a f () o a afs.(0) ()*)

    (*Los atributos de una clase son siempre privados, se leen desde sus
        getters y se modifican usando sus setters*)

    (*Los métodos son públicos por defecto, pero podemos definir métodos
        privados (solo accesibles desde otros métodos de la própia clase
        y desde las subclases)*)

    (*Podemos hacer movidas tochísimas, p.e:*)
    (new point(1,3))#distance ();;
    (*- : float = 2.82842712474619029*)
    let fcreate x y = new point(x,y);;
    (*val fcreate : int -> int -> point = <fun>*)
    (fcreate 2 3)#distance ();;
    (*- : float = 2.23606797749979*)

    (*La evaluación del objeto tiene lugar durante su creación
        Concepto de constructor:
            - NO hay método constructor.
            - es la própia CLASE que funciona como
                constructora/generadora de las instancias
                de esa clase (se comporta como una función
                anónima que se activa sólo con new).
            - cuando declaramos la clase point el toplevel 
                nos dice algo así como que:
                    int * int -> object [...] end
                esto se puede interpretar como que la función
                generadora "new" toma como entrada un par de 
                enteros y como salida un objeto de tipo point
                new point;;
                - : int * int -> point = <fun>
            - se puede definir "indirectamente" una clase a partir
                de otra ya existente (esto no tiene nada que ver
                con el concepto de herencia, point_diagonal NO
                es una subclase de point, esto lo que hace es 
                particularizar la clase point)*)
                class point_diagonal x = point(x,x);;
                let d1 = new point_diagonal 1;;
                (*val d1 : point_diagonal = <obj>*)
                d1#get_x;;
                (*- : int = 1*)
                d1#get_y;;
                (*- : int = 1*)
    (*Objetos inmediatos
        podemos hacer una analogía de los objetos inmediatos
        con el siguiente ejemplo:
            List.map (function x -> x+1) lista
        pero en vez de definir funciones en el momento
        (on the fly). La sintaxis es así:*)
            let p1d = 
                object
                    val mutable x = 0
                    method get_x = x
                    method moveto x' = x <- x'
                end;;
            (*val p1d : < get_x : int; moveto : int -> unit > = <obj>*)
            p1d#get_x;;
            (*- : int = 0*)
            p1d#moveto (-100);;
            (*- : unit = ()*)
            p1d#get_x;;
            (*- : int = -100*)
        (*Funciones factoría, no confundir con aquéllas otras funciones
            que también devuelven/crean objetos utilizando new*)
            let factoria_p1d (x_init: int) = 
                object
                    val mutable x = x_init
                    method get_x = x
                    method moveto x' = x <- x'
                end;;
            (*    Ventajas de esta movida: 
                - más flexibilidad
                 Desventajas: 
                 - legibilidad y mantenimiento se complican
                 - no es posible aplicar herencia*)

(*Clases, objetos y sus tipos
Sistemas de tipado (Java, C++, C#):
I.- Tipado nominal:
    La equivalencia/compatibilidad viene dada por:
    - Por el nombre del tipo
        (por ejemplo en Java -> tipo = clase)
    - Declaraciones explicitas del programador
        (por ejemplo en Java -> las subclases son compatibles
            con objetos de la superclase -> extends)

II.- Tipado estructural (OCaml, Haskell, Smalltalk):
    La equivalencia/compatibilidad viene dada por una única cosa:
    la estructura del elemento, independientemente del nombre. Las 
    clases dejan de ser tipos, las clases y los objetos tendrán sus
    propios tipos. Las clases son constructores de objetos, pero ya
    NO son consustanciales (Objetos inmediatos -> podemos crear 
    objetos sin crear la clase, lo que hacemos con las funcones 
    factoría. Entonces, los objetos y sus tipos están separados del 
    sistema de clases. Pero para la herencia SI necesitamos las clases.)
        Ventajas: 
            - es mas flexible/menos restrictivo
        Desventajas: 
            -que tenga la misma estructura no implica
                necesariamente que sean compatibles desde
                    el punto devista semántico
     
    OCaml -> tipado estructural -> tipo del objeto = (conjunto/colección)
    de las firmas de los métodos públicos del objeto (nombre+tipo).
    Si un objeto tiene los mismos métodos públicos con el mismo tipo y el 
    mismo nombre, que otro objeto para el lenguaje esos dos objetos son
    del mismo tipo.
    No tiene en cuenta:
        - atributos del objeto.
        - métodos privados del objeto.
        - parámetros del constructor.
    Como consecuencia puede ocurrir que:
        - tengamos objetos con el mismo tipo pero diferentes clases.
        - (o viceversa)tengamos objetos con tipo diferente pero de la
             misma clase. *)
    class point1D x_init = 
        object 
            val mutable x = x_init
            method get_x = x
            method moveto d = x <- x + d
        end;;
    class cotro_clase (l_init: int list) = 
        object (this)
            val mutable l = l_init
            method get_x = List.hd l
            method private imprime str = print_endline str
            method moveto n = this#imprime (string_of_int n)
        end;;
    let a1 = [| new point1D 25; new cotro_clase [-2;-1;0] |];;
    (*Podemos hacer cosas de este estilo, porque ambas clases tienen el 
    mismo tipo, el tipo de a1 es: val a1 : point1D array = [|<obj>; <obj>|]*)

    (*Definición manual/explicita del tipo de un objeto:
        type id_object_type = <id_metodo1 : tipo1 ;... ; id_metodoN : tipoN >*)
        type int_object = <get_x:int>;;
        (*type int_object = < get_x : int >*)
        let objeto_educado1 = 
            object
                method saludar () = print_endline "hola" 
                method despedirse () = print_endline "adios"
            end;;
        (*# objeto_educado1;;
        - : < despedirse : unit -> unit; saludar : unit -> unit > = <obj>*)
        type formal = <saludar : unit -> unit ; despedirse : unit -> unit>;;
        let objeto_educado2 = 
            object
                method saludar () = print_endline "hola" 
                method despedirse () = print_endline "adios"
            end;;
        (*val objeto_educado2 
        : < despedirse : unit -> unit; saludar : unit -> unit > = <obj> *)
        (*No le aplica el tipo formal automáticamente, tenemos que hacerlo en
        la declaración de la clase*)
        let objeto_educado3 : formal = 
            object
                method saludar () = print_endline "hola" 
                method despedirse () = print_endline "adios"
            end;;
        (*val objeto_educado3 : formal = <obj>*)
        let (ffactoria : string -> string -> formal) saludo despedida = 
            object
                method saludar () = print_endline saludo
                method despedirse () = print_endline despedida
            end;;
        let objeto_educado4 = factoria "hello" "godbye";;
    (*Definición automática/implícita.
        cuando deinimos una clase (id_clase), OCaml automáticamente define un
        object type para designar el tipo de los objetos que crea, y lo llama 
        id_clase *)


(*Class Types/Interfaces*)
class walking_point1D x_init = 
    object (self)
        val mutable x = x_init
        method get_x = x
        method private move d = x <- x + d
        method bump () = self#move 1
         (*Si quieres utilizar un método própio tienes que utilizar un alias
             en este caso utilizamos "self", pero puede ser cualquier cosa.*)
         (*Ojo con sobrecargar los métodos, que OCaml tiene un tipado fuerte 
             y sobretodo estático *)
    end;;

let w1 = new walking_point1D 1;;
let w2 = new walking_point1D 2;;
w1 = w2;; (*False, son instancias distintas*)
let w3 = w2;; 
w2 = w3;; (*True, w2 y w3 "apuntan" a la misma instancia de walking_point1D *)

(*Agregación en OCaml*)
    class edge (p1,p2) =
        object
            val mutable vertex_a = p1
            val mutable vertex_b = p2
        end;;
(*o también... (hay montones de posibilidades)*)
    class edge (p1,p2) =
        object
            val mutable vertexes = (p1,p2)
        end;;


(*Herencia.

    class id_subclase p1,p2,...,pn (parámetros de la subclase)
        object
            inherit id_superclase ps1,ps2,...,psn (parámetros de la superclase)
                as alias (super, por ejemplo)

        end;;

    en OCaml la herencia puede verse como una "textual inclusion" es decir, se coge lo que hay 
    entre object y end de la superclase y se hace un copypaste en la subclase (A GROSSO MODO).
    la herencia permite modificar y/o añadir atributos y métodos.
        en caso de modificar métodos estos deben conservar el tipo original
        en los métodos la definición original sigue disponible vía el alias, pero en los atributos
        esto no es así, la definción original se pierde para siempre!!!

    En resumen, el acceso a atributos y métodos cuando usamos herencia
        es el siguiente:

                Própio objeto       Original superclase
    
    atributos   directamente        se pierde para siempre

    métodos     alias (self)        alias (super)

*)
(*Ejemplo de herencia*)
class colored_point2D (x2,y2) c =
    object
        inherit point (x2,y2) as super (*subclase de point*)
        val mutable c = c 
        method get_color = c
        method set_color nc = c <- nc
        method to_string () = (super#to_string ()) ^ " [" ^ c ^ "]"
    end;;

(*Por convención, lo mejor es no mezclar movidas a la hora de 
    declarar clases. 
Declarar por este orden: 
    - Inherit
    - Atributos
    - Métodos
Si pones un inherit después de declarar un método, puede que ese método
que has declarado no valga de nada, puesto que al poner el inherit después 
estás sustituyendo la declaración de este método por la declaración de la 
superclase.

    OCaml utiliza Delayed/Late Binding, es decir:
        la implementación concreta a emplear para un método se
        establece en tiempo de ejecución (cuando se crea el objeto).
    Nota: 'self'/'this' hay que interpretarlo como "este objeto" 
        (con la    clase que me instanció)
        No esta clase o la clase actual.

    Ejemplo:
        Clase A: metodon () = print "metodon A"
                 metoducho () = print "metoducho A"

        (*B hereda de A*)

        Clase B: metodon () = print "metodon B"
                 metoducho () = (this#)metodon ()

        (*C hereda de B*)

        Clase C: metodon () = print "metodon C"

        (*D hereda de C*)

        Clase D: metodillo = (this#)metoducho ()

        (*E hereda de C*)

        Clase E: metodon () = print "metodon E"
                 metoducho () = print "metoducho E"
                 metodillo () = print "metodillo E"
            
        Y ahora hacemos un:
        let d1 = new D;;
        d1#metodillo;;
        ¿Qué es lo que se imprime? "metodon C"
        metodilloD -> metoduchoB -> metodonC

 (*Herencia multiple

     class id_sublase pc1,...,pcn = 
         object 
             inherit id_superclase1 pcs1,...,pcs2 as alias1
             inherit id_superclase2 pcs1,...,pcs2 as alias2
             atributos...
             métodos...
         end;;

     Reglas:
        1- La última (re-)definición es la que prevalece.
        2- Herencia como "textual inclusion".
        3- Podemos añadir/modificar -> atributos/métodos.
        4- Delayed/Late binding.

    Tres posibles casos:
        1 - Superclases que comparten métodos/atributos.

                | A |  | B | ... | X |
                  ^      ^         ^
                  |      |         |
                  ------------------
                         |
                       | S |

        A y B tienen un método con la misma firma, entonces 
        se quedará con la definición que le indique el último
        inherit. El resto de las implementaciones concretas de 
        ese método para el resto de las superclases seguirán
        disponibles con sus correspondientes alias (super1, super2, etc)
        pero NO para sus atributos.

        2 - Superclases que comparten antepasados comunes.

                   | Y |
                     ^
                   __|___
                  |      |
                | A |  | B | ... | X |
                  ^      ^         ^
                  |      |         |
                  ------------------
                         |
                       | S |

            Si ni A ni B redefinen el método de Y, la definición que recibirá
            S será la de Y.
            Si por ejemplo A redefiniese el método de Y, la definición que recibirá
            S será la de A.
            Si A y B redefinen el método de Y entonces la definición que recibirá
            A será la del último inherit.

        3 - Superclases virtuales.
                - Caso 1: "Clásica":

                    | A |  | B | ... | X |
                      ^      ^         ^
                      |      |         |
                      ------------------
                             |
                           | S |

                    Siendo A y B clases virtuales. Tenemos que implementar los métodos
                    que hemos heredado de la forma que sea.

                - Caso 2: "Mixing"

                    | A |  | B | ... | X |
                      ^      ^         ^
                      |      |         |
                      ------------------
                             |
                           | S |

                    Siendo A virtual, pero B no. Si S le da implementación al 
                    método. A tiene un metodillo abstracto y un metoducho, y 
                    viceversa con B. En ese caso S no tendría que implementar ningun
                    método, dado que las implementaciones le vienen dadas por las superclases.
                    Podemos pensar que las definciones se cruzan, esta es una excepción del
                    denominado "textual inclusion".
        *) *)


        (*Clases virtuales (abstractas)
            - Métodos virtuales: declarados, pero no implementados.
                p.e: method virtual id_metodo : tipo
            - Atributos virtuales: declarados pero no inicializados.
                p.e: val [mutable] virtual id_atributo : tipo
            - Por lo menos nuestra clase virtual tiene que tener un
                atributo/método virtual.
            - Para crear instancias de esta clase tenemos que 
                implementar/darle valor a todos los métodos/atributos
                de la clase abstracta.
            - Se usa para exactamente lo mismo que las clases abstractas
               de Java. Obligamos a quien utilize nuestra clase a implementar
               ciertos métodos (con una firma determinada) y a darle valor 
               a ciertos atributos *)
            class virtual abstracta =
                object (self)
                    method virtual metodo_abstracto : int
                    val mutable virtual atributo_abstracto : int
                end;;
            (*class virtual abstracta :
                object
                 val mutable virtual atributo_abstracto : int
                 method virtual metodo_abstracto : int
                end*)
            (*# let v1 = new abstracta;;
                Error: Cannot instantiate the virtual class abstracta*)

        (*Clases parametrizadas:

            Similar a los tipos parametrizados (string list, int array, etc...).
            Métodos y atributos son polimorficos. Se utiliza a modo de contenedor.
            Tenemos que declarar de manera explicita los tipos polimorficos a emplear
            usando 'a, b', etc.
            Deberemos indicarle también al motor de inferencia mediante ":" a quienes
            corresponden esos tipos polimorficos.
            En el siguiente ejemplo seria suficiente con indicar el tipo en un solo sitio
            aparece así para ilustrar las distintas posibilidades.
            En cuanto creamos una instancia de esta clase, el tipo queda definido durante
            toda la ejecución del programa. Esto solo ocurre para una instancia concreta 
            del objeto, la clase sigue siendo polimorfica (evidentemente).
            En resumen, lo que es polimorfico, es el constructor, cuando instancias un objeto
            defines el tipo DE ESA INSTANCIA. *)
            class ['a, 'b] pair (a0: 'a) (b0: 'b) = 
                object
                    val mutable a : 'a = a0
                    val mutable b : 'b = b0

                    method fst = a
                    method snd = b
                    method get_par = (a,b)

                    method set_fst a1 = a <- a1
                    method set_snd b1 = b <- b1
                end;;

            (*Puedes forzar a que ambos atributos sean del mismo tipo: *)
            class ['a] pair (a0: 'a) (b0: 'a) = 
            object
                val mutable a = a0
                val mutable b = b0

                method fst = a
                method snd = b
                method get_par = (a,b)

                method set_fst a1 = a <- a1
                method set_snd b1 = b <- b1
            end;;

            (*Herencia con clases parametrizadas.
                1- La subclase no instancia NINGÚN tipo.
                    Por lo tanto la subclase seguirá siendo polimorfica.*)
                    class ['c, 'd] lpair (a0: 'c) (b0: 'd) = 
                        object (self)
                            inherit ['c, 'd] pair a0 b0
                            method to_list () = [self#get_par]
                        end;;

            (*  2- La subclase instancia TODOS los tipos*)
                    class allint_pair i0 j0 = 
                        object (self)
                            inherit [int, int] pair i0 j0
                        end;;
                        
            (*  3 - La subclase solo insyancia PARTE de los tipos*)
                    class ['c] fstint_pair i0 b0 = 
                        object (self)
                            inherit [int, 'c] pair i0 b0
                        end;;