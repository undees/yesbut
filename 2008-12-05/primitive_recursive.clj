(ns primitive-recursive)

(defn- args
  "Returns an argument list of the given arity."
  [arity]
  (map (fn [n] (symbol (str \p n)))
       (range 0 arity)))

(defmacro z
  "Yields a function of the given arity
  that always returns zero."
  [arity]
  (let [xs (args arity)]
    `(fn [~@xs] 0)))

(def
  #^{:doc "Successor function; increments
  its argument by one."}
  s inc)

(defmacro p
  "Yields a function taking a number of
  arguments (superscript) and returning
  the one given by the subscript."
  [super sub]
  (let [xs (args super)]
    `(fn [~@xs] ~(nth xs (dec sub)))))

(defn o
  "Returns a function composing a function f
  and one or more functions gs."
  [f & gs]
  (fn [& xs]
    (apply f
           (map
             (fn [g] (apply g xs))
             gs))))

(defn p-r
  "Returns a function defined by primitive
  recursion on a base-case step g and a
  recursive step h."
  [g h]
  (fn f [x & ys]
    (if (zero? x)
        (apply g ys)
        (let [prev (dec x)]
          (apply h
                 (list* prev
                        (apply f (cons prev ys))
                        ys))))))
