(use-modules (shepherd service)
             (shepherd support))

(define rtkitd
  (service '(rtkitd rtkit)
    #:requirement '(dbus)
    #:documentation "realtime policy scheduling"
    #:start (make-forkexec-constructor '("/usr/libexec/rtkit-daemon"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list rtkitd))
