#lang racket

#|
Seminarska naloga 2 pri predmetu Funkcijsko programiranje
Naslov: FRInterpreter
Avtor: Anže Luzar
|#

; glava datoteke; da ne izgubimo funkcij `numerator` in `denominator` zaradi "naših" makrojev 
(require (rename-in racket (numerator qnumerator)
                    (denominator qdenominator)))
(provide false true zz qq .. empty s
         if-then-else
         is-zz? is-qq? is-bool? is-seq? is-proper-seq? is-empty? is-set?
         add mul leq? rounding =? right left ~ all? any?
         vars valof fun proc closure call
         gt? inv numerator denominator filtering folding mapping
         fri)

; podatkovni tipi
(struct true () #:transparent)     ; resnična logična vrednost
(struct false () #:transparent)    ; neresnična logična vrednost
(struct zz (n) #:transparent)      ; celo število
(struct qq (e1 e2) #:transparent)  ; racionalno število ; e1 predstavlja števec, e2 pa imenovalec, ki sta tuji celi števili (ali pa e1 = 0 in e2 = 1)
(struct empty () #:transparent)    ; konec zaporedja
(struct .. (e1 e2) #:transparent)  ; zaporedje, ki ga dobimo, če rezultat evalvacije izraza e1 dodamo na začetek zaporedja, ki ga dobimo kot rezultat evalvacije izraza e2
(struct s (es) #:transparent)      ; množica

; nadzor toka
(struct if-then-else (condition e1 e2) #:transparent)  ; vejitev
(struct is-zz? (e1) #:transparent)                     ; preverjanje tipov (za celo število) 
(struct is-qq? (e1) #:transparent)                     ; preverjanje tipov (za racionalniđo število) 
(struct is-bool? (e1) #:transparent)                   ; preverjanje tipov (za celo logično vrednost) 
(struct is-seq? (e1) #:transparent)                    ; preverjanje tipov (za zaporedje) 
(struct is-proper-seq? (e1) #:transparent)             ; preverjanje tipov (za pravo zaporedje) 
(struct is-empty? (e1) #:transparent)                  ; preverjanje tipov (za konec zaporedja) 
(struct is-set? (e1) #:transparent)                    ; preverjanje tipov (za množico)
(struct add (e1 e2) #:transparent)                     ; seštevanje
(struct mul (e1 e2) #:transparent)                     ; množenje
(struct leq? (e1 e2) #:transparent)                    ; primerjanje
(struct rounding (e1) #:transparent)                   ; zaokroževanje
(struct =? (e1 e2) #:transparent)                      ; ujemanje
(struct left (e1) #:transparent)                       ; ekstrakcija
(struct right (e1) #:transparent)                      ; ekstrakcija
(struct ~ (e1) #:transparent)                          ; nasprotna vrednost
(struct all? (e1) #:transparent)                       ; operator all?
(struct any? (e1) #:transparent)                       ; operator any?

; spremenljivke
(struct vars (s e1 e2) #:transparent)  ; lokalno okolje
(struct valof (s) #:transparent)       ; vrednost spremenljivke

; funkcije
(struct fun (name fargs body) #:transparent)  ; funkcija
(struct proc (name body) #:transparent)       ; procedura
(struct call (e args) #:transparent)          ; funkcijski klic
(struct closure (env f) #:transparent)        ; funkcijska ovojnica (ni veljaven del programa v jeziku FR)

; pomožne funkcije za interpreter FR
(define (gcd a b)  ; največji skupni delitelj
  (if (= 0 b)
    a
    (if (= a b)
      a
      (gcd b (modulo a b)))))

(define (reduce_qq q)  ; krajšanje ulomka
  (letrec ([x (zz-n (qq-e1 q))]                      
           [y (zz-n (qq-e2 q))]
           [g (gcd x y)])
    (cond [(= y 0) (error "qq: division by zero")]
          [(= x 0) (qq (zz 0) (zz 1))]
          [(= g 1) q]
          [#t (reduce_qq (qq (zz (quotient x g)) (zz (quotient y g))))])))

(define (get_last s)  ; pomožna funkcija za zadnji element zaporedja
  (let ([s2 (..-e2 s)])
    (if (..? s2) (get_last s2) s2)))

(define (seq->list seq)  ; pretvorba zaporedja v seznam
  (cond
    [(empty? seq) null]
    [(..? seq) (cons (..-e1 seq) (seq->list (..-e2 seq)))]
    [#t (list seq)]))

(define (list->seq xs)  ; pretvorba seznama v zaporedje z repno rekurzijo
  (letrec ([helper (lambda (xs acc) (if (null? xs) acc (helper (cdr xs) (.. acc (car xs)))))])
    (helper (cdr xs) (car xs))))

(define (list_lists->list_seqs xs)  ; pretvorba seznama seznamov (kartezični produkt) v zaporedje pri množenju množic
  (map list->seq xs))

(define (append_list->seq xs seq)  ; združevanje seznama in zaporedja
  (foldr (lambda (x acc) (.. x acc)) seq xs))

(define (zip xs1 xs2)  ; prepletanje dveh seznamov
  (map cons xs1 xs2))

(define (env_opt env_old env_new)  ; optimizacija lokalnega okolja
  (if (null? env_old) 
    env_new
    (letrec ([hd (car env_old)]
             [tl (cdr env_old)])
      (env_opt (filter (lambda (x) (not (equal? (car x) (car hd)))) tl) (append env_new (list hd))))))

(define (fargs_opt env fargs)  ; optimizacija argumentov (odstranjevanje argumentov funkcije iz okolja)
  (filter (lambda (y) (foldl (lambda (x acc) (and acc (not (equal? x (car y))))) #t fargs)) env))

; interpreter FR, klic interpreterja ima sintakso (fri expression environment)
(define (fri e env)  ; glavna funkcija za interpreter FR
  (letrec ([fr (lambda (e env)  ; rekurzivna funkcija za interpreter FR
                (cond [(true? e) e]  ; vrnemo izraz true
                      [(false? e) e]  ; vrnemo izraz false
                      [(zz? e) e]  ; vrnemo izraz zz
                      [(qq? e) (reduce_qq (qq (fr (qq-e1 e) env) (fr (qq-e2 e) env)))]  ; evalviramo števec in imenovalec ter vrnemo izraz qq (okrajšan ulomek)
                      [(empty? e) e]  ; vrnemo izraz empty
                      [(..? e) (.. (fr (..-e1 e) env) (fr (..-e2 e) env))]  ; vrnemo zapredje (izraz ..) z evalviranimi elementi
                      [(s? e) (s (list->set (set-map (s-es e) (lambda (x) (fr x env)))))]  ; vrnemo množico (izraz s) z evalviranimi elementi
                      [(if-then-else? e)  ; izvedemo vejitev
                        (let ([c (fr (if-then-else-condition e) env)])
                          (cond [(true? c) (fr (if-then-else-e1 e) env)]
                                [(false? c) (fr (if-then-else-e2 e) env)]
                                [#t (error "if-then-else: wrong argument type: " c)]))]
                      [(is-zz?? e)  ; preverimo če je izraz celo število
                        (let ([x (fr (is-zz?-e1 e) env)]) 
                          (if (and (zz? x) (integer? (zz-n x)))
                            (true)
                            (false)))]
                      [(is-qq?? e)  ; preverimo če je izraz racionalno število
                        (let ([x (fr (is-qq?-e1 e) env)]) 
                          (if (and (qq? x) (equal? (fr (is-zz? (qq-e1 x)) env) (true)) (equal? (fr (is-zz? (qq-e2 x)) env) (true)))
                            (true)
                            (false)))]
                      [(is-bool?? e)  ; preverimo če je izraz logična vrednost
                        (let ([x (fr (is-bool?-e1 e) env)]) 
                          (if (or (true? x) (false? x))
                            (true)
                            (false)))]
                      [(is-seq?? e)  ; preverimo če je izraz zaporedje
                        (let ([x (fr (is-seq?-e1 e) env)]) 
                          (if (or (..? x) (empty? x))
                            (true)
                            (false)))]
                      [(is-proper-seq?? e)  ; preverimo če je izraz pravo zaporedje (se konča z (empty))
                        (let ([x (fr (is-proper-seq?-e1 e) env)])
                          (if (or (empty? x) (and (..? x) (empty? (get_last x))))
                            (true)
                            (false)))]
                      [(is-empty?? e)  ; preverimo če je izraz prazno zaporedje oz. konec zaporedja
                        (let ([x (fr (is-empty?-e1 e) env)]) 
                          (if (empty? x)
                            (true)
                            (false)))]
                      [(is-set?? e)  ; preverimo če je izraz množica
                        (let ([x (fr (is-set?-e1 e) env)]) 
                          (if (and (s? x) (set? (s-es x)))
                            (true)
                            (false)))]
                      [(add? e) ; seštejemo izraza
                        (let ([x (fr (add-e1 e) env)]                      
                              [y (fr (add-e2 e) env)])
                          (cond [(and (equal? (fr (is-bool? x) env) (true)) (equal? (fr (is-bool? y) env) (true))) (fr (if-then-else x (true) y) null)]
                                [(and (zz? x) (zz? y)) (zz (+ (zz-n x) (zz-n y)))]
                                [(and (qq? x) (qq? y)) (let ([s1 (zz-n (qq-e1 x))]
                                                             [i1 (zz-n (qq-e2 x))]
                                                             [s2 (zz-n (qq-e1 y))]
                                                             [i2 (zz-n (qq-e2 y))])
                                                          (reduce_qq (qq (zz (+ (* s1 i2) (* s2 i1))) (zz (* i1 i2)))))]
                                [(and (qq? x) (zz? y)) (let ([s (zz-n (qq-e1 x))]
                                                             [i (zz-n (qq-e2 x))]
                                                             [z (zz-n y)])
                                                          (reduce_qq (qq (zz (+ s (* z i))) (zz i))))]
                                [(and (zz? x) (qq? y)) (let ([s (zz-n (qq-e1 y))]
                                                             [i (zz-n (qq-e2 y))]
                                                             [z (zz-n x)])
                                                          (reduce_qq (qq (zz (+ s (* z i))) (zz i))))]
                                [(and (equal? (fr (is-seq? x) env) (true)) (equal? (fr (is-seq? y) env) (true))) (append_list->seq (seq->list x) y)]
                                [(and (s? x) (s? y)) (s (set-union (s-es x) (s-es y)))]
                                [#t (error "add: wrong type argument")]))]
                      [(mul? e)  ; zmnožimo izraza
                        (let ([x (fr (mul-e1 e) env)]                      
                              [y (fr (mul-e2 e) env)])
                          (cond [(and (equal? (fr (is-bool? x) env) (true)) (equal? (fr (is-bool? y) env) (true))) (fr (if-then-else x y (false)) null)]
                                [(and (zz? x) (zz? y)) (zz (* (zz-n x) (zz-n y)))]
                                [(and (qq? x) (qq? y)) (let ([s1 (zz-n (qq-e1 x))]
                                                             [i1 (zz-n (qq-e2 x))]
                                                             [s2 (zz-n (qq-e1 y))]
                                                             [i2 (zz-n (qq-e2 y))])
                                                          (reduce_qq (qq (zz (* s1 s2)) (zz (* i1 i2)))))]
                                [(and (qq? x) (zz? y)) (let ([s (zz-n (qq-e1 x))]
                                                             [i (zz-n (qq-e2 x))]
                                                             [z (zz-n y)])
                                                          (reduce_qq (qq (zz (* s z)) (zz i))))]
                                [(and (zz? x) (qq? y)) (let ([s (zz-n (qq-e1 y))]
                                                             [i (zz-n (qq-e2 y))]
                                                             [z (zz-n x)])
                                                          (reduce_qq (qq (zz (* z s)) (zz i))))]
                                [(and (s? x) (s? y)) (s (list->set (list_lists->list_seqs (cartesian-product (set->list (s-es x)) (set->list (s-es y))))))]
                                [#t (error "add: wrong type argument")]))]
                      [(leq?? e)  ; primerjamo izraza
                        (let ([x (fr (leq?-e1 e) env)]
                              [y (fr (leq?-e2 e) env)])
                          (cond [(and (equal? (fr (is-bool? x) env) (true)) (equal? (fr (is-bool? y) env) (true))) (fr (add (~ x) y) null)]
                                [(and (zz? x) (zz? y)) (if (<= (zz-n x) (zz-n y)) (true) (false))]
                                [(and (qq? x) (qq? y)) (let ([s1 (zz-n (qq-e1 x))]
                                                             [i1 (zz-n (qq-e2 x))]
                                                             [s2 (zz-n (qq-e1 y))]
                                                             [i2 (zz-n (qq-e2 y))])
                                                          (if (<= (/ s1 i1) (/ s2 i2)) (true) (false)))]
                                [(and (qq? x) (zz? y)) (let ([s (zz-n (qq-e1 x))]
                                                             [i (zz-n (qq-e2 x))]
                                                             [z (zz-n y)])
                                                          (if (<= (/ s i) z) (true) (false)))]
                                [(and (zz? x) (qq? y)) (let ([s (zz-n (qq-e1 y))]
                                                             [i (zz-n (qq-e2 y))]
                                                             [z (zz-n x)])
                                                          (if (<= z (/ s i)) (true) (false)))]
                                [(and (equal? (fr (is-seq? x) env) (true)) (equal? (fr (is-seq? y) env) (true))) 
                                 (if (<= (length (seq->list x)) (length (seq->list y))) (true) (false))]
                                [(and (s? x) (s? y)) (if (subset? (s-es x) (s-es y)) (true) (false))]
                                [#t (error "leq?: wrong type argument")]))]
                      [(rounding? e)  ; zaookrožimo celo ali racionalno število
                        (let ([x (fr (rounding-e1 e) env)])
                          (cond [(zz? x) (zz (round (zz-n x)))]
                                [(qq? x) (zz (round (/ (zz-n (qq-e1 x)) (zz-n (qq-e2 x)))))]
                                [#t (error "rounding: wrong type argument")]))]
                      [(=?? e)  ; preverimo ujemanje izrazov
                        (let ([x (fr (=?-e1 e) env)]
                              [y (fr (=?-e2 e) env)])
                          (if (equal? x y) (true) (false)))]
                      [(left? e)  ; izvedemo levo ekstrakcijo
                        (let ([x (fr (left-e1 e) env)])
                          (cond [(qq? x) (qq-e1 x)]
                                [(..? x) (..-e1 x)]
                                [(s? x) (set-first (s-es x))]
                                [#t (error "left: wrong type argument")]))]
                      [(right? e)  ; izvedemo desno ekstrakcijo
                        (let ([x (fr (right-e1 e) env)])
                          (cond [(qq? x) (qq-e2 x)]
                                [(..? x) (..-e2 x)]
                                [(s? x) (set-rest (s-es x))]
                                [#t (error "right: wrong type argument")]))]
                      [(~? e)  ; vrnemo nasprotno vrednost izraza
                        (let ([x (fr (~-e1 e) env)])
                          (cond [(true? x) (false)]
                                [(false? x) (true)]
                                [(zz? x) (zz (- (zz-n x)))]
                                [(qq? x) (qq (fri (~ (qq-e1 x)) null) (qq-e2 x))]
                                ; [(qq? x) (qq (zz (- (zz-n (qq-e1 x)))) (qq-e2 x))]
                                [#t (error "~: wrong type argument")]))]
                      [(all?? e)  ; izvedemo operator all? (vrnemo (false), če zaporedje vsebuje kakšen (false))
                        (let ([x (fr (all?-e1 e) env)])
                          (cond [(equal? (fr (is-seq? x) env) (true)) (if (member (false) (seq->list x)) (false) (true))]
                                [(s? x) (if (set-member? (s-es x) (false)) (false) (true))]
                                [#t (error "all: wrong type argument")]))]
                      [(any?? e)  ; izvedemo operator any? (vrnemo (true), če zaporedje vsebuje vsaj kakšen element, ki ni (false))
                        (let ([x (fr (any?-e1 e) env)])
                          (cond [(equal? (fr (is-seq? x) env) (true)) (foldl (lambda (x acc) (if (equal? acc (true)) acc (if (equal? x (false)) (false) (true)))) (false) (seq->list x))]
                                [(s? x) (foldl (lambda (x acc) (if (equal? acc (true)) acc (if (equal? x (false)) (false) (true)))) (false) (set->list (s-es x)))]
                                [#t (error "any: wrong type argument")]))]
                      [(vars? e)  ; razširimo lokalno okolje
                        (let ([var_name (vars-s e)]
                              [value_1 (vars-e1 e)]
                              [value_2 (vars-e2 e)])
                          (cond [(string? var_name) (fr value_2 (cons (cons var_name (fr value_1 env)) env))]
                                [(and (list? var_name) (list? value_1)) 
                                 (fr value_2 (append (zip var_name (map (lambda (v) (fr v env)) value_1)) env))]  ; zazipamo vhodna seznama in zdužimo s prvotnim okoljem
                                [#t (error "vars: wrong type argument")]))]
                      [(valof? e)  ; vrnemo vrednost spremenljivke
                        (let ([val (assoc (valof-s e) env)])
                          (if val (cdr val) (error "valof: variable does not exist")))]
                      [(fun? e)  ; ustvarimo funkcijo (definicijo funkcije shranimo kot optimizirano ovojnico)
                        (let ([fun_name (fun-name e)]
                              [fun_fargs (fun-fargs e)])
                          (cond [(not (string? fun_name)) (error "fun: function name is not a string")]
                                [(not (list? fun_fargs)) (error "fun: function arguments are not in a list")]
                                [(check-duplicates fun_fargs) (error "fun: found duplicate function arguments")]
                                [#t (closure (fargs_opt (env_opt env null) (cons fun_name fun_fargs)) e)]))]
                                ; [#t (closure env e)]))]
                      [(proc? e) e]  ; ustvarimo proceduro
                      [(call? e)  ; izvedemo funkcijski klic
                        (let ([x (fr (call-e e) env)])
                          (cond [(proc? x) (fr (proc-body x) (cons (cons (proc-name x) x) env))]  ; klic procedure
                                [(closure? x) (let ([fun_name (fun-name (closure-f x))]  ; klic funkcijske ovojnice (razširimo okolje in izvedemo telo funkcije)
                                                    [fun_fargs (fun-fargs (closure-f x))]
                                                    [fun_body (fun-body (closure-f x))]
                                                    [env_new (closure-env x)])
                                                  (fr fun_body (env_opt (append (zip fun_fargs (map (lambda (x) (fr x env)) (call-args e))) (cons (cons fun_name x) env_new)) null)))]
                                [#t (error "call: wrong type argument")]))]
                      [#t (error "wrong expression syntax")]))])  ; če noben izraz ni prepoznan vrnemo napako za napačno sintakso izraza
    (fr e null)))

; makro sistem (Racket funkcije v jeziku FR)
(define (numerator e1) (left e1))  ; vrne števec ulomka iz rezultata izraza

(define (denominator e1) (right e1))  ; vrne imenovalec ulomka iz rezultata izraza

(define (gt? e1 e2) (~ (leq? e1 e2)))  ; preveri urejenost (ali je izraz e1 večji od izraza e2)

(define (inv e1)  ; vrne obratno vrednost števila oziroma obrne zaporedje
  (vars "e1" e1  ; z vars zagotovimo, da se izraz e1 evalvira le enkrat
    (if-then-else (is-zz? (valof "e1")) 
      (qq (zz 1) (valof "e1"))
      (if-then-else (is-qq? (valof "e1"))
        (qq (right (valof "e1")) (left (valof "e1")))
        (call (fun "reverse" (list "seq")  ; funkcija za obračanje zaporedja v jeziku FR
                (if-then-else (is-empty? (valof "seq"))
                  (empty)  ; če je zaporedja konec tu končamo, če ne obrnemo glavo in rep zaporedja in izvedemo rekurzivni klic na repu zaporedja
                  (add (call (valof "reverse") (list (right (valof "seq")))) (.. (left (valof "seq")) (empty))))) (list (valof "e1")))))))

(define (mapping f seq)  ; vrne izraz v jeziku FR, ki ima funkcionalnost funkcije List.map v SML
  (call (fun "map" (list "f" "seq")  ; funkcija map v jeziku FR
          (if-then-else (is-empty? (valof "seq"))
            (empty)  ; če je zaporedja konec tu končamo
            (.. (call (valof "f") (list (left (valof "seq"))))  ; kličemo funkcijo f na prvem elementu zaporedja in nato rekurzivno na ostalih
            (call (valof "map") (list (valof "f") (right (valof "seq"))))))) (list f seq)))  

(define (filtering f seq)  ; vrne izraz v jeziku FR, ki ima funkcionalnost funkcije List.filter v SML
  (call (fun "filter" (list "f" "seq")  ; funkcija filter v jeziku FR
          (if-then-else (is-empty? (valof "seq"))
            (empty)  ; če je zaporedja konec tu končamo
            (if-then-else (call (valof "f") (list (left (valof "seq"))))
              (.. (left (valof "seq")) (call (valof "filter") (list (valof "f") (right (valof "seq")))))  ; če f vrne (true) za prvi element ga ohranimo v zaporedju in izvedemo rekurzijo na ostalih elementih
              (call (valof "filter") (list (valof "f") (right (valof "seq"))))))) (list f seq)))  ; če f vrne (false) za prvi element ga preskočimo in izvedemo rekurzijo na preostalih elementih

(define (folding f init seq)  ; vrne izraz v jeziku FR, ki ima funkcionalnost funkcije List.foldl v SML
  (call (fun "foldl" (list "f" "init" "seq")  ; funkcija fold v jeziku FR
          (if-then-else (is-empty? (valof "seq"))
            (valof "init")  ; če je zaporedja konec tu končamo in vrnemo akumulator, ki je v spremenljivki init
            (call (valof "foldl")  ; izvedemo rekurzivni klic, kjer kličemo funkcijo f nad prvim elementom zaporedja in dobimo novo vrednost za akumulator init, nato pa fold pokličemo še nad repom zaporedja
              (list f (call (valof "f") (list (left (valof "seq")) (valof "init"))) (right (valof "seq")))))) (list f init seq)))
