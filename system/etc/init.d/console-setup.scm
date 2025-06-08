(load "/etc/init.d/lib.scm")

(define tty-font "ter-124n")
(define tty-keymap "us")
(define backlight-dir "/sys/class/backlight/intel_backlight")
(define backlight-max-file (cat backlight-dir "/max_brightness"))
(define backlight-file (cat backlight-dir "/brightness"))
(define max-brightness (read-file-value backlight-max-file))


(define tty-list
  (list "/dev/tty1"
        "/dev/tty2"
        "/dev/tty3"
        "/dev/tty4"
        "/dev/tty5"
        "/dev/tty6"))

(define (tty-setup tty)
  (system (format #f "setfont -C ~a ~a" tty tty-font))
  (system (format #f "loadkeys -C ~a -q -u ~a" tty tty-keymap))
  (msg-good (format #f "set font,keymap on ~a" tty)))

(for-each
  (lambda (tty)
    (tty-setup tty)) tty-list)

;; write maximum backlight value to current file
(write-file-value backlight-file max-brightness)
(msg-good "restored maximum backlight level")
