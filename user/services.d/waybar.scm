(use-modules (shepherd services)
             (shepherd support))

(define waybar
  (service '(waybar status-bar)
    #:documentation "Status bar"
    #:start (make-forkexec-constuctor '("waybar"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services waybar)