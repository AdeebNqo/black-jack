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
(define (repeat-game strategy n)
	(count-wins-and-loses strategy n 0 0)
)

(define (count-wins-and-loses strategy n current-n current-sum)
	(if (equal? n current-n)
		;;finished playing
		current-sum
		;;not finised playing
		;;increment currrent-sum by this game's score
		(count-wins-and-loses strategy n (+ 1 current-n) (+ current-sum (black-jack strategy)))
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   Question 4.    clever


	;;Abbreviations used;;
	;; lt - less than
	;; get - greater or equal
	;; so 'card-get' means card-greater-or-equal-to
;Smarter strategy
(define (clever customer-hand-so-far dealer-up-card)
	;;when customer16 or less
	(if (hand-lt customer-hand-so-far 17)
		;;let us check dealer for ace
		(if (equal? (car dealer-up-card) 'A)
			;;dealer has an A
			#t
			;;check if dealer's up-card is greater than 7
			(if (card-get dealer-up-card 7)
				;;taking a hit is fine
				#t
				;;taking a hit is not fine
				#f
			)
		)
		;;When the player does not have hand which
		;;is valued at 16 or below. The consideration
		;;is when the player has 11 or less
		(if (hand-lt customer-hand-so-far 12)
			;;checking if dealer's up-card is between 2 and 6
			(if (and (card-get dealer-up-card 2) (card-lt dealer-up-card 7))
				#t
				;;no hit
				#f
			)
			;;if the customer's hand is not less than 11, dont ask for a hit
			#f
		)
	)
)

;;function for determining if hand is less than a given num
(define (hand-lt hand n)
	(if (< (best-hand hand) n)
		#t
		;; when the best hand is not less than n
		#f
	)
)
;;function for determining if card is less than a given num
(define (card-lt card n)
	(if (< (card-min-val card) n)
		#t
		;;when the card is greater than n
		#f
	)
)
;;function for determining if card is greater than a num
(define (card-get card n)
	(if (>= (card-min-val card) n)
		#t
		;;when the card is less than n
		#f
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;      Question 5.                Majority
;;;
(define (majority strategy1 strategy2 strategy3)
	(lambda(customer-hand-so-far dealer-hand)
		(if (>= (count-hit (list strategy1 strategy2 strategy3) customer-hand-so-far dealer-hand 0) 2)
			#t
			;;majority do not agree on a hit
			#f
		)
	)
)
;;method for counting strategies that result in a hit
(define (count-hit strategies customer-hand-so-far dealer-hand current-count)
	(if (equal? (length strategies) 0)
		;;no more strategies
		current-count
		;;when there are still more strategies
		(if (equal? ((car strategies) customer-hand-so-far dealer-hand) #t)
			;;if current_strategy leads to hit
			(count-hit (cdr strategies) customer-hand-so-far dealer-hand (+ current-count 1))
			;;if current strategy does not lead to a hit
			(count-hit (cdr strategies) customer-hand-so-far dealer-hand current-count)
		)
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;        Question 6.              Get Stats
;;;
(define (get-stats strategy repeat-count data-points)
	(really-get-stats strategy repeat-count data-points 0 '())
)


(define (really-get-stats strategy repeat-count data-points current-data-point current-list)
	(if (equal? data-points current-data-point)
		;;finished constructing the list
		current-list
		;;constructing the list
		(really-get-stats strategy repeat-count data-points (+ current-data-point 1) (cons (repeat-game strategy repeat-count) current-list))
	)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;   Question 8.   interactive 
(define (hit? customer-hand-so-far dealer-hand)
	(display "hit (y/n):")
	(hit-me?)
)
; function to get the input returns #t if the user types y otherwise #f
(define (hit-me?)
  (eq? (read) 'y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;									;
;			Unit testing follows				;
;									;
;									;
;									;
;									;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;load the file that contains a function which returns a list of hands,
;; there are 100 hands which were randomly generated
;; the function is called 'myfile'
(load "1000-hands.txt")

;;
;;	Testing stop-at-n  for different n
;;

(define (test-stop-at n)
	(map (lambda(line) ( (stop-at n) (car line) (car (cdr line) ))) myfile)
	;;(map (lambda(some-line) ((stop-at n) (car some-line) (car (cdr (some-line))))) myfile)
)


;;the following method tests repeat game
(define (test-repeat-game number-test-repeats strategy n)
	(if (not (equal? 0 number-test-repeats))
		(begin
			(display (repeat-game strategy n))
			(newline)
			(test-repeat-game (- number-test-repeats 1) strategy n)
		)
	)
)
