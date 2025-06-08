(use-modules (shepherd service)
             (shepherd support))

(define dnsmasq
  (service '(dnsmasq)
    #:documentation "dhcp and caching dns server"
    #:start (make-forkexec-constructor '("dnsmasq" "-d"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list dnsmasq))
