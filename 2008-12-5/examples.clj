(use 'primitive-recursive)

(def add (p-r (p 1 1) (o s (p 3 2))))

(println (format "2 + 3 = %d" (add 2 3)))

(def multiply (p-r z (o add (p 3 2) (p 3 3))))

(println (format "4 * 5 = %d" (multiply 4 5)))

(def if-then-else (p-r (p 2 2) (p 4 3)))

(println (format "if 0 then 6 else 7 = %d" (if-then-else 0 6 7)))
(println (format "if 1 then 6 else 7 = %d" (if-then-else 1 6 7)))

(def logical-or (o if-then-else (p 2 1) (p 2 1) (p 2 2)))

(println (format "0 or 0 = %d" (logical-or 0 0)))
(println (format "0 or 1 = %d" (logical-or 0 1)))
(println (format "1 or 0 = %d" (logical-or 1 0)))
(println (format "1 or 1 = %d" (logical-or 1 1)))

(def logical-and (o if-then-else (p 2 1) (p 2 2) (p 2 1)))

(println (format "0 and 0 = %d" (logical-and 0 0)))
(println (format "0 and 1 = %d" (logical-and 0 1)))
(println (format "1 and 0 = %d" (logical-and 1 0)))
(println (format "1 and 1 = %d" (logical-and 1 1)))

(defn exists [pred]
  (p-r z (o logical-or (o pred (p 2 1)) (p 2 2))))

(defn for-all [pred]
  (p-r (o s z) (o logical-and (o pred (p 2 1)) (p 2 2))))

(def negative z) ; false for all n in N, by inspection

(def logical-not (o if-then-else (p 1 1) z (o s z)))

(def non-negative (o logical-not negative))

(def even (p-r (o s z) (o logical-not (p 2 2))))

(println (format "Some x < 10 is negative? %d"
         ((exists negative) 10)))
(println (format "All x < 10 are negative? %d"
         ((for-all negative) 10)))
(println (format "Some x < 10 is non-negative? %d"
         ((exists non-negative) 10)))
(println (format "All x < 10 are non-negative? %d"
         ((for-all non-negative) 10)))
(println (format "Some x < 10 is even? %d"
         ((exists even) 10)))
(println (format "All x < 10 are even? %d"
         ((for-all even) 10)))
