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

;; official Version of best-hand
(define (best-hand hand)
	(if (ace? hand)
		;;there is an ace
		(if (> (+ 10 (min-val hand)) 21)
			;;case where an ace leads to a bust
			(min-val hand)
			;;the cards are below 21
			(+ 10 (min-val hand))	
		)
		;;there is no ace
		(min-val hand)
	)

)
;;method for determining if there is an ace in a hand
(define (ace? hand)
        (if (equal? (length hand) 0)
		;;no ace found
		#f
		;;if there remaining cards
		(if (equal? (car(car hand)) 'A)
			;;ace has been found
			#t
			;;no ace found but there more cards
			(ace? (cdr hand))
		)
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Question 2.  stop-at takes an argument n that determines a
;;  strategy where a card is taken only if the best total so far is
;;  less than n.
(define (stop-at n)
	(lambda(customer-hand-so-far dealer-hand)
		(if (< (best-hand customer-hand-so-far) n)
			;;if best-hand is less than n
			#t
			;;if best hand is not less than n
			#f
		)
	)
)

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

