; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define turnstiled
  (service '(turnstiled turnstile)
    #:documentation "login, session and runtime dir management"
    #:start (make-forkexec-constructor '("turnstiled"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list turnstiled))
