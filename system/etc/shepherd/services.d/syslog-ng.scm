; -*- scheme -*- vim:ft=scheme
(use-modules (shepherd support))

(define syslog-ng
  (service '(syslog-ng syslog syslogd)
    #:documentation "system logging daemon"
    #:start (make-forkexec-constructor '("syslog-ng" "-F"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list syslog-ng))
