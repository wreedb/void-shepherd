(use-modules (shepherd service)
             (shepherd support))

;; this could alternatively be added to the 'audio.scm' file
;; and edited to require wireplumber. However it is separated here due to
;; it being a graphical application, meaning it might not be launchable from
;; a TTY like the other audio services can be.

(define easyeffects
  (service '(easyeffects equalizer)
    #:documentation "Equalizer for pipewire/wireplumber"
    #:start (make-forkexec-constructor '("easyeffects" "--gapplication-service"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services easyeffects)