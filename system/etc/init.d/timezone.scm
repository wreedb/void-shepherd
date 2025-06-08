(load "/etc/init.d/lib.scm")

(define time-zone "America/Chicago")

(define tz-path
  (format #f "/usr/share/zoneinfo/~a" time-zone))


(quiet-sh
  (format #f "ln -sf ~a /etc/localtime" tz-path))
(msg-good (format #f "set timezone - ~a" time-zone))

(quiet-sh "hwclock -s")
(msg-good "synchronized hardware clock")
