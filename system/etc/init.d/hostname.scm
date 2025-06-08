(load "/etc/init.d/lib.scm")

;; write the contents of /etc/hostname to
;; /proc/sys/kernel/hostname if it exists
(if (file-exists? "/etc/hostname")
  (begin  
    (write-file-value
    "/proc/sys/kernel/hostname"
    (read-file-value "/etc/hostname")))
  (begin
    (write-file-value
    "/proc/sys/kernel/hostname"
    "linux")))
