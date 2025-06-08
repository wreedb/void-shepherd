(load "/etc/init.d/lib.scm")

(define ifaces
  (list "lo"
        "wlan0"))

(for-each
  (lambda (iface)
    (msg-ok (format #f "bringing up interface ~a" iface))
    (quiet-sh (format #f "ip link set up dev ~a\n" iface))) ifaces)

(quiet-sh "iwconfig wlan0 power off")
(msg-good "disabled power-save on wlan0")
