(use-modules (shepherd service)
             (shepherd support))

;; per the documentation; the location of these directories
;; is configured through the 'user-dirs.dirs' file under your
;; XDG_CONFIG_HOME variable, typically ~/.config.

(define xdg-user-dirs
  (service '(xdg-user-dirs)
    #:documentation "makes sure ~/Music, ~/Desktop, ~/Documents, etc. exist"
    #:start (make-forkexec-constructor '("xdg-user-dirs-update"))
    #:one-shot? #t))

;; this is a one-shot service, it doesn't run in the background;
;; but is useful to run at the start of a session.

(register-services xdg-user-dirs)