(use-modules (ice-9 format)
             (ice-9 regex)
             (ice-9 rdelim)
             (ice-9 popen)
             (ice-9 binary-ports)
             (ice-9 ftw)
             ((shepherd support) #:select (mkdir-p)))

(load "/etc/init.d/lib.scm")

(pseudo-mount "nosuid,noexec,nodev" "proc" "proc" "/proc")
(pseudo-mount "nosuid,noexec,nodev" "sysfs" "sysfs" "/sys")
(pseudo-mount "mode=0755,nosuid,nodev" "tmpfs" "run" "/run")
(pseudo-mount "mode=0755,nosuid" "devtmpfs" "dev" "/dev")

(define extra-dirs
  (list "/run/shepherd"
        "/run/lvm"
        "/run/user"
        "/run/lock"
        "/run/log"
        "/dev/pts"
        "/dev/shm"
        "/run/dbus"
        "/run/systemd/seats"
        "/run/systemd/sessions"
        "/run/systemd/users"
        "/run/systemd/machines"))

(for-each (lambda (dir)
  (msg-ok (format #f "creating directory ~a" dir))
  (mkdir-p dir #o0755)) extra-dirs)

(chown "/run/dbus" (get-uid "dbus") (get-gid "dbus"))

(pseudo-mount "mode=0620,gid=5,nosuid,noexec -n" "devpts" "devpts" "/dev/pts")
(pseudo-mount "mode=1777,nosuid,nodev -n" "tmpfs" "shm" "/dev/shm")
(pseudo-mount "defaults -n" "securityfs" "securityfs" "/sys/kernel/security")

(unless (file-exists? "/var/run")
  (msg-ok "linking /run -> /var/run")
  (symlink "/run" "/var/run"))

(pseudo-mount "nosuid,noexec,nodev" "efivarfs" "efivarfs" "/sys/firmware/efi/efivars")
(pseudo-mount "nsdelegate" "cgroup2" "cgroup2" "/sys/fs/cgroup")
