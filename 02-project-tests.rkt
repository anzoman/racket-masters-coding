(display "---------> Testi <---------\n")

(display "\n---------- podatkovni tipi ----------\n")
(displayln (equal?
  (fri (true) null)
  (true)))
(displayln (equal?
  (fri (false) null)
  (false)))
(displayln (equal?
  (fri (zz 5) null)
  (zz 5)))
(displayln (equal?
  (fri (zz -3) null)
  (zz -3)))
(displayln (equal?
  (fri (qq (zz 1) (zz 2)) null)
  (qq (zz 1) (zz 2))))
(displayln (equal?
  (fri (qq (zz -1) (zz 2)) null)
  (qq (zz -1) (zz 2))))
(displayln (equal?
  (fri (qq (zz 6) (zz 20)) null)
  (qq (zz 3) (zz 10))))
(displayln (equal?
  (fri (qq (zz -4) (zz 2)) null)
  (qq (zz -2) (zz 1))))
(displayln (equal?
  (fri (empty) null)
  (empty)))
(displayln (equal?
  (fri (.. (zz 1) (zz 2)) null)
  (.. (zz 1) (zz 2))))
(displayln (equal?
  (fri (.. (zz 1) (.. (zz 2) (empty))) null)
  (.. (zz 1) (.. (zz 2) (empty)))))
(displayln (equal?
  (fri (s (set (zz 5))) null)
  (s (set (zz 5)))))
(displayln (equal?
  (fri (s (set (qq (zz -1) (zz 2)) (qq (zz -1) (zz 4)) (qq (zz -3) (zz 4)))) null)
  (s (set (qq (zz -1) (zz 2)) (qq (zz -1) (zz 4)) (qq (zz -3) (zz 4))))))

(display "\n---------- nadzor toka ----------\n")
(display "\n---------- vejitev ----------\n")
(displayln (equal?
  (fri (if-then-else (true) (zz 5) (add (zz 2) (zz "a"))) null)
  (zz 5)))
(displayln (equal?
  (fri (if-then-else (false) (zz 5) (qq (zz 1) (zz 2))) null)
  (qq (zz 1) (zz 2))))
(displayln (equal?
  (fri (if-then-else (leq? (zz 3) (zz 5)) (zz 5) (add (zz 2) (zz "a"))) null)
  (zz 5)))
(displayln (equal?
  (fri (if-then-else (=? (false) (true)) (zz 5) (add (zz 1) (zz 2))) null)
  (zz 3)))

(display "\n---------- preverjanje tipov ----------\n")
(displayln (equal?
  (fri (is-zz? (zz 5)) null)
  (true)))
(displayln (equal?
  (fri (is-zz? (qq (zz 5) (zz 2))) null)
  (false)))
(displayln (equal?
  (fri (is-zz? (zz "a")) null)
  (false)))
(displayln (equal?
  (fri (is-qq? (qq (zz 1) (zz 2))) null)
  (true)))
(displayln (equal?
  (fri (is-qq? (qq (zz -3) (zz 2))) null)
  (true)))
(displayln (equal?
  (fri (is-qq? (s (set (zz 8)))) null)
  (false)))
(displayln (equal?
  (fri (is-bool? (true)) null)
  (true)))
(displayln (equal?
  (fri (is-bool? (false)) null)
  (true)))
(displayln (equal?
  (fri (is-bool? (.. (zz 2) (qq (zz 1) (zz 2)))) null)
  (false)))
(displayln (equal?
  (fri (is-seq? (empty)) null)
  (true)))
(displayln (equal?
  (fri (is-seq? (.. (zz 2) (qq (zz 1) (zz 2)))) null)
  (true)))
(displayln (equal?
  (fri (is-seq? (.. (zz 2) (.. (zz 2) (empty)))) null)
  (true)))
(displayln (equal?
  (fri (is-seq? (false)) null)
  (false)))
(displayln (equal?
  (fri (is-seq? (zz 8)) null)
  (false)))
(displayln (equal?
  (fri (is-seq? (.. (zz "a") (.. (zz "li") (empty)))) null)
  (true)))
(displayln (equal?
  (fri (is-proper-seq? (empty)) null)
  (true)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 2) (qq (zz 1) (zz 2)))) null)
  (false)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 2) (empty))) null)
  (true)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 2) (.. (zz 2) (empty)))) null)
  (true)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 2) (.. (qq (zz 1) (zz 2)) (.. (true) (.. (s (set (zz -8) (false))) (empty)))))) null)
  (true)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 2) (.. (qq (zz 1) (zz 2)) (.. (true) (.. (s (set (zz -8) (false))) (false)))))) null)
  (false)))
(displayln (equal?
  (fri (is-proper-seq? (false)) null)
  (false)))
(displayln (equal?
  (fri (is-proper-seq? (zz 8)) null)
  (false)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty)))) null)
  (true)))
(displayln (equal?
  (fri (is-proper-seq? (.. (zz 1) (.. (zz 2) (zz 3)))) null)
  (false)))
(displayln (equal?
  (fri (is-empty? (empty)) null)
  (true)))
(displayln (equal?
  (fri (is-empty? (.. (zz 2) (qq (zz 1) (zz 2)))) null)
  (false)))
(displayln (equal?
  (fri (is-empty? (.. (zz 2) (empty))) null)
  (false)))
(displayln (equal?
  (fri (is-empty? (s (set (zz -8) (qq (zz 1) (zz 2))))) null)
  (false)))
