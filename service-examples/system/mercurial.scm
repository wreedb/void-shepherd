(use-modules (shepherd service)
             (shepherd support))

;; the following is an example, you may not need the same options
;; many options and values are used for demonstration purposes

(define daemon-options
  (list "hg"
        "serve"
        "--port" "xyz" ; 80, 443, etc.
        "--web-conf" "/your/web/conf/file"
        "--certificate" "/your/cert/file"
        "--name" "my-mercurial-server"
        "--prefix" "/path/to/mercurial/repos"))

(define mercurial
  (service '(mercurial hg)
    #:documentation "Distributed source version/revision control system"
    #:start (make-forkexec-constructor daemon-options) 
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list mercurial))
