(use-modules (shepherd service)
             (shepherd support))

;; #:stop (make-system-destructor "...")
;; can be useful for services that have their own
;; command that stop the service, since this often
;; means they do additional cleanup tasks if needed

(define tmux
  (service '(tmux)
    #:documentation "terminal multiplexer"
    #:start (make-forkexec-constructor '("tmux" "start-server"))
    #:stop (make-system-destructor "tmux kill-server")
    #:respawn? #t))

;; this example however requires a tmux.conf file that starts
;; a session or to not quit when there are no sessions, as per
;; the default behavior of tmux

(register-services tmux)