(ns primitive-recursive)

(defn- args [arity]
  (map (fn [n] (symbol (str \p n)))
       (range 0 arity)))

(defmacro z [arity]
  (let [xs (args arity)]
    `(fn [~@xs] 0)))

(def s inc)

(defmacro p [super sub]
  (let [xs (args super)]
    `(fn [~@xs] ~(nth xs (dec sub)))))

(defn o [f & gs]
  (fn [& xs]
    (apply f
           (map
             (fn [g] (apply g xs))
             gs))))

(defn p-r [g h]
  (fn f [x & ys]
    (if (zero? x)
        (apply g ys)
        (let [prev (dec x)]
          (apply h
                 (list* prev
                        (apply f (cons prev ys))
                        ys))))))
