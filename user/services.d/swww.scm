(use-modules (shepherd service)
             (shepherd support))

(define swww
  (service '(swww wallpaper)
    #:documentation "Wallpaper daemon"
    #:start (make-forkexec-constructor '("swww-daemon"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services swww)