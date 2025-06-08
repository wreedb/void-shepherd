(use-modules (shepherd support)
             (shepherd service)
             (ice-9 ftw)
             (ice-9 format)
             (ice-9 regex)
             (ice-9 rdelim)
             (ice-9 binary-ports))

(define cat string-append)


(for-each ; load services in services.d/*.scm
  (lambda (file)
    (load (string-append "services.d/" file)))
  (scandir (string-append (dirname (current-filename)) "/services.d")
           (lambda (file)
             (string-suffix? ".scm" file))))

(define getty@tty1
  (service '(getty@tty1)
    #:start (make-forkexec-constructor '("agetty" "--noclear" "38400" "tty1" "linux"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define getty@tty2
  (service '(getty@tty2)
    #:start (make-forkexec-constructor '("agetty" "38400" "tty2" "linux"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define getty@tty3
  (service '(getty@tty3)
    #:start (make-forkexec-constructor '("agetty" "38400" "tty3" "linux"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define getty@tty4
  (service '(getty@tty4)
    #:start (make-forkexec-constructor '("agetty" "38400" "tty4" "linux"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define getty@tty5
  (service '(getty@tty5)
    #:start (make-forkexec-constructor '("agetty" "38400" "tty5" "linux"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define getty@tty6
  (service '(getty@tty6)
    #:start (make-forkexec-constructor '("agetty" "38400" "tty6" "linux"))
    #:stop (make-kill-destructor)
    #:respawn? #t))

(define ttys
  (list getty@tty1
        getty@tty2
        getty@tty3
        getty@tty4
        getty@tty5
        getty@tty6))

(register-services ttys)

(start-service eudevd)
(start-service syslog-ng)
(start-service dbus)
(start-service elogind)
(start-service firewalld)
(start-service sshd)
(start-service rsyncd)
(start-service network-manager)

(for-each (lambda (tty)
  (start-service tty)) ttys)

(start-service polkitd)
(start-service rtkitd)