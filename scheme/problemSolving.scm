#lang scheme

(provide length)

; define a function that returns the length of the given list
(define (length lst)
  (if (null? lst)
      0 ; true
      (+ 1 (length (cdr lst)))
  )
)

(display (length '(1 2 4)))
(newline)
(newline)

; define a function that returns the number of zeros inside the given list
(define (numZeros lst)
  (if (null? lst)
      0
      (if (= 0 (car lst))
          (+ 1 (numZeros (cdr lst)))
          (numZeros (cdr lst))
      )
  )
)

(define (numZerosCond lst)
  (cond
    ((null? lst) 0)
    ((= 0 (car lst)) (+ 1 (numZeros (cdr lst))))

    (else (numZeros (cdr lst)))
  )
)

(display (numZeros '(1 0 4 0)))
(newline)
(display (numZerosCond '(1 0 4 0)))
(newline)
(newline)

; define a function that counts the number of odd values
(define (numOdd lst)
  (cond
    ((null? lst) 0)
    ((odd? (car lst)) (+ 1 (numOdd (cdr lst))))

    (else (numOdd (cdr lst)))
  )
)

(display (numOdd '(1 2 3 4 5)))
(newline)
(newline)

; define a function that returns the max value in a list
(define (getMax lst)
  (if (= 1 (length lst))
    (car lst)
    (max (car lst) (getMax (cdr lst)))
  )
)
(display (getMax '(1 4 2 0)))
(newline)

(define (getMin lst)
  (if (= 1 (length lst))
    (car lst)
    (min (car lst) (getMin (cdr lst)))
  )
)
(display (getMin '(100 5 1 -90)))
(newline)
(newline)

; define a function that returns a new list of
; only odd values from the given list
(define (odds lst)
  (cond
    ((null? lst) '())
    ((odd? (car lst)) (cons (car lst) (odds(cdr lst))))

    (else (odds (cdr lst)))
  )
)
(display (odds '(1 2 3 4 5)))
(newline)
(newline)

; define a function that returns a list with all
; elements except for the last
(define (allButLast lst)
  (if (= 1 (length lst))
    '()
    (cons (car lst) (allButLast (cdr lst)))
  )
)
(display (allButLast '(1 2 3 4)))
