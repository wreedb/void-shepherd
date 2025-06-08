; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define rsyncd
  (service '(rsyncd rsync)
    #:documentation "remote/local file access/transfer service"
    #:start (make-forkexec-constructor
              '("rsync" "--daemon" "--no-detach"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list rsyncd))
