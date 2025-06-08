; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define seatd
  (service '(seatd)
    #:documentation "seat tracking and management"
    #:start (make-forkexec-constructor '("seatd" "-g" "_seatd"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list seatd))
