(use-modules (shepherd service)
             (shepherd support))

(define mako
  (service '(mako)
    #:documentation "notification daemon for wayland"
    #:start (make-forkexec-constructor '("mako"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services mako)