(displayln (equal?
  (fri (is-empty? (qq (zz 2) (zz 7))) null)
  (false)))
(displayln (equal?
  (fri (is-set? (zz -42)) null)
  (false)))
(displayln (equal?
  (fri (is-set? (true)) null)
  (false)))
(displayln (equal?
  (fri (is-set? (s (set (zz 12)))) null)
  (true)))
(displayln (equal?
  (fri (is-set? (s (set (false)))) null)
  (true)))
(displayln (equal?
  (fri (is-set? (s (set (zz -8) (qq (zz 1) (zz 2))))) null)
  (true)))
(displayln (equal?
  (fri (is-set? (s (set (zz -8) (qq (zz 1) (zz 2)) (.. (zz 5) (.. (true) (empty)))))) null)
  (true)))

(display "\n---------- seštevanje ----------\n")
(displayln (equal?
  (fri (add (true) (true)) null)
  (true)))
(displayln (equal?
  (fri (add (true) (false)) null)
  (true)))
(displayln (equal?
  (fri (add (false) (true)) null)
  (true)))
(displayln (equal?
  (fri (add (false) (false)) null)
  (false)))
(displayln (equal?
  (fri (add (zz -3) (zz 2)) null)
  (zz -1)))
(displayln (equal?
  (fri (add (qq (zz 1) (zz 2)) (qq (zz 1) (zz 4))) null)
  (qq (zz 3) (zz 4))))
(displayln (equal?
  (fri (add (qq (zz -1) (zz 5)) (qq (zz -1) (zz 7))) null)
  (qq (zz -12) (zz 35))))
(displayln (equal?
  (fri (add (zz 1) (qq (zz 1) (zz 2))) null)
  (qq (zz 3) (zz 2))))
(displayln (equal?
  (fri (add (qq (zz 1) (zz 4)) (zz 2)) null)
  (qq (zz 9) (zz 4))))
(displayln (equal?
  (fri (add (.. (zz 1) (zz 2)) (.. (zz 3) (zz 4))) null)
  (.. (zz 1) (.. (zz 2) (.. (zz 3) (zz 4))))))
(displayln (equal?
  (fri (add (.. (zz 1) (.. (zz 2) (.. (zz 3) (zz 4)))) (empty)) null)
  (.. (zz 1) (.. (zz 2) (.. (zz 3) (.. (zz 4) (empty)))))))
(displayln (equal?
  (fri (add (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (.. (zz 1) (.. (zz 3) (empty)))))
(displayln (equal?
  (fri (add (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (.. (zz 1) (.. (zz 3) (empty)))))
(displayln (equal?
  (fri (add (.. (zz 1) (zz 2)) (.. (zz 3) (empty))) null)
  (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))))
(displayln (equal?
  (fri (add (.. (zz 1) (empty)) (.. (zz 3) (zz 4))) null)
  (.. (zz 1) (.. (zz 3) (zz 4)))))
(displayln (equal?
  (fri (add (empty) (.. (zz 3) (zz 4))) null)
  (.. (zz 3) (zz 4))))
(displayln (equal?
  (fri (add (empty) (empty)) null)
  (empty)))
(displayln (equal?
  (fri (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (zz 6)))) null)
  (s (set (zz 3) (zz 1) (zz 5) (zz 2) (zz 4) (zz 6)))))
(displayln (equal?
  (fri (add (s (set (zz 1) (zz 2))) (s (set (zz 2) (zz 3)))) null)
  (s (set (zz 3) (zz 1) (zz 2)))))

(display "\n---------- množenje ----------\n")
(displayln (equal?
  (fri (mul (true) (true)) null)
  (true)))
(displayln (equal?
  (fri (mul (true) (false)) null)
  (false)))
(displayln (equal?
  (fri (mul (false) (true)) null)
  (false)))
(displayln (equal?
  (fri (mul (false) (false)) null)
  (false)))
(displayln (equal?
  (fri (mul (zz 5) (zz 2)) null)
  (zz 10)))
(displayln (equal?
  (fri (mul (zz -3) (zz 2)) null)
  (zz -6)))
(displayln (equal?
  (fri (mul (qq (zz 1) (zz 2)) (qq (zz 1) (zz 4))) null)
  (qq (zz 1) (zz 8))))
(displayln (equal?
  (fri (mul (qq (zz -1) (zz 5)) (qq (zz -1) (zz 7))) null)
  (qq (zz 1) (zz 35))))
(displayln (equal?
  (fri (mul (zz 1) (qq (zz 1) (zz 2))) null)
  (qq (zz 1) (zz 2))))
(displayln (equal?
  (fri (mul (qq (zz 1) (zz 4)) (zz 2)) null)
  (qq (zz 1) (zz 2))))
(displayln (equal?
  (fri (mul (s (set (zz 1))) (s (set (zz 2)))) null)
  (s (set (.. (zz 1) (zz 2))))))
(displayln (equal?
  (fri (mul (s (set (zz 1))) (s (set (zz 2) (zz 3)))) null)
  (s (set (.. (zz 1) (zz 2)) (.. (zz 1) (zz 3))))))
(displayln (equal?
  (fri (mul (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5)))) null)
  (s (set (.. (zz 2) (zz 4)) (.. (zz 2) (zz 5)) (.. (zz 3) (zz 4)) (.. (zz 1) (zz 4)) (.. (zz 3) (zz 5)) (.. (zz 1) (zz 5))))))

(display "\n---------- primerjanje ----------\n")
(displayln (equal?
  (fri (leq? (true) (true)) null)
  (true)))
(displayln (equal?
  (fri (leq? (true) (false)) null)
  (false)))
(displayln (equal?
  (fri (leq? (false) (true)) null)
  (true)))
(displayln (equal?
  (fri (leq? (false) (false)) null)
  (true)))
(displayln (equal?
  (fri (leq? (zz 3) (zz 2)) null)
  (false)))
(displayln (equal?
  (fri (leq? (zz 1) (zz 2)) null)
  (true)))
(displayln (equal?
  (fri (leq? (zz 4) (zz 4)) null)
  (true)))
(displayln (equal?
  (fri (leq? (qq (zz 1) (zz 2)) (qq (zz 1) (zz 4))) null)
  (false)))
(displayln (equal?
  (fri (leq? (qq (zz -1) (zz 5)) (qq (zz 1) (zz 7))) null)
  (true)))
(displayln (equal?
  (fri (leq? (zz 1) (qq (zz 1) (zz 2))) null)
  (false)))
(displayln (equal?
  (fri (leq? (zz 1) (qq (zz 8) (zz 2))) null)
  (true)))
(displayln (equal?
  (fri (leq? (qq (zz 1) (zz 4)) (zz 2)) null)
  (true)))
(displayln (equal?
  (fri (leq? (qq (zz 0) (zz 2)) (zz -2)) null)
  (false)))
(displayln (equal?
  (fri (leq? (s (set (zz 1))) (s (set (zz 2)))) null)
  (false)))
(displayln (equal?
  (fri (leq? (s (set (zz 1) (zz 2))) (s (set (zz 1) (zz 2)))) null)
  (true)))
(displayln (equal?
  (fri (leq? (s (set (zz 1) (zz 2))) (s (set (zz 1) (zz 2) (zz 3)))) null)
  (true)))
(displayln (equal?
  (fri (leq? (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 1) (zz 2) (zz 4) (zz 5)))) null)
  (false)))
