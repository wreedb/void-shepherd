(use-modules (shepherd service)
             (shepherd support))

;; this file consolidates pipewire(-pulse) and wireplumber and provides the 
;; 'audio' service as target for all three to be started from the 'audio' name

(define pipewire
  (service '(pipewire)
    #:documentation "Audio server for Linux"
    #:start (make-forkexec-constructor '("pipewire"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define pipewire-pulse
  (service '(pipewire-pulse)
    #:documentation "Pulseaudio compatibility layer for Pipewire"
    #:requirement '(pipewire)
    #:start (make-forkexec-constructor '("pipewire-pulse"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define wireplumber
  (service '(wireplumber)
    #:documentation "Session manager for Pipewire"
    #:requirement '(pipewire pipewire-pulse)
    #:start (make-forkexec-constructor '("wireplumber"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

;; Here we can think of 'audio' as a systemd target, grouping together
;; services to accomplish a specific task, it will not need a #:start or
;; #:stop statement since it is not a true service.
(define audio
  (service '(audio)
    #:documentation "Audio services group"
    #:requirement '(pipewire pipewire-pulse wireplumber)
    #:transient? #t))
;; #:transient? #t will allow the 'audio' service to be ignored by shepherd
;; after its finished starting the requirements. This can be changed to
;; #:one-shot? #t to keep the audio target around if desired.

(register-services
  (list pipewire
        pipewire-pulse
        wireplumber
        audio))