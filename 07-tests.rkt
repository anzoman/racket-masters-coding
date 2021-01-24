(display "---------> Tests <---------\n")

(display "\n---------- ones ----------\n")
(displayln (equal?
  (car ones)
  1))
(displayln (equal?
  (car ((cdr ones)))
  1))
(displayln (equal?
  (car ((cdr ((cdr ones)))))
  1))

(display "\n---------- naturals ----------\n")
(displayln (equal?
  (car naturals)
  1))
(displayln (equal?
  (car ((cdr naturals)))
  2))
(displayln (equal?
  (car ((cdr ((cdr naturals)))))
  3))

(display "\n---------- fibs ----------\n")
(displayln (equal?
  (car fibs)
  1))
(displayln (equal?
  (car ((cdr fibs)))
  1))
(displayln (equal?
  (car ((cdr ((cdr fibs)))))
  2))
(displayln (equal?
  (car ((cdr ((cdr ((cdr fibs)))))))
  3))

(display "\n---------- first ----------\n")
(displayln (equal?
  (first 5 fibs)
  '(1 1 2 3 5)))
(displayln (equal?
  (first 4 naturals)
  '(1 2 3 4)))
(displayln (equal?
  (first 2 ones)
  '(1 1)))

(display "\n---------- squares ----------\n")
(displayln (equal?
  (first 5 (squares fibs))
  '(1 1 4 9 25)))

(display "\n---------- sml ----------\n")
(displayln (equal?
  (sml nil)
  '()))
(displayln (equal?
  (sml null (sml nil))
  #t))
(displayln (equal?
  (sml hd (sml 5 :: null))
  5))
(displayln (equal?
  (sml tl (sml 5 :: (sml 4 :: (sml nil))))
  '(4)))

(display "\n---------- my-delay, my-force ----------\n")
(define f (my-delay (lambda () (begin (write "bla") 123))))
(displayln (equal?
  (my-force f)
  123))
(displayln (equal?
  (my-force f)
  123))

(display "\n---------- partitions ----------\n")
(displayln (equal?
  (partitions 3 7)
  4))
