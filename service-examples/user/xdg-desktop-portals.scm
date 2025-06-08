(use-modules (shepherd service)
             (shepherd support))

;; if you're like me, you might prefer to use a different portal than the one
;; that your compositor would run by default, or to explicitly run a portal
;; from a lack of trust that your compositor will actually run it consistently
;; on their own

(define xdg-desktop-portal
  (service '(xdg-desktop-portal)
    #:documentation "integration portal for sandboxed apps"
    ;; on arch linux, this path may be in /usr/lib rather than /usr/libexec
    #:start (make-forkexec-constructor '("/usr/libexec/xdg-desktop-portal"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services xdg-desktop-portal)