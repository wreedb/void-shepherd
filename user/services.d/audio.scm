(use-modules (shepherd services)
             (shepherd support))

(define pipewire
  (service '(pipewire audio-server)
    #:documentation "Audio server"
    #:start (make-forkexec-constuctor '("pipewire"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define pipewire-pulse
  (service '(pipewire-pulse pulseaudio)
    #:requirement '(pipewire)
    #:documentation "Pulseaudio compatability layer for pipewire"
    #:start (make-forkexec-constuctor '("pipewire-pulse"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define wireplumber
  (service '(wireplumber pipewire-session-manager)
    #:requirement '(pipewire pipewire-pulse)
    #:documentation "Session manager for pipewire"
    #:start (make-forkexec-constuctor '("wireplumber"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define audio
  (service '(audio)
    #:requirement '(pipewire pipewire-pulse wireplumber)
    #:documentation "Audio service group"))

(register-services audio)