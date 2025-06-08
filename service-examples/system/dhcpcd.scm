(use-modules (shepherd service)
             (shepherd support))

(define dhcpcd
  (service '(dhcpcd)
    #:documentation "dhcp client daemon"
    #:start (make-forkexec-constructor '("dhcpcd" "-B"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list dhcpcd))
