(use-modules (shepherd services)
             (shepherd support))

(define thunar
  (service '(thunar file-manager)
    #:documentation "File manager service"
    #:start (make-forkexec-constuctor '("thunar" "--daemon"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define tumbler
  (service '(tumbler thumbnailer)
    #:documentation "Thumbnail generator for Thunar"
    #:start (make-forkexec-constuctor '("/usr/lib/tumbler-1/tumblerd"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services
  (list thunar
        tumbler))