; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define sshd
  (service '(sshd openssh)
    #:documentation "remote shell access server"
    ;; sshd needs to be ran by specifying it's full path;
    ;; I assume for security reasons
    #:start (make-forkexec-constructor '("/usr/bin/sshd" "-D"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list sshd))