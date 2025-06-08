(use-modules (shepherd service)
             (shepherd support))

(define eww
  (service '(eww)
    #:documentation "widget system/daemon"
    #:start (make-forkexec-constructor '("eww" "daemon" "--no-daemonize"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services eww)