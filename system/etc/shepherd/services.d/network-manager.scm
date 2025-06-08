(use-modules (shepherd service)
             (shepherd support))

(define network-manager
  (service '(network-manager)
    #:requirement '(dbus)
    #:documentation "feature rich networking management"
    #:start (make-forkexec-constructor '("NetworkManager" "-n"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list network-manager))
