(display "---------> Testi <---------\n")

(display "\n---------- podatkovni tipi ----------\n")
(displayln (equal?
  (fri (zz 5))
  (zz 5)))
(displayln (equal?
  (fri (false))
  (false)))

(display "\n---------- nadzor toka ----------\n")
(displayln (equal?
  (fri (add (zz 3) (zz 2)))
  (zz 5)))
(displayln (equal?
  (fri (add (false) (true)))
  (true)))
(displayln (equal?
  (fri (mul (zz 3) (zz 2)))
  (zz 6)))
(displayln (equal?
  (fri (mul (false) (true)))
  (false)))
(displayln (equal?
  (fri (leq? (zz 3) (zz 2)))
  (false)))
(displayln (equal?
  (fri (leq? (false) (true)))
  (true)))
(displayln (equal?
  (fri (~ (zz 3)))
  (zz -3)))
(displayln (equal?
  (fri (~ (false)))
  (true)))
(displayln (equal?
  (fri (~ (true)))
  (false)))
(displayln (equal?
  (fri (is-zz? (zz 5)))
  (true)))
(displayln (equal?
  (fri (if-then-else (true) (zz 5) (add (zz 2) (zz "a"))))
  (zz 5)))

(display "\n---------- makri ----------\n")
(displayln (equal?
  (ifte (true) then (add (zz 1) (zz 1)) else (zz 3))
  (if-then-else (true) (add (zz 1) (zz 1)) (zz 3))))
(displayln (equal?
  (geq? (add (zz 1) (zz 1)) (zz 4))
  (leq? (zz 4) (add (zz 1) (zz 1)))))
