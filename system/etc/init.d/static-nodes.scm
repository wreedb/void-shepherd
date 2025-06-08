(load "/etc/init.d/lib.scm")

(define nodes
  (command->list "kmod static-nodes -f devname 2>/dev/null | cut -d' ' -f1"))

(for-each
  (lambda (node)
    (msg-ok (format #f "static node: ~a" node))
    (system (format #f "modprobe -bq ~a 2>/dev/null" node))) nodes)
