#lang racket

(define ones 
  (cons 1 (lambda () ones)))

(define naturals 
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (f 1)))

(define fibs
  (letrec ([f (lambda (x y) (cons x (lambda () (f y (+ x y)))))])
    (f 1 1)))

(define (first n s)
  (letrec ([f (lambda (n s acc)
              (if (= n 0)
                acc
                (f (- n 1) ((cdr s)) (append acc (list (car s))))))])
  (f n s null)))

(define (squares s) 
  (cons (expt (car s) 2) (lambda () (squares ((cdr s))))))

(define-syntax sml
  (syntax-rules (:: hd tl null nil)
    [(sml x :: xs) (cons x xs)]
    [(sml hd xs) (car xs)]
    [(sml tl xs) (cdr xs)]
    [(sml null xs) (null? xs)]
    [(sml nil) null]))

(define (my-delay t)
  (mcons 1 (mcons t "")))

(define (my-force p)
  (cond [(= (mcar p) 1) (begin (set-mcar! p 5)
                               (set-mcdr! p (mcons (mcar (mcdr p)) ((mcar (mcdr p)))))
                               (mcdr (mcdr p)))]
        [#t (begin (set-mcar! p (- (mcar p) 1))
                   (mcdr (mcdr p)))]))

(define (partitions k n) 4)
