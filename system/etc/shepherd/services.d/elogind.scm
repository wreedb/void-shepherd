; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define elogind
  (service '(elogind logind)
    #:documentation "session/login/seat tracking and management"
    #:start (make-forkexec-constructor '("/usr/libexec/elogind/elogind"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list elogind))
