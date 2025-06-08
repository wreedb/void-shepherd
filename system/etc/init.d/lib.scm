(use-modules (ice-9 format)
             (ice-9 regex)
             (ice-9 rdelim)
             (ice-9 popen)
             (ice-9 binary-ports)
             (ice-9 ftw)
             (ice-9 optargs)
             ((shepherd support) #:select (mkdir-p)))

(define cat string-append)

(define (sh command)
  (let* ((in (open-input-pipe command))
         (out (read-string in)))
    (close-pipe in) out))

(define (quiet-sh command)
  (system (format #f "~a >/dev/null 2>&1" command)))

(define (msg-bad message)
  (display (format #f "[\x1B[1;31mshepherd\x1B[0m] *>>> ~a\n" message)))

(define (msg-ok message)
  (display (format #f "[\x1B[1;34mshepherd\x1B[0m] *>>> ~a\n" message)))

(define (msg-good message)
  (display (format #f "[\x1B[1;32mshepherd\x1B[0m] *>>> ~a\n" message)))

(define (get-uid name)
  (passwd:uid (getpwnam name)))

(define (get-gid name)
  (passwd:uid (getpwnam name)))

(define (mountpoint? path)
  (let ((cmd (cat "mountpoint -q " path)))
    (zero? (system cmd))))

(define (pseudo-mount options type fs path)
  "mount pseudo-filesystem FS of TYPE at PATH with OPTIONS"
  (when (not (mountpoint? path))
    (msg-ok (format #f "mounting ~a as ~a" path type))
    (system (format #f "mount -o ~a -t ~a ~a ~a" options type fs path))))

(define (command->list command)
  (let* ((in (open-input-pipe command))
         (lines '())
         (line (read-line in)))
    (while (not (eof-object? line))
      (set! lines (cons line lines))
      (set! line (read-line in)))
    (close-pipe in)
    (reverse lines)))

(define (read-file-value path)
  (if (file-exists? path)
      (let ((handle (open-input-file path)))
        (let ((value (string-trim-both (read-line handle))))
          (close-port handle)
          value))
      (begin
        (format (current-error-port) "error: file '~a' not found\n" path) #f)))

(define (write-file-value path value)
  (if (file-exists? path)
    (let ((handle (catch 'system-error
                  (lambda () (open-output-file path))
                  (lambda args
                    (format (current-error-port) "error: can't open ~a for writing, invalid permissions\n" path) #f))))
      (if handle
        (begin
          (display value handle)
          (close-port handle)
          #t)
        #f))
    (begin
      (format (current-error-port) "error: file '~a' not found\n" path) #f)))

(define (is-dir? path)
  (if (and (file-exists? path)
           (eq? (stat:type (stat path)) 'directory))
    (begin #t)
    (begin #f)))

(define (is-file? path)
  (if (and (file-exists? path)
           (eq? (stat:type (stat path)) 'regular))
    (begin #t)
    (begin #f)))

(define (is-symlink? path)
  (if (and (file-exists? path)
           (eq? (stat:type (lstat path)) 'symlink))
    (begin #t)
    (begin #f)))
