(use-modules (shepherd service)
             (shepherd support))

;; for a more uniform approach to audio service management, see
;; 'audio.scm' where the audio services are placed all in one file
;; for proper dependency requirement

(define pipewire-pulse
  (service '(pipewire-pulse)
    #:documentation "Pulseaudio compatibility layer for Pipewire"
    #:start (make-forkexec-constructor '("pipewire-pulse"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services pipewire-pulse)