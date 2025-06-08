(load "/etc/init.d/lib.scm")

(define sbin "/usr/sbin")

(when (and (is-dir? sbin)
           (not (is-symlink? sbin)))
  (msg-bad "found directory /usr/sbin, moving to /usr/sbin.old for sbin-merge")
  (quiet-sh "mv /usr/sbin /usr/sbin.old"))

(quiet-sh "ln -sf bin /usr/sbin")
(msg-good "symlinked /usr/sbin to /usr/bin")
