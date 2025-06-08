(use-modules (shepherd service)
             (shepherd support))

(define wireless-driver "nl80211")
(define wireless-iface "wlan0")
(define wpa-config "/etc/wpa_supplicant/wpa_supplicant.conf")

(define wpa-supplicant
  (service '(wpa-supplicant)
    #:documentation "wireless networking support"
    #:start (make-forkexec-constructor '(
            "wpa_supplicant" "-s"
            "-D" wireless-driver
            "-i" wireless-iface
            "-c" wpa-config))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list wpa-supplicant))
