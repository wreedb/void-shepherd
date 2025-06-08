(use-modules (shepherd service)
             (shepherd support))

(define acpid
  (service '(acpid)
    #:documentation "advanced configuration and power interface event daemon"
    #:start (make-forkexec-constructor '("acpid" "-f"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list acpid))
