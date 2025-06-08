; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define iwd
  (service '(iwd wireless)
    #:documentation "wireless networking service"
    #:start (make-forkexec-constructor '("/usr/libexec/iwd"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list iwd))
