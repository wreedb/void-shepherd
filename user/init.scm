(use-modules (shepherd service)
             (shepherd support)
             (ice-9 ftw))

(define user-home (getenv "HOME"))

(define xdg-config-home
  (or (getenv "XDG_CONFIG_HOME")
      (string-append user-home "/.config")))

(define services-d
  (string-append xdg-config-home "/shepherd/services.d/"))

(for-each ; load all services.d/*.scm files
  (lambda (file)
    (load (string-append services-d file)))
  (scandir (string-append (dirname (current-filename)) "/services.d")
           (lambda (file)
             (string-suffix? ".scm" file))))

(define service-list
  (list ssh-agent
        gpg-agent
        dirmngr
        audio
        mpd
        kanshi
        swww
        dunst
        waybar
        xfce-polkit
        hyprsunset
        walker))

(for-each
  (lambda (svc)
    (start-service svc))
  services-list)