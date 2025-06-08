(use-modules (shepherd service)
             (shepherd support))

(define before-valkey
  (service '(before-valkey)
    #:documentation "prerequisite setup for valkey"
    #:start (make-system-constructor
              "install -dm 0750 -o _valkey -g _valkey /run/valkey")
    #:transient? #t))

(define valkey
  (service '(valkey)
    #:documentation "in-memory key-value database"
    #:start (make-forkexec-constructor '("valkey-server" "/etc/valkey/valkey.conf")
            #:user "_valkey"
            #:group "_valkey")
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list before-valkey
                         valkey))
