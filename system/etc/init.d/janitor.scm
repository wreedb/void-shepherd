(load "/etc/init.d/lib.scm")

(unless (file-exists? "/var/log/wtmp")
  (quiet-sh "install -m 0644 -o root -g utmp /dev/null /var/log/wtmp"))

(unless (file-exists? "/var/log/btmp")
  (quiet-sh "install -m 0600 -o root -g utmp /dev/null /var/log/btmp"))

(unless (file-exists? "/var/log/lastlog")
  (quiet-sh "install -m 0600 -o root -g utmp /dev/null /var/log/lastlog"))

(quiet-sh "install -dm 1777 /tmp/.X11-unix /tmp/.ICE-unix")

(define need-remove
  (list "/etc/nologin"
        "/forcefsck"
        "/forcequotacheck"
        "/fastboot"))

(for-each
  (lambda (file)
    (when (file-exists? file)
      (delete-file file))) need-remove)

(quiet-sh "pkill -xf 'udevd --daemon'")
(usleep 500000)
(quiet-sh "pkill -9 -xf 'udevd --daemon' || true")
