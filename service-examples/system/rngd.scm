(use-modules (shepherd service)
             (shepherd support))

(define rngd
  (service '(rngd)
    #:documentation "check and feed random data from hardware to kernel random device"
    #:start (make-forkexec-constructor '("rngd" "-f"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list rngd))
