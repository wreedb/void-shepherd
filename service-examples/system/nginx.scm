(use-modules (shepherd service)
             (shepherd support))

(define nginx
  (service '(nginx httpd)
    #:documentation "http and reverse proxy server, mail proxy server"
    #:start (make-forkexec-constructor '("nginx" "-g" "'daemon off;'"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list nginx))
