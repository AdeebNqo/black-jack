;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;      CS 3 Scheme programming assignment               ;;;;
;;;;                 April 2013                            ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Set up the cards                                      ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Random (taken from simply.scm)
;; If your version of Scheme has RANDOM, you should take this out.
;; (It gives the same sequence of random numbers every time.) 

(define random
  (let ((*seed* 1) )
    (lambda (x)
      (let* ((hi (quotient *seed* 127773))
	     (low (modulo *seed* 127773))
	     (test (- (* 16807 low) (* 2836 hi))))
	(if (> test 0)
	    (set! *seed* test)
	    (set! *seed* (+ test 2147483647))))
      (modulo *seed* x))))

;; pack of playing cards is divided into four suits: 
;; spades, hearts, diamonds, and clubs
;; the rank of a card is the value within a suit
(define (suit s)  ;; Create a single suit 's' in order of rank
  (map (lambda (r) (cons r (list s))) '(A 2 3 4 5 6 7 8 9 10 J Q K)))
(define (pack)    ;; Put all four suits into a pack of cards
  (append (suit 's) (suit 'h) (suit 'd) (suit 'c)))

;; Now create a shuffled pack
(define (shuffled-pack)
  (define (shuffle card-set how-many)
    (define (move-card in out which)
      (if (= which 0)
	  (cons (car in) (shuffle (append (cdr in) out) (- how-many
							   1)))
	  (move-card (cdr in) (cons (car in) out) (- which 1))))
    (if (= how-many 0)
	card-set
	(move-card card-set '() (random how-many))))
  (shuffle (pack) (length (pack))))

;; Minimum value of a card (an Ace can also have the value of 11)
(define (card-min-val card)
  (cond ((equal? (car card) 'A) 1)
	((equal? (car card) 'J) 10)
	((equal? (car card) 'Q) 10)
	((equal? (car card) 'K) 10)
	(else (car card))))

;; Add up all the minimum values of a hand (expects a list of cards)
;; > (min-val '((8 c) (A h) (A c) (8 h) (Q c)))
;; 18
;;
(define (min-val hand)
  (if (null? hand) 0
      (+ (card-min-val (car hand)) (min-val (cdr hand)))))


;; Play one round.
;; Returns the players hand cons-ed with the remainder of the deck
;;
;; > (play stop-at-17 '((8 c) (A h)) '((5 h)) '((Q d) (6 h) (3 h) (6 c) ))
(define (play strategy my-hand dealer-up-card deck)
  (if (> (best-hand my-hand) 21) (cons my-hand deck)      ;  Bust
      (if (strategy my-hand dealer-up-card)               ;  hit?
	  (play strategy (cons (car deck) my-hand) dealer-up-card (cdr deck))
	  (cons my-hand deck)                             ; stay
	  )
      )
  )

;; This is what the dealer plays after customer has finished
;; The dealer always stops at 17.

;; > (play-dealer '((5 h)) '((Q d) (6 h) (3 h) (6 c) ))
;; ((6 h) (Q d) (5 h))

;; > (play-dealer '((8 c)) '((Q d) (J h) (3 h) (6 c) ))
;; ((Q d) (8 c))

(define (play-dealer dealer-hand-so-far rest-of-deck)
  (if (< (best-hand dealer-hand-so-far) 17)         ;; Dealer hit?
      (play-dealer (cons (car rest-of-deck) dealer-hand-so-far)
		   (cdr rest-of-deck))
      dealer-hand-so-far))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  The Game                                                ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (black-jack strategy)
  (let ((the-deck (shuffled-pack)))
    (let ((player-hand (list (car the-deck) (cadr the-deck)))
	  (dealer-up-card (caddr the-deck))
	  (rest-of-deck (cdddr the-deck)))

      ;; (newline) (newline)                                   ;;;<comment out>
      ;; (display "player-hand: ") (display player-hand)       ;;;<comment out>
      ;; (newline)                                             ;;;<comment out>
      ;; (display "dealer-up-card: ") (display dealer-up-card) ;;;<comment out>
      ;; (newline)                                             ;;;<comment out>

      (let ((outcome (play 
		      strategy 
		      player-hand 
		      dealer-up-card 
		      rest-of-deck)))
	;; (display "Player outcome: ") (display (car outcome)) ;;;<comment out>
	;; (newline)                                            ;;;<comment out>
	(if (> (best-hand (car outcome)) 21)
	    -1                                 ; Player bust
	    (let ((dealer-hand (play-dealer 
				(list dealer-up-card) 
				(cdr outcome))))
	      ;; (display "dealer-hand: ")                      ;;;<comment out>
	      ;; (display dealer-hand)                          ;;;<comment out>
	      ;; (newline) (newline)                            ;;;<comment out>
	      (cond ((> (best-hand dealer-hand) 21) 1)
					; Dealer Bust, player wins
		    ((< (best-hand (car outcome)) 
			(best-hand dealer-hand)) -1) 
					; Dealer wins
		    ((> (best-hand (car outcome)) 
			(best-hand dealer-hand)) 1) 
					; Player wins
		    (else 0))      ; Draw
	      )
	    )
	)
      )
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                   example strategies                      ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (black-jack stupid)
(define (stupid my-hand up-card)
  (> (min-val (list up-card)) 5))

;; (black-jack stop-at-17)
(define (stop-at-17 customer-hand-so-far dealer-up-card)
	(< (best-hand customer-hand-so-far) 17))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;  Your code goes here                                    ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Best Value of Hand
;; > (best-hand '((8 c) (A h) (A c) (8 h) ))
;; 18
;; > (best-hand '((8 c) (A h) (A c)  ))
;; 20
(define (best-hand hand)
  (min-val hand))
