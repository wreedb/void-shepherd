(load "/etc/init.d/lib.scm")

(use-modules (ice-9 ftw)
             (ice-9 rdelim)
             (ice-9 regex)
             (ice-9 popen)
             (ice-9 format)
             (ice-9 binary-ports)
             (ice-9 textual-ports))

(define modules-conf-dir "/etc/modules-load.d")

(define (load-module line)
  (let* ((trimmed-line (string-trim-both line))
         (should-process (and (> (string-length trimmed-line) 0)
                              (not (char=? (string-ref trimmed-line 0) #\#)))))
    (when should-process
      (let* ((module-parts (string-split line #\space))
             (module-name (car module-parts))
             (module-options (if (> (length module-parts) 1)
                               (string-join (cdr module-parts) " ")
                               "")))
        (msg-ok (format #f "loading module: ~a~a"
                module-name
                (if (string-null? module-options)
                    ""
                    (cat " with options: " module-options)) ))
        (let* ((command (if (string-null? module-options)
                            (cat "modprobe " module-name)
                            (cat "modprobe " module-name " " module-options)))
               (port (open-input-pipe command))
               (result (get-string-all port))
               (status (close-pipe port)))
          (when (not (= 0 (status:exit-val status)))
            (msg-bad (format #f "error loading module: ~a: ~a" module-name result))))))))

(define (process-conf-file file-path)
  (msg-ok (format #f "reading: ~a" file-path))
  (let ((port (open-input-file file-path)))
    (let loop ((line (read-line port)))
      (if (eof-object? line)
          (close-port port)
          (begin
            (load-module line)
            (loop (read-line port)))))))

(define (get-conf-files)
  (let ((files '()))
    (if (file-exists? modules-conf-dir)
      (begin
        (ftw modules-conf-dir
             (lambda (filename statinfo flag)
               (if (and (eq? flag 'regular)
                        (string-match "\\.conf$" filename))
                 (set! files (cons filename files)))
               #t))
        (sort files string<?))
      (begin
        (msg-bad (format (current-error-port) "directory ~a does not exist" modules-conf-dir))
        '()))))

(let ((conf-files (get-conf-files)))
  (if (null? conf-files)
      (msg-bad (format #f "no configuration files in ~a" modules-conf-dir))
      (begin
        (for-each process-conf-file conf-files)
        (msg-good "finished loading modules"))))
