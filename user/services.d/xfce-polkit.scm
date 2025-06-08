(use-modules (shepherd service)
             (shepherd support))

(define xfce-polkit
  (service '(xfce-polkit polkit-agent)
    #:documentation "Authentication frontend for PolicyKit"
    #:start (make-forkexec-constructor '("/usr/lib/xfce-polkit/xfce-polkit"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services xfce-polkit)