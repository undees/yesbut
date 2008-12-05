(use 'primitive-recursive)

(def add (p-r (p 1 1) (o s (p 3 2))))

(println (format "2 + 3 = %d" (add 2 3)))

(def multiply (p-r z (o add (p 3 2) (p 3 3))))

(println (format "4 * 5 = %d" (multiply 4 5)))

(def if-then-else (p-r (p 2 2) (p 4 3)))

(println (format "if 0 then 6 else 7 = %d" (if-then-else 0 6 7)))
(println (format "if 1 then 8 else 9 = %d" (if-then-else 1 8 9)))

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
