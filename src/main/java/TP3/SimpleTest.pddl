(define (problem SimpleRobot)
		(:domain SimpleRobot)
		(:objects l1 l2 - position agent - robot)
		(:INIT  (at agent l1) (not (at agent l2)))
        (:goal (and(at agent l2) (not (at agent l1))))
)
