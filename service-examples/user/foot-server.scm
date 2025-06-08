(use-modules (shepherd service)
             (shepherd support))

;; for users of the foot terminal, this will allow you to launch foot as
;; footclient under the server process, increasing speed at the cost of all
;; terminals crashing if the server dies. However, the daemon is stable
;; and generally the best way to use the foot term (IMO).
;; see foot(1) and footclient(1) for more information

(define foot-server
  (service '(foot-server)
    #:documentation "foot terminal server daemon"
    #:start (make-forkexec-constructor '("foot" "--server"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services foot-server)