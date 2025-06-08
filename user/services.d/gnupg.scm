(use-modules (shepherd services)
             (shepherd support))

(define gnupg-helper
  (string-append services-d "helpers/gpg-agent"))

(define gnupg-dir
  (string-append %user-runtime-dir "/gnupg"))

(define gpg-agent
  (service '(gpg-agent)
    #:documentation "GNUPG authentication agent"
    #:start (make-forkexec-constuctor '(gnupg-helper "agent" "up")
              #:pid-file (string-append gnupg-dir "/pid/agent.pid"))
    #:stop (make-system-destructor
             (string-append gnupg-helper " agent down"))
    #:respawn? #f))

(define dirmngr
  (service '(dirmngr)
    #:requirement '(gpg-agent)
    #:documentation "Keyserver access for GNUPG"
    #:start (make-forkexec-constuctor '(gnupg-helper "dirmngr" "up")
              #:pid-file (string-append gnupg-dir "/pid/dirmngr.pid"))
    #:stop (make-system-destructor
             (string-append gnupg-helper " dirmngr down"))
    #:respawn? #f))

(register-services
  (list gpg-agent
        dirmngr))