(displayln (equal?
  (fri (leq? (s (set (zz 1) (zz 2) (zz 3) (zz 4))) (s (set (zz 2) (zz 3)))) null)
  (false)))
(displayln (equal?
  (fri (leq? (.. (zz 1) (zz 2)) (.. (zz 3) (zz 4))) null)
  (true)))
(displayln (equal?
  (fri (leq? (.. (zz 1) (.. (zz 2) (.. (zz 3) (zz 4)))) (empty)) null)
  (false)))
(displayln (equal?
  (fri (leq? (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (true)))
(displayln (equal?
  (fri (leq? (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (true)))
(displayln (equal?
  (fri (leq? (.. (zz 1) (zz 2)) (.. (zz 3) (empty))) null)
  (false)))
(displayln (equal?
  (fri (leq? (.. (zz 1) (empty)) (.. (zz 3) (zz 4))) null)
  (true)))
(displayln (equal?
  (fri (leq? (empty) (.. (zz 3) (zz 4))) null)
  (true)))
(displayln (equal?
  (fri (leq? (empty) (empty)) null)
  (true)))
 
(display "\n---------- zaookroževanje ----------\n")
(displayln (equal?
  (fri (rounding (zz -3)) null)
  (zz -3)))
(displayln (equal?
  (fri (rounding (zz 2)) null)
  (zz 2)))
(displayln (equal?
  (fri (rounding (qq (zz 1) (zz 2))) null)
  (zz 0)))
(displayln (equal?
  (fri (rounding (qq (zz -1) (zz 2))) null)
  (zz 0)))
(displayln (equal?
  (fri (rounding (qq (zz 3) (zz 2))) null)
  (zz 2)))
(displayln (equal?
  (fri (rounding (qq (zz 5) (zz 2))) null)
  (zz 2)))
(displayln (equal?
  (fri (rounding (qq (zz 10) (zz 3))) null)
  (zz 3)))
(displayln (equal?
  (fri (rounding (qq (zz 10) (zz 4))) null)
  (zz 2)))
(displayln (equal?
  (fri (rounding (qq (zz 10) (zz 6))) null)
  (zz 2)))

(display "\n---------- ujemanje ----------\n")
(displayln (equal?
  (fri (=? (zz -2) (zz 2)) null)
  (false)))
(displayln (equal?
  (fri (=? (zz 2) (zz 2)) null)
  (true)))
(displayln (equal?
  (fri (=? (add (zz 7) (zz 3)) (zz 10)) null)
  (true)))
(displayln (equal?
  (fri (=? (add (zz 7) (zz 3)) (add (zz 7) (zz -3))) null)
  (false)))
(displayln (equal?
  (fri (=? (qq (zz 6) (zz 2)) (qq (zz 3) (zz 1))) null)
  (true)))
(displayln (equal?
  (fri (=? (qq (zz 0) (zz 2)) (qq (zz 0) (zz 5))) null)
  (true)))
(displayln (equal?
  (fri (=? (qq (zz 1) (zz 2)) (qq (zz 1) (zz 5))) null)
  (false)))
(displayln (equal?
  (fri (=? (qq (zz 6) (zz 2)) (add (qq (zz 3) (zz 2)) (qq (zz 3) (zz 2)))) null)
  (true)))
(displayln (equal?
  (fri (=? (qq (zz 3) (zz 1)) (add (qq (zz 3) (zz 2)) (qq (zz 3) (zz 2)))) null)
  (true)))
(displayln (equal?
  (fri (=? (mul (zz 7) (zz 3)) (mul (zz -3) (zz -7))) null)
  (true)))
(displayln (equal?
  (fri (=? (mul (zz 7) (zz 3)) (mul (zz -3) (zz 7))) null)
  (false)))
(displayln (equal?
  (fri (=? (qq (zz 9) (zz 4)) (mul (qq (zz 3) (zz 2)) (qq (zz 3) (zz 2)))) null)
  (true)))
(displayln (equal?
  (fri (=? (qq (zz 9) (zz 4)) (mul (qq (zz -3) (zz 2)) (qq (zz 3) (zz 2)))) null)
  (false)))
(displayln (equal?
  (fri (=? (true) (false)) null)
  (false)))
(displayln (equal?
  (fri (=? (true) (~ (false))) null)
  (true)))
(displayln (equal?
  (fri (=? (true) (add (false) (false))) null)
  (false)))
(displayln (equal?
  (fri (=? (false) (add (false) (false))) null)
  (true)))
(displayln (equal?
  (fri (=? (true) (mul (true) (true))) null)
  (true)))
(displayln (equal?
  (fri (=? (true) (mul (false) (true))) null)
  (false)))
(displayln (equal?
  (fri (=? (false) (leq? (true) (false))) null)
  (true)))
(displayln (equal?
  (fri (=? (false) (leq? (false) (false))) null)
  (false)))
(displayln (equal?
  (fri (=? (~ (zz 3)) (~ (zz -3))) null)
  (false)))
(displayln (equal?
  (fri (=? (~ (~ (zz 3))) (~ (zz -3))) null)
  (true)))
(displayln (equal?
  (fri (=? (rounding (qq (zz 5) (zz 2))) (zz 3)) null)
  (false)))
(displayln (equal?
  (fri (=? (rounding (qq (zz 5) (zz 2))) (zz 2)) null)
  (true)))
(displayln (equal?
  (fri (=? (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (false)))
(displayln (equal?
  (fri (=? (.. (zz 3) (empty)) (.. (zz 3) (empty))) null)
  (true)))
(displayln (equal?
  (fri (=? (.. (zz 1) (zz 2)) (.. (zz 3) (empty))) null)
  (false)))
(displayln (equal?
  (fri (=? (empty) (empty)) null)
  (true))) 
(displayln (equal?
  (fri (=? (add (.. (zz 1) (empty)) (.. (zz 3) (zz 4))) (.. (zz 1) (.. (zz 3) (zz 4)))) null)
  (true)))
(displayln (equal?
  (fri (=? (add (empty) (.. (zz 3) (zz 4))) (.. (zz 3) (zz 4))) null)
  (true)))
(displayln (equal?
  (fri (=? (add (empty) (empty)) (.. (zz 1) (empty))) null)
  (false)))
(displayln (equal?
  (fri (=? (leq? (.. (zz 1) (zz 2)) (.. (zz 3) (empty))) (false)) null)
  (true)))
(displayln (equal?
  (fri (=? (leq? (.. (zz 1) (zz 2)) (.. (zz 3) (empty))) (true)) null)
  (false)))
(displayln (equal?
  (fri (=? (leq? (.. (zz 1) (empty)) (.. (zz 3) (zz 4))) (true)) null)
  (true)))
(displayln (equal?
  (fri (=? (leq? (.. (zz 1) (empty)) (.. (zz 3) (zz 4))) (false)) null)
  (false)))
(displayln (equal?
  (fri (=? (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (zz 6)))) (s (set (zz 1) (zz 2) (zz 3) (zz 4) (zz 5) (zz 6)))) null)
  (true)))
(displayln (equal?
  (fri (=? (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (zz 6)))) (s (set (zz 1) (zz 2) (zz 3) (zz 4) (zz 5)))) null)
  (false)))

(display "\n---------- ekstrakcija ----------\n")
(displayln (equal?
  (fri (left (qq (zz 1) (zz 2))) null)
  (zz 1)))
(displayln (equal?
  (fri (right (qq (zz 1) (zz 2))) null)
  (zz 2)))
(displayln (equal?
  (fri (left (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (zz 1)))
(displayln (equal?
  (fri (right (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (.. (zz 2) (.. (zz 3) (empty)))))
(displayln (equal?
  (fri (left (s (set (qq (zz 1) (zz 2)) (zz 2) (zz 3)))) null)
  (zz 3)))
(displayln (equal?
  (fri (right (s (set (zz 1) (zz 2) (zz 3)))) null)
  (set (zz 1) (zz 2))))
(displayln (equal?
  (fri (left (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (zz 6))))) null)
  (zz 3)))
(displayln (equal?
  (fri (right (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (zz 6))))) null)
  (set (zz 1) (zz 5) (zz 2) (zz 4) (zz 6))))
(displayln (equal?
  (fri (left (mul (qq (zz 1) (zz 2)) (qq (zz 1) (zz 4)))) null)
  (zz 1)))
(displayln (equal?
  (fri (right (mul (qq (zz -1) (zz 5)) (qq (zz -1) (zz 7)))) null)
  (zz 35)))

(display "\n---------- nasprotna vrednost ----------\n")
(displayln (equal?
  (fri (~ (false)) null)
  (true)))
(displayln (equal?
  (fri (~ (true)) null)
  (false)))
(displayln (equal?
  (fri (~ (zz 3)) null)
  (zz -3)))
(displayln (equal?
  (fri (~ (zz -2)) null)
  (zz 2)))
(displayln (equal?
  (fri (~ (qq (zz 1) (zz 2))) null)
  (qq (zz -1) (zz 2))))
(displayln (equal?
  (fri (~ (qq (zz -1) (zz 2))) null)
  (qq (zz 1) (zz 2))))

(display "\n---------- operatorja all? in any? ----------\n")
(displayln (equal?
  (fri (all? (empty)) null)
  (true)))
(displayln (equal?
  (fri (any? (empty)) null)
  (false)))
(displayln (equal?
  (fri (all? (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (true)))
(displayln (equal?
  (fri (any? (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (true)))
(displayln (equal?
  (fri (all? (.. (zz 1) (.. (false) (.. (zz 3) (empty))))) null)
  (false)))
(displayln (equal?
  (fri (any? (.. (false) (.. (false) (.. (false) (empty))))) null)
  (false)))
(displayln (equal?
  (fri (all? (s (set (zz 1) (zz 2) (zz 3)))) null)
  (true)))
(displayln (equal?
  (fri (any? (s (set (zz 1) (zz 2) (zz 3)))) null)
  (true)))
(displayln (equal?
  (fri (all? (s (set (zz 1) (zz 2) (false)))) null)
  (false)))
(displayln (equal?
  (fri (any? (s (set (false) (false) (false)))) null)
  (false)))
(displayln (equal?
  (fri (all? (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (zz 6))))) null)
  (true)))
(displayln (equal?
  (fri (all? (add (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 5) (false))))) null)
  (false)))
(displayln (equal?
  (fri (any? (add (s (set (false) (false))) (s (set (false))))) null)
  (false)))
(displayln (equal?
  (fri (any? (add (s (set (false) (zz 3))) (s (set (false))))) null)
  (true)))

(display "\n---------- spremenljivke ----------\n")
(display "\n---------- lokalno okolje in vrednost spremenljivke ----------\n")
(displayln (equal?
  (fri (vars "a" (zz 5) (valof "a")) null)
  (zz 5)))
(displayln (equal?
  (fri (vars "abc" (zz 9) (vars "abc" (zz 10) (valof "abc"))) null)
  (zz 10)))
(displayln (equal?
  (fri (vars "D10S" (qq (zz 1) (zz 3)) (vars "D10S" (qq (zz 2) (zz 3)) (vars "D10S" (qq (zz 3) (zz 3)) (valof "D10S")))) null)
  (qq (zz 1) (zz 1))))
(displayln (equal?
  (fri (vars "A" (zz 2) (vars "B" (zz 3) (add (valof "A") (valof "B")))) null)
  (zz 5)))
(displayln (equal?
  (fri (vars "A" (true) (vars "B" (false) (mul (valof "A") (valof "B")))) null)
  (false)))
(displayln (equal?
  (fri (vars (list "a" "b" "c") (list (zz 1) (zz 2) (zz 3)) (valof "b")) null)
  (zz 2)))
(displayln (equal?
  (fri (vars (list "a" "b") (list (zz 3) (zz 7)) (add (valof "a") (valof "b"))) null)
  (zz 10)))
(displayln (equal?
  (fri (vars (list "A" "B" "C") (list (true) (false) (true)) (=? (valof "A") (valof "C"))) null)
  (true)))

(display "\n---------- funkcije in procedure ----------\n")
(displayln (equal?
  (fri (call (fun "add_10" (list "a") (add (valof "a") (zz 10))) (list (zz 5))) null)
  (zz 15)))
(displayln (equal?
  (fri (call (fun "" (list "a") (~ (valof "a"))) (list (zz 5))) null)
  (zz -5)))
(displayln (equal?
  (fri (call (fun "add_10" (list "a") (add (valof "a") (zz 10))) (list (qq (zz 1) (zz 2)))) null)
  (qq (zz 21) (zz 2))))
(displayln (equal?
  (fri (call (fun "mul_10" (list "b") (mul (valof "b") (zz 10))) (list (zz -3))) null)
  (zz -30)))
(displayln (equal?
  (fri (call (fun "add_true" (list "a") (add (valof "a") (true))) (list (false))) null)
  (true)))
(displayln (equal?
  (fri (call (fun "mul_true" (list "a") (mul (valof "a") (true))) (list (false))) null)
  (false)))
(displayln (equal?
  (fri (call (fun "add_if" (list "a") (if-then-else (leq? (valof "a") (zz 10)) (valof "a") (add (valof "a") (zz 10)))) (list (zz 5))) null)
  (zz 5)))
(displayln (equal?
  (fri (call (fun "add_if" (list "a") (if-then-else (leq? (valof "a") (zz 10)) (valof "a") (add (valof "a") (zz 10)))) (list (zz 11))) null)
  (zz 21)))
(displayln (equal?
  (fri (call (proc "42" (zz 42)) null) null)
  (zz 42)))
(displayln (equal?
  (fri (vars "a" (s (set (zz 1) (zz 2) (zz 3))) (call (proc "val_of" (valof "a")) null)) null)
  (s (set (zz 1) (zz 2) (zz 3)))))
(displayln (equal?
  (fri (vars (list "x" "y") (list (.. (true) (empty)) (.. (false) (empty))) (call (proc "val_of" (add (valof "x") (valof "y"))) null)) null)
  (.. (true) (.. (false) (empty)))))

(display "\n---------- makro sistem ----------\n")
(display "\n---------- števec in imenovalec ulomka ----------\n")
(displayln (equal?
  (fri (numerator (qq (zz 1) (zz 2))) null)
  (zz 1)))
(displayln (equal?
  (fri (denominator (qq (zz 1) (zz 2))) null)
  (zz 2)))
(display "\n---------- večji ----------\n")
(displayln (equal?
  (fri (gt? (true) (true)) null)
  (false)))
(displayln (equal?
  (fri (gt? (true) (false)) null)
  (true)))
(displayln (equal?
  (fri (gt? (false) (true)) null)
  (false)))
(displayln (equal?
  (fri (gt? (false) (false)) null)
  (false)))
(displayln (equal?
  (fri (gt? (zz 3) (zz 2)) null)
  (true)))
(displayln (equal?
  (fri (gt? (zz 1) (zz 2)) null)
  (false)))
(displayln (equal?
  (fri (gt? (zz 4) (zz 4)) null)
  (false)))
(displayln (equal?
  (fri (gt? (qq (zz 1) (zz 2)) (qq (zz 1) (zz 4))) null)
  (true)))
(displayln (equal?
  (fri (gt? (qq (zz -1) (zz 5)) (qq (zz 1) (zz 7))) null)
  (false)))
(displayln (equal?
  (fri (gt? (zz 1) (qq (zz 1) (zz 2))) null)
  (true)))
(displayln (equal?
  (fri (gt? (zz 1) (qq (zz 8) (zz 2))) null)
  (false)))
(displayln (equal?
  (fri (gt? (qq (zz 1) (zz 4)) (zz 2)) null)
  (false)))
(displayln (equal?
  (fri (gt? (qq (zz 0) (zz 2)) (zz -2)) null)
  (true)))
(displayln (equal?
  (fri (gt? (s (set (zz 1))) (s (set (zz 2)))) null)
  (true)))
(displayln (equal?
  (fri (gt? (s (set (zz 1) (zz 2))) (s (set (zz 1) (zz 2)))) null)
  (false)))
(displayln (equal?
  (fri (gt? (s (set (zz 1) (zz 2))) (s (set (zz 1) (zz 2) (zz 3)))) null)
  (false)))
(displayln (equal?
  (fri (gt? (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 1) (zz 2) (zz 4) (zz 5)))) null)
  (true)))
(displayln (equal?
  (fri (gt? (s (set (zz 1) (zz 2) (zz 3) (zz 4))) (s (set (zz 2) (zz 3)))) null)
  (true)))
(displayln (equal?
  (fri (gt? (.. (zz 1) (zz 2)) (.. (zz 3) (zz 4))) null)
  (false)))
(displayln (equal?
  (fri (gt? (.. (zz 1) (.. (zz 2) (.. (zz 3) (zz 4)))) (empty)) null)
  (true)))
(displayln (equal?
  (fri (gt? (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (false)))
(displayln (equal?
  (fri (gt? (.. (zz 1) (empty)) (.. (zz 3) (empty))) null)
  (false)))
(displayln (equal?
  (fri (gt? (.. (zz 1) (zz 2)) (.. (zz 3) (empty))) null)
  (true)))
(displayln (equal?
  (fri (gt? (.. (zz 1) (empty)) (.. (zz 3) (zz 4))) null)
  (false)))
(displayln (equal?
  (fri (gt? (empty) (.. (zz 3) (zz 4))) null)
  (false)))
(displayln (equal?
  (fri (gt? (empty) (empty)) null)
  (false)))
(display "\n---------- obrat ----------\n")
(displayln (equal?
  (fri (inv (zz 10)) null)
  (qq (zz 1) (zz 10))))
(displayln (equal?
  (fri (inv (qq (zz 1) (zz 3))) null)
  (qq (zz 3) (zz 1))))
(displayln (equal?
  (fri (inv (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (.. (zz 3) (.. (zz 2) (.. (zz 1) (empty))))))
(display "\n---------- mapping ----------\n")
(displayln (equal?
  (fri (mapping (fun "add_10" (list "a") (add (valof "a") (zz 10))) (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (.. (zz 11) (.. (zz 12) (.. (zz 13) (empty))))))
(displayln (equal?
  (fri (mapping (fun "mul_1/2" (list "a") (mul (valof "a") (qq (zz 1) (zz 2)))) (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (.. (qq (zz 1) (zz 2)) (.. (qq (zz 1) (zz 1)) (.. (qq (zz 3) (zz 2)) (empty))))))
(displayln (equal?
  (fri (mapping (fun "" (list "a") (true)) (.. (zz 1) (.. (zz 2) (.. (zz 3) (empty))))) null)
  (.. (true) (.. (true) (.. (true) (empty))))))
(display "\n---------- filtering ----------\n")
(displayln (equal?
  (fri (filtering (fun "zz?" (list "x") (is-zz? (valof "x"))) (.. (zz 1) (.. (true) (.. (zz 3) (empty))))) null)
  (.. (zz 1) (.. (zz 3) (empty)))))
(displayln (equal?
  (fri (filtering (fun ">=10" (list "x") (leq? (zz 10) (valof "x"))) (.. (zz -10) (.. (zz 10) (.. (zz 20) (.. (zz 30) (empty)))))) null)
  (.. (zz 10) (.. (zz 20) (.. (zz 30) (empty))))))
(displayln (equal?
  (fri (filtering (fun "=? (zz -1)" (list "x") (=? (valof "x") (zz -1))) (.. (zz -5) (.. (zz -1) (.. (zz 3) (empty))))) null)
  (.. (zz -1) (empty))))
(display "\n---------- folding ----------\n")
(displayln (equal?
  (fri (folding (fun "count" (list "x" "acc") (add (valof "acc") (zz 1))) (zz 0) (.. (zz 1) (.. (zz 2) (.. (zz 3) (.. (zz 4) (empty)))))) null)
  (zz 4)))
(displayln (equal?
  (fri (folding (fun "last" (list "x" "acc") (valof "x")) (zz 0) (.. (zz 1) (.. (zz 2) (.. (zz 3) (.. (zz 42) (empty)))))) null)
  (zz 42)))
(displayln (equal?
  (fri (folding (fun "sum" (list "x" "acc") (add (valof "x") (valof "acc"))) (zz 0) (.. (zz -3) (.. (zz 8) (.. (zz -1) (.. (zz 6) (empty)))))) null)
  (zz 10)))

(display "\n---------- javni testi ----------\n")
(displayln (equal?
  (add (mul (true) (true)) (false))
  (add (mul (true) (true)) (false))))
(displayln (equal?
  (fri (add (mul (true) (true)) (false)) null)
  (true)))
(displayln (equal?
  (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty))))
  (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty))))))
(displayln (equal?
  (fri (.. (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty))))
           (is-proper-seq? (.. (zz 1) (.. (zz 2) (zz 3))))) null)
  (.. (true) (false))))
(displayln (equal?
  (fri (vars (list "a" "b" "c" "d")
             (list (qq (zz 1) (zz 2)) (qq (zz -3) (zz 4))
                   (~ (qq (zz 1) (zz 2))) (qq (zz -3) (zz 4)))
             (s (set (valof "c") (valof "d") (valof "c") (add (valof "a") (valof "b"))))) null)
  (s (set (qq (zz -1) (zz 2)) (qq (zz -1) (zz 4)) (qq (zz -3) (zz 4))))))
(displayln (equal?
  (fri (vars "a" (qq (zz 12354) (zz 2534)) (vars "b" (qq (zz -3) (zz 4))
             (mul (valof "a") (valof "b")))) null)
  (qq (zz -18531) (zz 5068))))
(displayln (equal?
  (fri (vars (list "s1" "s2" "s3")
             (list (s (set (false) (true))) (s (set (zz 1) (zz 2) (zz 3))) (s (set (zz 4) (zz 4))))
             (mul (valof "s1") (mul (valof "s2") (valof "s3")))) null)
  (s 
    (set 
      (.. (true) (.. (zz 1) (zz 4))) 
      (.. (true) (.. (zz 3) (zz 4))) 
      (.. (false) (.. (zz 2) (zz 4))) 
      (.. (true) (.. (zz 2) (zz 4))) 
      (.. (false) (.. (zz 1) (zz 4))) 
      (.. (false) (.. (zz 3) (zz 4)))))))
(displayln (equal?
  (fri (call
      (fun "fib" (list "n")
           (if-then-else (leq? (valof "n") (zz 2))
                         (zz 1)
                         (add (call (valof "fib")
                                    (list (add (valof "n") (zz -1))))
                              (call (valof "fib")
                                    (list (add (valof "n") (zz -2))))))) (list (zz 10))) null)
  (zz 55)))
(displayln (equal?
  (fri (all? (.. (true)
                 (.. (leq? (false) (true))
                     (.. (=? (.. (zz -19) (zz 0))
                             (.. (left (add (qq (zz 1) (zz 5)) (zz -4)))
                                 (zz 0)))
                                (empty))))) null)
  (true)))
(displayln (equal?
  (fri (vars (list "a" "b" "c")
             (list (zz 1) (zz 2) (zz 3))
             (fun "linear" (list "x1" "x2" "x3")
                  (add (mul (valof "a") (valof "x1"))
                       (add (mul (valof "b") (valof "x2"))
                            (mul (valof "c") (valof "x3")))))) null)
  (closure
    (list (cons "a" (zz 1)) (cons "b" (zz 2)) (cons "c" (zz 3)))
    (fun
     "linear"
     '("x1" "x2" "x3")
     (add
      (mul (valof "a") (valof "x1"))
      (add (mul (valof "b") (valof "x2")) (mul (valof "c") (valof "x3"))))))))

(require rackunit)
(require rackunit/text-ui)

(define all-tests
  (test-suite
   "all"
   (test-suite
    "pulic"
    (test-case "add1" (check-equal?
                       (add (mul (true) (true)) (false))
                       (add (mul (true) (true)) (false))))
 
    (test-case "add2" (check-equal?
                       (fri (add (mul (true) (true)) (false)) null)
                       (true)))
    
    (test-case "proper-seq1" (check-equal?
                              (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty))))
                            (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty))))))
    
    (test-case "proper-seq2" (check-equal?
                              (fri (.. (is-proper-seq? (.. (zz 1) (.. (zz 2) (empty))))
                                       (is-proper-seq? (.. (zz 1) (.. (zz 2) (zz 3))))) null)
                              (.. (true) (false))))
 
    (test-case "vars-and-rat1" (check-equal?
                                    (fri (vars "a" (add (qq (zz 1) (zz 2)) (qq (zz -3) (zz 4)))
                                               (mul (valof "a") (valof "a"))) null)
                                    (qq (zz 1) (zz 16))))
    
    (test-case "vars-and-rat2" (check-equal?
                                    (fri (vars (list "a" "b")
                                             (list (mul (qq (zz 1) (zz 2)) (qq (zz -3) (zz 4)))
                                                   (~ (add (qq (zz 1) (zz 2)) (qq (zz -3) (zz 4)))))
                                             (add (valof "a") (valof "b"))) null)
                                    (qq (zz -1) (zz 8))))
    
    (test-case "fib1" (check-equal?
                       (fri (call (fun "fib" (list "n")
                                       (if-then-else (leq? (valof "n") (zz 2))
                                                     (zz 1) (add (call (valof "fib")
                                                                       (list (add (valof "n") (zz -1))))
                                                                 (call (valof "fib")
                                                                       (list (add (valof "n") (zz -2)))))))
                                  (list (zz 10))) null)
                       (zz 55)))
    
    (test-case "seq1" (check-equal?
                       (fri (all? (.. (true)
                                      (.. (leq? (false) (true))
                                          (.. (=? (.. (zz -19) (zz 0))
                                                  (.. (left (add (qq (zz 1) (zz 5)) (zz -4)))
                                                      (zz 0)))
                                              (empty)))))
                            null)
                       (true)))
    
    (test-case "seq2" (check-equal?
                       (fri (vars (list "s1" "s2" "s3")
                                  (list (s (set (false) (true)))
                                        (s (set (zz 1) (zz 2) (zz 3)))
                                        (s (set (zz 4) (zz 4))))
                                  (mul (valof "s1") (mul (valof "s2") (valof "s3")))) null)
                       (s
                        (set
                         (.. (true) (.. (zz 1) (zz 4)))
                         (.. (true) (.. (zz 3) (zz 4)))
                         (.. (false) (.. (zz 2) (zz 4)))
                         (.. (true) (.. (zz 2) (zz 4)))
                         (.. (false) (.. (zz 1) (zz 4)))
                         (.. (false) (.. (zz 3) (zz 4)))))))
    
    (test-case "variables1" (check-equal?
                           (fri (vars (list "a" "b" "c")
                                      (list (zz 1) (zz 2) (zz 3))
                                      (fun "linear" (list "x1" "x2" "x3")
                                           (add (mul (valof "a") (valof "x1"))
                                                (add (mul (valof "b") (valof "x2"))
                                                     (mul (valof "c") (valof "x3")))))) null)
                           (closure (list (cons "a" (zz 1))(cons "b" (zz 2)) (cons "c" (zz 3)))
                                    (fun "linear" '("x1" "x2" "x3")
                                         (add (mul (valof "a") (valof "x1"))
                                              (add (mul (valof "b") (valof "x2"))
                                                   (mul (valof "c") (valof "x3")))))))))
   
   (test-suite
    "misc"
    (test-case "add-seq" (check-equal?
                          (fri (add (.. (false) (empty))
                                    (.. (zz 3) (empty))) null)
                          (.. (false) (.. (zz 3) (empty)))))
  
    (test-case "add-empty" (check-equal?
                            (fri (add (empty) (empty)) null)
                            (empty))))
   
   (test-case
    "long-long"
    (check-equal?
     (fri
      (vars "a" (zz 10)
            (vars (list "f" "g")
                  (list (fun "" (list "a" "b")
                             (add (valof "a") (mul (zz 5) (valof "b"))))
                        (fun "" (list "c")
                             (add (valof "a") (valof "c"))))
                  (vars (list "a" "d" "g" "e")
                        (list (zz 1)
                              (call (valof "g") (list (zz -9)))
                              (fun "" (list "x")
                                   (add (valof "a") (mul (valof "x")
                                                         (call (valof "f")
                                                               (list (zz 1) (valof "a"))))))
                              (fun "" (list "f" "x")
                                 (call (valof "f") (list (valof "x")))))
                        (vars (list "fib" "test" "unit-fun" "proc")
                              (list (fun "fib" (list "n")
                                         (if-then-else (leq? (valof "n") (zz 2))
                                                       (zz 1)
                                                       (add (call (valof "fib")
                                                                (list (add (valof "n")
                                                                           (zz -1))))
                                                            (call (valof "fib")
                                                                  (list (add (valof "n")
                                                                             (zz -2)))))))
                                  (fun "" (list "x")
                                       (add (valof "x") (zz 2)))
                                  
                                  (fun "" null
                                       (add (inv (add (valof "a")
                                                      (valof "a")))
                                            (valof "a")))
                                  
                                  (proc ""
                                        (folding
                                         (fun "" (list "x" "acc") (mul (valof "x") (valof "acc")))
                                         (zz 1)
                                         (.. (valof "a")
                                             (.. (zz 2)
                                                 (.. (zz 3)
                                                     (.. (zz 4)
                                                         (.. (call (valof "g")
                                                                   (list (zz 5)))
                                                             (empty)))))))))
                              
                              
                            (.. (call (valof "unit-fun") null)
                                (.. (call (valof "proc") null)
                                    (add (call (valof "g")
                                               (list (add (zz 5)
                                                          (call (valof "test")
                                                                (list (zz 3))))))
                                         (add (valof "d")
                                              (add (call (valof "f")
                                                         (list (zz -1) (zz -2)))
                                                   (add (valof "a")
                                                        (add (call (valof "fib")
                                                                   (list (zz 5)))
                                                             (call (valof "e")
                                                                   (list (valof "test") (zz 3))))))))))))))
      null)
     (.. (qq (zz 3) (zz 2)) (.. (zz 6360) (zz 521)))))))

(run-tests all-tests)
