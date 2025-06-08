(use-modules (shepherd service)
             (shepherd support))

(define emacs
  (service '(emacs)
    #:documentation "The editor of a lifetime"
    #:start (make-forkexec-constructor '("emacs" "--fg-daemon"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services emacs)