(use-modules (shepherd service)
             (shepherd support))

(define before-apache-httpd
  (service '(before-apache-httpd)
    #:documentation "prerequisite setup for the apache httpd"
    #:start (make-system-constructor
              "install -dm 0710 -o root -g _apache /run/httpd")
    #:transient? #t))

(define apache-httpd
  (service '(apache-httpd httpd)
    #:requirement '(before-apache-httpd)
    #:documentation "Apache http server"
    #:start (make-forkexec-constructor '("httpd" "-DNO_DETACH"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list before-apache-httpd
                         apache-httpd))
