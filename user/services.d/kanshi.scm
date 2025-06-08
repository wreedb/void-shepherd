(use-modules (shepherd services)
             (shepherd support))

(define kanshi
  (service '(kanshi)
    #:documentation "Wayland display management"
    #:start (make-forkexec-constuctor '("kanshi"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services kanshi)