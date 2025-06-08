(use-modules (shepherd service)
             (shepherd support))

(define polkitd
  (service '(polkitd polkit)
    #:requirement '(dbus)
    #:documentation "privilege escalation service"
    #:start (make-forkexec-constructor '("/usr/lib/polkit-1/polkitd"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list polkitd))
