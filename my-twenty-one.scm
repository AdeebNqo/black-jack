;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;      CS 3 Scheme programming assignment               ;;;;
;;;;                 April 2013                            ;;;;
;;;;        joe blogg's solutions                          ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  
;; This depends on "cs3-black-jack.scm"
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Your code goes here                                    ;;;;
;;;;  Submit a file of code of everything you created below  ;;;;
;;;;  please do not submit the predefined code              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Question 1.  Code for "best-hand"

;; Dummy Version of best-hand
 (define (best-hand hand)
   (min-val hand))

;; Best Value of Hand



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Question 2.  stop-at takes an argument n that determines a
;;  strategy where a card is taken only if the best total so far is
;;  less than n. 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Question 3.   repeat-game takes a strategy and a number as
;;  arguments returns the number of games won less the number of games
;;  lost 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Question 4.    clever
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;      Question 5.                Majority
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        Question 6.              Get Stats
;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;   Question 8.   interactive 


; function to get the input returns #t if the user types y otherwise #f
(define (hit-me?)
  (eq? (read) 'y))

