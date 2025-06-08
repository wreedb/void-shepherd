; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define dbus
  (service '(dbus dbus-daemon)
    #:documentation "system-level ipc framework"
    #:start (make-forkexec-constructor
              '("dbus-daemon" "--system" "--nofork" "--nopidfile"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list dbus))
