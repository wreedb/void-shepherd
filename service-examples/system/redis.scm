(use-modules (shepherd service)
             (shepherd support))

(define before-redis
  (service '(before-redis)
    #:documentation "prerequisite setup for redis"
    #:start (make-system-constructor
            "install -dm 0750 -o redis -g redis /run/redis")
    #:transient? #t))

(define redis
  (service '(redis)
    #:requirement '(before-redis)
    #:documentation "in-memory key-value database"
    #:start (make-forkexec-constructor '("redis-server" "/etc/redis/redis.conf")
            #:user "redis"
            #:group "redis")
    #:stop (make-kill-destructor)
    #:respawn? #t))

(register-services (list before-redis
                         redis))
