(display "---------> Tests <---------\n")

(display "\n---------- power ----------\n")
(displayln (equal?
  (power 5 0)
  1))
(displayln (equal?
  (power 1 1)
  1))
(displayln (equal?
  (power 5 2)
  25))
(displayln (equal?
  (power 2 9)
  512))

(display "\n---------- gcd ----------\n")
(displayln (equal?
  (gcd 5 2)
  1))
(displayln (equal?
  (gcd 15 25)
  5))
(displayln (equal?
  (gcd 4 16)
  4))
(displayln (equal?
  (gcd 18 27)
  9))

(display "\n---------- fib ----------\n")
(displayln (equal?
  (fib 0)
  0))
(displayln (equal?
  (fib 1)
  1))
(displayln (equal?
  (fib 2)
  1))
(displayln (equal?
  (fib 3)
  2))
(displayln (equal?
  (fib 4)
  3))
(displayln (equal?
  (fib 5)
  5))
(displayln (equal?
  (fib 12)
  144))

(display "\n---------- reverse ----------\n")
(displayln (equal?
  (reverse null)
  '()))
(displayln (equal?
  (reverse (list 1 2))
  '(2 1)))
(displayln (equal?
  (reverse (list 1 2 3 4 5))
  '(5 4 3 2 1)))
(displayln (equal?
  (reverse (list -1 55 -33 10 15))
  '(15 10 -33 55 -1)))

(display "\n---------- remove ----------\n")
(displayln (equal?
  (remove 22 null)
  '()))
(displayln (equal?
  (remove 3 (list 1 2 3 4 5 4 3 2 1))
  '(1 2 4 5 4 2 1)))

(display "\n---------- map ----------\n")
(displayln (equal?
  (map (lambda (a) a) null)
  '()))
(displayln (equal?
  (map (lambda (a) (* a 2)) (list 1 2 3))
  '(2 4 6)))

(display "\n---------- filter ----------\n")
(displayln (equal?
  (filter (lambda (a) a) null)
  '()))
(displayln (equal?
  (filter (lambda (a) (= (modulo a 2) 0)) (list 1 2 3))
  '(2)))

(display "\n---------- zip ----------\n")
(displayln (equal?
  (zip null null)
  '()))
(displayln (equal?
  (zip (list 1 2) null)
  '()))
(displayln (equal?
  (zip null (list 1 2))
  '()))
(displayln (equal?
  (zip (list 1 2 3) (list 4 5 6))
  '((1 . 4) (2 . 5) (3 . 6))))

(display "\n---------- range ----------\n")
(displayln (equal?
  (range 1 3 1)
  '(1 2 3)))

(display "\n---------- is-palindrome ----------\n")
(displayln (equal?
  (is-palindrome null)
  #t))
(displayln (equal?
  (is-palindrome (list 1 2 3 4 5))
  #f))
(displayln (equal?
  (is-palindrome (list 2 3 5 1 6 1 5 3 2))
  #t))
