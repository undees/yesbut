(use 'primitive-recursive)
(use 'clojure.spec)

(def add (p-r (p 1 1) (o s (p 3 2))))

(defspec add
  ([2 3] (= value 5)))

(def multiply (p-r (z 1) (o add (p 3 2) (p 3 3))))

(defspec multiply
  ([4 5] (= value 20)))

(def if-then-else (p-r (p 2 2) (p 4 3)))

(defspec if-then-else
  ([0 6 7] (= value 7))
  ([1 6 7] (= value 6)))

(def logical-or (o if-then-else (p 2 1) (p 2 1) (p 2 2)))

(defspec logical-or
  ([0 0] (= value 0))
  ([0 1] (= value 1))
  ([1 0] (= value 1))
  ([1 1] (= value 1)))

(def logical-and (o if-then-else (p 2 1) (p 2 2) (p 2 1)))

(defspec logical-and
  ([0 0] (= value 0))
  ([0 1] (= value 0))
  ([1 0] (= value 0))
  ([1 1] (= value 1)))

(defn exists [pred]
  (p-r (z 0) (o logical-or (o pred (p 2 1)) (p 2 2))))

(defn for-all [pred]
  (p-r (o s (z 0)) (o logical-and (o pred (p 2 1)) (p 2 2))))

;; Predicates to throw at exists and for-all
(def negative (z 1)) ; false for all n in N, by inspection
(def logical-not (o if-then-else (p 1 1) (z 1) (o s (z 1))))
(def non-negative (o logical-not negative))
(def even (p-r (o s (z 0)) (o logical-not (p 2 2))))

(defspec exists
  ([negative]     (= (value 10) 0))
  ([non-negative] (= (value 10) 1))
  ([even]         (= (value 10) 1)))

(defspec for-all
  ([negative]     (= (value 10) 0))
  ([non-negative] (= (value 10) 1))
  ([even]         (= (value 10) 0)))
