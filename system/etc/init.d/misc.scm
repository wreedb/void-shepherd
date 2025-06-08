(load "/etc/init.d/lib.scm")

(quiet-sh "install -m 0644 -o root -g utmp /dev/null /run/utmp")
(msg-ok "seeding random number generator")
(sh "seedrng")

(define user-gid (get-gid "wbr"))
(define user-uid (get-uid "wbr"))

(unless (file-exists? "/var/cache/sccache")
  (mkdir-p "/var/cache/sccache"))

(chown "/var/cache/sccache" user-uid user-gid)
(msg-good "created sccache dir")
