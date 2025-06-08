(use-modules (shepherd services)
             (shepherd support))

(define walker
  (service '(walker launcher)
    #:documentation "Application launcher service"
    #:start (make-forkexec-constuctor '("walker" "--gapplication-service"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services walker)