#lang scheme

; Imports functions from another file
; Also runs the file
(require "utils.scm")

; equals? can be used to compare any data type
; = only works for comparing numbers (ints and floats)
(display (= 1 2))
(newline)
(display (= 1.6 1.6))
(newline)
(display (equal? "hello" "hello"))
(newline)
(display (equal? '() '(1)))
(newline)

(linebreak)

; Problem Solving

; Returns list with all the element execpt for the last one 
(define (allbutlast lst)
  (if (equal? (length lst) 1)
      '()
      (cons (car lst) (allbutlast (cdr lst)))
  )
)
(display (allbutlast '(1 2 3 4)))
(newline)

(linebreak)

; Checks if item is a member of lst
(define (ismember lst item)
  (if (null? lst)
      #f
      (if (equal? (car lst) item)
          #t
          (ismember (cdr lst) item)
      )
  )
)
(display (ismember '(1 2 3 4) 3))
(newline)
(display (ismember '(1 2 3 4) 7))
(newline)
(display (ismember '("hello") "hello"))
(newline)

(linebreak)

; Returns a list holding the min and max value
(define (minAndMax lst)
  (list (getMin lst) (getMax lst))
)
(display (minAndMax '(1 -5 2 6 -3)))
(newline)

(linebreak)

; two lists with the same length
; returns list of pair of elements in the same index in each list
(define (zip lst1 lst2)
  (if (= (length lst1) 1)
      ; It's not pretty but it works
      (cons (cons (car lst1) (car lst2)) '())
      (cons (cons (car lst1) (car lst2)) (zip (cdr lst1) (cdr lst2)))
  )
)
(display (zip '(1 2 3 4) '(#\a #\b #\c #\d)))
(newline)

(linebreak)

; return a new list with item removed
(define (remove lst item)
  (if (null? lst)
      '()
      (if (equal? (car lst) item)
          (remove (cdr lst) item)
          (cons (car lst) (remove (cdr lst) item))
      )
  )
)
(display (remove '(1 2 3 4) 3))
(newline)
(display (remove '(1 2 3 4) 1))
(newline)

(linebreak)

; Sorts the given list
(define (sort lst)
  (if (null? lst)
      '()
      (cons (getMin lst) (sort (remove lst (getMin lst))))
  )
)
(display (sort '(1 -2 4 -5 2)))
(newline)