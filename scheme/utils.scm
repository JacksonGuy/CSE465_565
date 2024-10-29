#lang scheme

(provide length)
(provide linebreak)
(provide getMin)
(provide getMax)

(define (length lst)
  (if (null? lst)
      0 ; true
      (+ 1 (length (cdr lst)))
  )
)

(define (linebreak)
  (newline)
  (display "---------")
  (newline)
  (newline)
)

(define (getMin lst)
  (if (= 1 (length lst))
    (car lst)
    (min (car lst) (getMin (cdr lst)))
  )
)

(define (getMax lst)
  (if (= 1 (length lst))
    (car lst)
    (max (car lst) (getMax (cdr lst)))
  )
)
