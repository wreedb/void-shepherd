; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define firewalld
  (service '(firewalld firewall)
    #:documentation "main system firewall"
    #:start (make-forkexec-constructor
              '("firewalld" "--nofork" "--nopid"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list firewalld))
