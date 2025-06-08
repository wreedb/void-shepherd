(use-modules (shepherd services)
             (shepherd support))

(define dunst
  (service '(dunst notification-daemon)
    #:documentation "Notification daemon"
    #:start (make-forkexec-constuctor '("dunst"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services dunst)