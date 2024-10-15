;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Sokoban domain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain sokoban)
  (:requirements :strips :typing :negative-preconditions)
  (:types guard position)
  
  (:predicates 
	(isWall ?y - position)
	(isBox ?y - position)
	(at ?x - guard ?y - position)
        (gauche ?x - position ?y - position)
        (droite ?x - position ?y - position)
		(haut ?x - position ?y - position)
		(bas ?x - position ?y - position)
  )
	(:action ML
  		:parameters (?x - guard ?from ?to - position) 
  		:precondition (and (at ?x ?from) (not (isBox ?to)) (gauche ?to ?from) ) 
  		:effect (and (at ?x ?to) (not (at ?x ?from)) ) 
	)  

	(:action MR
		:parameters (?x - guard ?from ?to - position)
		:precondition (and (at ?x ?from) (not (isBox ?to)) (droite ?to ?from) )
		:effect (and (at ?x ?to) (not (at ?x ?from)) )
	)
	(:action MU
		:parameters (?x - guard ?from ?to - position)
		:precondition (and (at ?x ?from) (not (isBox ?to)) (haut ?to ?from) )
		:effect (and (at ?x ?to) (not (at ?x ?from)) )
	)

	(:action MD
		:parameters (?x - guard ?from ?to - position)
		:precondition (and (at ?x ?from) (not (isBox ?to)) (bas ?to ?from) )
		:effect (and (at ?x ?to) (not (at ?x ?from)) )
	)
	
	(:action PU
		:parameters (?x - guard ?from - position ?to - position ?toBox - position)
		:precondition (and 
			(at ?x ?from )
			(not (isBox ?toBox ) )
			(haut ?toBox ?to)
			(haut ?to ?from)
			(isBox ?to)  (not (isWall ?toBox ) ) )
		:effect (and (at ?x ?to ) (not (at ?x ?from ) ) (isBox ?toBox ) (not (isBox ?to ) ) )
	)

	(:action PD
		:parameters (?x - guard ?from - position ?to - position ?toBox - position)
		:precondition (and 
			(at ?x ?from )
			(not (isBox ?toBox ) )
			(bas ?toBox ?to)
			(bas ?to ?from)
			(isBox ?to)  (not (isWall ?toBox ) ) )
		:effect (and (at ?x ?to ) (not (at ?x ?from ) ) (isBox ?toBox ) (not (isBox ?to ) ) )
	)
	
	(:action PL
		:parameters (?x - guard ?from - position ?to - position ?toBox - position)
		:precondition (and 
			(at ?x ?from )
			(not (isBox ?toBox ) )
			(gauche ?toBox ?to)
			(gauche ?to ?from)
			(isBox ?to)  (not (isWall ?toBox ) ) )
		:effect (and (at ?x ?to ) (not (at ?x ?from ) ) (isBox ?toBox ) (not (isBox ?to ) ) )
	)

	(:action PR
		:parameters (?x - guard ?from - position ?to - position ?toBox - position)
		:precondition (and 
			(at ?x ?from )
			(not (isBox ?toBox ) )
			(droite ?toBox ?to)
			(droite ?to ?from)
			(isBox ?to) (not (isWall ?toBox ) ) )
		:effect (and (at ?x ?to ) (not (at ?x ?from ) ) (isBox ?toBox ) (not (isBox ?to ) ) )
	)
)
