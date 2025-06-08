(use-modules (shepherd services)
             (shepherd support))

(define hyprsunset
  (service '(hyprsunset)
    #:documentation "Blue spectrum light filter"
    #:start (make-forkexec-constuctor '("hyprsunset" "-t" "5750"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services hyprsunset)