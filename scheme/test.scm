#lang scheme
; This is a comment
;; So is this

; Rules:
; 1: everything is closed in parenthesis
; 2: Scheme is a prefix notation language (Polish notation)

; Defining variables
(define x 10)

; Variable Types?
; Primitive:
;     Numeric (int, double, etc)
;     Boolean (true/false) (#t and #f respectively)
;     Character (#\a, #\M, etc)
;     String ("hello")
; Compound:
;     Pair, List, Vector, etc

(define str "Hello")
(define PI 3.14159)
(define zChar #\z)
(define trueBool #t)

; Note: all variables are constant

; Print/display things
; 1: display - human readable output
; 2: print - programmer-informative output


(display str)
(newline)
(display zChar)
(newline)
(print zChar)
(newline)
(display PI)
(newline)
(display "World")
(newline)

(display "---------\n")

; Operations
(display (+ 2 3))
(newline)
(display (* 5 2))
(newline)
(display (modulo 6 5))
(newline)
(display (+ 13 (+ 4 3)))
(newline)
(display (/ 4 3))
(newline)
(display (/ 4 3.0))
(newline)
(display (/ 4 2))
(newline)
(display (/ 4 2.0))
(newline)

(display "---------\n")

; Math functions
(display (even? 2))
(newline)
(display (odd? 4))
(newline)
(display (positive? -2))
(newline)
(display (negative? -2))
(newline)
(display (zero? 0))
(newline)
(display (sqrt 9))
(newline)

(display "---------\n")

; Defining functions
(define (printDashes)
  (display "\n---------\n")
)

(define (sum a b)
  (display (+ a b))
)

(sum 2 3)
(newline)
(display (modulo (quotient 5 (+ 1 1)) 2))
(newline)

; Logical statements
; Operators: = < > <= >=
;    <> is not equals
; If statement syntax
; (if (condition) (if true) (if false))

(display (if (even? 3) "even" (+ 3 4)))
(newline)

; Multiple conditions
; (cond
;    ((condition1) do this)
;    ((condition2) do this)
;    (else do some other thing)
; )

(define (fib n)
  (cond
    ((= n 1) 1)
    ((= n 2) 1)
    (else (+ (fib (- n 1)) (fib (- n 2))))
  )
)

(display (fib 15))
(printDashes)

; Compound data types
; Pair - tuple of two values
; Note the period and the apostrophe
(display '(12 . "this is a pair"))
(newline)

; List - tuple of several values
(display '(12 "list" 3.14159 #t))
(newline)
(newline)

; Cons - Creates a pair from two elements, or appends an element
; (depending on the type of each element)
(display (cons 2 3))
(newline)
(display (cons '(2, 3) 4))
(newline)
(display (cons 2 '(3 4)))
(newline)
(display (cons '(2 3) '(4 5)))

(newline)
(newline)

; List
(display (list 1 2 3 "list" #f))
(newline)

; Append - combines two lists
; Parameters must be lists
(display (append '(1 2) '(3 4)))
(newline)
(newline)

; Car - returns the first element of a list
(display (car '(1 2 3)))
(newline)

; Cdr - Removes the first element of the list and
;       returns the rest of the list
(define nums '(1 2 3 4 5))
(display (cdr nums))
(newline)
(display nums) ; Why doesn't it modify nums?
(newline)

; Get the nth element from a list
; Yes this is the actual notation
(display (cadddr nums))
(newline)
(display (cdadr '((1 2) (3 4) (5 6))))
(printDashes)

; list? - returns true if the value is a list
(display (list? '(1 2 3)))
(newline)

; null? - returns true if the list is empty
(display (null? '()))
(newline) (newline)

; equal? - returns true if both lists have the same
; values in the same order
(display (equal? '() '()))
(newline)
(display (equal? '() '(1)))
(newline)
(display (equal? '(1 2 3) '(1 2 3)))
(newline)
(display (equal? '(1 2 3) '(3 2 1)))
(newline)

; Test
(define (getElement lst)
  (caddr lst)
)
(display (getElement '(1 2 3 4)))
(newline)