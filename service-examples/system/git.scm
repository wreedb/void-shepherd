(use-modules (shepherd service)
             (shepherd support))

(define git-options
  (list "git" "daemon"
        "--port" "xyz"
        "--base-path" "/path/to/git/repos"
        "--syslog"))

(define git
  (service '(git git-daemon git-server)
    #:documentation "Distributed source version/revision control system"
    #:start (make-forkexec-constructor git-options)
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list git))
