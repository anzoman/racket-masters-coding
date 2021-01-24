#lang racket

; podatkovni tipi
(struct zz (n) #:transparent)       ; celo število
(struct true () #:transparent)      ; resnična logična vrednost
(struct false () #:transparent)     ; neresnična logična vrednost

; nadzor toka
(struct add (e1 e2) #:transparent)                       ; seštevanje
(struct mul (e1 e2) #:transparent)                       ; množenje
(struct leq? (e1 e2) #:transparent)                      ; primerjanje
(struct ~ (e1) #:transparent)                            ; nasprotna vrednost
(struct is-zz? (e1) #:transparent)                       ; preverjanje tipov (za celo število) 
(struct if-then-else (condition e1 e2) #:transparent)    ; vejitev

; makri
(define-syntax ifte
  (syntax-rules (then else)
    [(ifte c then e1 else e2) (if-then-else c e1 e2)]))

(define-syntax geq?
  (syntax-rules ()
    [(geq? e1 e2) (leq? e2 e1)]))

; interpreter FR (FRInterpreter 0.1) ; glavna funkcija
(define (fri e) 
  (letrec ([fr (lambda (e env) 
                (cond [(true? e) e]     ; vrnemo izraz true
                      [(false? e) e]    ; vrnemo izraz false
                      [(zz? e) e]       ; vrnemo izraz zz
                      [(add? e)         ; seštejemo izraza
                        (let ([x (fr (add-e1 e) env)]                      
                              [y (fr (add-e2 e) env)])
                          (cond [(and (true? x) (true? y)) (true)]          
                                [(and (true? x) (false? y)) (true)]
                                [(and (false? x) (true? y)) (true)]
                                [(and (false? x) (false? y)) (false)]
                                [(and (zz? x) (zz? y)) (zz (+ (zz-n x) (zz-n y)))]    
                                [#t (error "ta tip seštevanja ni podprt")]))]
                      [(mul? e)          ; zmožimo izraza
                        (let ([x (fr (mul-e1 e) env)]
                              [y (fr (mul-e2 e) env)])
                          (cond [(and (true? x) (true? y)) (true)]
                                [(and (true? x) (false? y)) (false)]
                                [(and (false? x) (true? y)) (false)]
                                [(and (false? x) (false? y)) (false)]
                                [(and (zz? x) (zz? y)) (zz (* (zz-n x) (zz-n y)))]
                                [#t (error "ta tip množenja ni podprt")]))]
                      [(leq?? e)         ; primerjamo izraza
                        (let ([x (fr (leq?-e1 e) env)]
                              [y (fr (leq?-e2 e) env)])
                          (cond [(and (true? x) (true? y)) (true)]
                                [(and (true? x) (false? y)) (false)]
                                [(and (false? x) (true? y)) (true)]
                                [(and (false? x) (false? y)) (true)]
                                [(and (zz? x) (zz? y)) (if (<= (zz-n x) (zz-n y))
                                                          (true)
                                                          (false))]
                                [#t (error "ta tip primerjanja ni podprt")]))]
                      [(~? e)            ; vrnemo nasprotno vrednost izraza
                        (let ([x (fr (~-e1 e) env)])
                          (cond [(true? x) (false)]
                                [(false? x) (true)]
                                [(zz? x) (zz (- (zz-n x)))]
                                [#t (error "ta tip nasprotne vrednosti ni podprt")]))]
                      [(is-zz?? e)
                        (let ([x (fr (is-zz?-e1 e) env)]) 
                        (if (and (zz? x) (integer? (zz-n x)))    ; preverimo če je število celo
                          (true)
                          (false)))]    
                      [(if-then-else? e)    ; izvedemo vejitev
                        (let ([c (fr (if-then-else-condition e) env)])
                          (cond [(true? c) (fr (if-then-else-e1 e) env)]
                                [(false? c) (fr (if-then-else-e2 e) env)]
                                [#t (error "ta tip vejitve ni podprt")]))]
                      [#t (error "sintaksa izraza ni pravilna")]))])
    (fr e null)))
