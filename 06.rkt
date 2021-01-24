#lang racket

(define (power x n) 
  (if (= 0 n)
    1
    (* x (power x (- n 1)))))

(define (gcd a b) 
  (if (= 0 b)
    a
    (if (= a b)
      a
      (gcd b (modulo a b)))))

(define (fib n) 
  (if (= n 0)
    0
    (if (= n 1)
      1
      (+ (fib (- n 1)) (fib (- n 2))))))

(define (reverse xs) 
  (if (null? xs)
    null
    (append (reverse (cdr xs)) (list (car xs)))))

(define (remove x xs) 
  (if (null? xs)
    null
    (if (= (car xs) x)
      (remove x (cdr xs))
      (cons (car xs) (remove x (cdr xs))))))

(define (map f xs) 
  (if (null? xs)
    null
    (cons (f (car xs)) (map f (cdr xs)))))

(define (filter f xs) 
  (if (null? xs)
    null
    (if (f (car xs))
      (cons (car xs) (filter f (cdr xs)))
      (filter f (cdr xs)))))

(define (zip xs1 xs2)
  (if (null? xs1)
    null
    (if (null? xs2)
      null
      (cons (cons (car xs1) (car xs2)) (zip (cdr xs1) (cdr xs2))))))

(define (range start stop step)
  (if (<= start stop)
    (cons start (range (+ start step) stop step))
    null))

(define (is-palindrome xs) (equal? xs (reverse xs)))
