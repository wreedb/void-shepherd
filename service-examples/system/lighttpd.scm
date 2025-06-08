(use-modules (shepherd service)
             (shepherd support))

(define lighttpd
  (service '(lighttpd httpd)
    #:documentation "fast, secure and flexible web server"
    #:start (make-forkexec-constructor '("lighttpd" "-D" "-f" "/etc/lighttpd/lighttpd.conf"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list lighttpd))
