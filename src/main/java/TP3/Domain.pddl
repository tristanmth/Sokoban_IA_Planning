;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Simple domain
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain SimpleRobot)
  (:requirements :strips :typing :negative-preconditions)
  (:types robot position)
  
  (:predicates 
	(at ?x - robot ?y - position)
  )
	(:action move
  		:parameters (?robot - robot ?from ?to - position) 
  		:precondition (at ?robot ?from) 
  		:effect (and (at ?robot ?to) (not (at ?robot ?from)) ) 
	)  

)
