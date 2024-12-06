(define (domain Depot)
(:requirements :typing)
(:types place locatable - Object
	Depot Distributor - place
        Truck Hoist surface - locatable
        Pallet Crate - surface)

(:predicates (at ?x - locatable ?y - place) 
             (on ?x - Crate ?y - surface)
             (in ?x - Crate ?y - Truck)
             (lifting ?x - Hoist ?y - Crate)
             (available ?x - Hoist)
             (clear ?x - surface))
	
(:action Drive
:parameters (?x - Truck ?y - place ?z - place) 
:precondition (and (at ?x ?y))
:effect (and (not (at ?x ?y)) (at ?x ?z)))

(:action Lift
:parameters (?x - Hoist ?y - Crate ?z - surface ?p - place)
:precondition (and (at ?x ?p) (available ?x) (at ?y ?p) (on ?y ?z) (clear ?y))
:effect (and (not (at ?y ?p)) (lifting ?x ?y) (not (clear ?y)) (not (available ?x)) 
             (clear ?z) (not (on ?y ?z))))

(:action Drop 
:parameters (?x - Hoist ?y - Crate ?z - surface ?p - place)
:precondition (and (at ?x ?p) (at ?z ?p) (clear ?z) (lifting ?x ?y))
:effect (and (available ?x) (not (lifting ?x ?y)) (at ?y ?p) (not (clear ?z)) (clear ?y)
		(on ?y ?z)))

(:action Load
:parameters (?x - Hoist ?y - Crate ?z - Truck ?p - place)
:precondition (and (at ?x ?p) (at ?z ?p) (lifting ?x ?y))
:effect (and (not (lifting ?x ?y)) (in ?y ?z) (available ?x)))

(:action Unload 
:parameters (?x - Hoist ?y - Crate ?z - Truck ?p - place)
:precondition (and (at ?x ?p) (at ?z ?p) (available ?x) (in ?y ?z))
:effect (and (not (in ?y ?z)) (not (available ?x)) (lifting ?x ?y)))

)
