(use-modules (shepherd service)
             (shepherd support))

;; for a more uniform approach to audio service management, see
;; 'audio.scm' where the audio services are placed all in one file
;; for proper dependency requirement

(define pipewire
  (service '(pipewire)
    #:documentation "Audio server for Linux"
    #:start (make-forkexec-constructor '("pipewire"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services pipewire)