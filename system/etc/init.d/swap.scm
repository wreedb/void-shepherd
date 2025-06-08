(load "/etc/init.d/lib.scm")

;; swap file
(quiet-sh "fallocate -l 8G /swap")
(chmod "/swap" #o600)
(quiet-sh "mkswap -q /swap")
(quiet-sh "swapon --discard -p 10 /swap")
(msg-good "set up swap file on /swap")

;; zram
(quiet-sh "zramctl -a lz4 -s 2G /dev/zram0")
(quiet-sh "mkswap -U clear /dev/zram0")
(quiet-sh "swapon --discard -p 100 /dev/zram0")
(msg-good "set up zram device")
