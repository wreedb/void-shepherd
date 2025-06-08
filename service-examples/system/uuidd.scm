(use-modules (shepherd service)
             (shepherd support))

(define before-uuidd
  (service '(before-uuidd)
    #:documentation "prerequisite setup for UUIDD"
    #:start (make-system-constructor
            "install -d /run/uuidd -o _uuidd -g _uuidd")
    #:transient? #t))

(define uuidd
  (service '(uuidd)
    #:documentation "UUID generation daemon"
    #:start (make-forkexec-constructor '("uuidd" "-F" "-P")
            #:user "_uuidd"
            #:group "_uuidd")
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list before-uuidd
                         uuidd))
