(use 'primitive-recursive)

(def add (p-r (p 1) (o s (p 2))))

(println (format "2 + 3 = %d" (add 2 3)))

(def mul (p-r z (o add (p 2) (p 3))))

(println (format "4 * 5 = %d" (mul 4 5)))

(def ite (p-r (p 2) (p 3)))

(println (format "if 0 then 6 else 7 = %d" (ite 0 6 7)))
(println (format "if 1 then 8 else 9 = %d" (ite 1 8 9)))

(def log-or (o ite (p 1) (p 1) (p 2)))

(println (format "0 or 0 = %d" (log-or 0 0)))
(println (format "0 or 1 = %d" (log-or 0 1)))
(println (format "1 or 0 = %d" (log-or 1 0)))
(println (format "1 or 1 = %d" (log-or 1 1)))

(def log-and (o ite (p 1) (p 2) (p 1)))

(println (format "0 and 0 = %d" (log-and 0 0)))
(println (format "0 and 1 = %d" (log-and 0 1)))
(println (format "1 and 0 = %d" (log-and 1 0)))
(println (format "1 and 1 = %d" (log-and 1 1)))
