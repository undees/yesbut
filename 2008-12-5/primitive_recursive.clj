(ns primitive-recursive)

(def z (constantly 0))

(def s inc)

(defn p [_ sub] (fn [& xs] (nth xs (dec sub))))

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
