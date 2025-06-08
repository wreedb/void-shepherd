(use-modules (shepherd services)
             (shepherd support))

(define ssh-agent-helper
  (string-append services-d "helpers/ssh-agent"))

(define ssh-dir
  (string-append %user-runtime-dir "/ssh"))

(define ssh-agent
  (service '(ssh-agent)
    #:documentation "ssh authentication agent"
    #:start (make-forkexec-constuctor '(ssh-agent-helper "up")
              #:pid-file (string-append ssh-dir "/pid"))
    #:stop (make-system-destructor
             (string-append ssh-agent-helper " down"))
    #:respawn? #f))

(register-services ssh-agent)