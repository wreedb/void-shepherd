; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define eudevd
  (service '(eudevd udevd)
    #:documentation "device management service"
    #:start (make-forkexec-constructor '("udevd"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list eudevd))
