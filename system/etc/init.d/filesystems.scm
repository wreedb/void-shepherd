(load "/etc/init.d/lib.scm")

(unless (mountpoint? "/boot")
  (system "mount /boot"))

(unless (mountpoint? "/tmp")
  (system "mount /tmp"))

