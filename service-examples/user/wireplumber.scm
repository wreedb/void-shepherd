(use-modules (shepherd service)
             (shepherd support))

;; for a more uniform approach to audio service management, see
;; 'audio.scm' where the audio services are placed all in one file
;; for proper dependency requirement

(define wireplumber
  (service '(wireplumber)
    #:documentation "Session manager for Pipewire"
    #:start (make-forkexec-constructor '("wireplumber"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services wireplumber)