(use-modules (shepherd services)
             (shepherd support))

(define mpd
  (service '(mpd music-player-daemon)
    #:requirement '(audio)
    #:documentation "Music player daemon"
    #:start (make-forkexec-constuctor '("mpd" "--no-daemon"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services mpd)