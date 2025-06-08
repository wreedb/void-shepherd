GNU Shepherd on Void Linux
==========================
I replaced `Runit` with [GNU Shepherd](https://www.gnu.org/software/shepherd) on my Void Linux installation.
Why? For fun I suppose.

## The purpose of this repository
I had little to no guidance when attempting to replace Runit with Shepherd.  
With that being said; since I managed to accomplish that goal regardless,  
I thought I should document how I did it, along with materials to help anyone  
else who might be interested in changing their init system.

## Warnings
If you aren't familiar with what the process of changing your init system might  
entail, it's obviously a task in which you can easily *break* your system.  
Please exercise caution; don't try to replace your init on a system which holds  
alot of documents that are important to you without backing them up.

## Repository Map
```
system/
└── etc/
    ├── init.d/ -- early boot script, run before Shepherd   
    └── shepherd/
        ├── config.scm -- the main Shepherd system config file
        └── services.d/ -- individual service definitions

init -- the system init executable: it runs the early boot scripts
        and then hands off execution to Shepherd.

user/
├── init.scm -- main Sheperd user config file
└── services.d/ -- individual service definitions
    └── helpers/ -- shell scripts to help manage services that
                    dont behave nicely (i.e. ssh-agent, gpg-agent)

service-examples
├── system/ -- example system-level service definitions
└── user/ -- example user-level service definitions
```

I've been using it to manage my user and system services, I'm able to run  
Hyprland at the same level of competence as I can with SystemD on my desktop.
![Screenshot of active service listing](/assets/screenshot.png)

## Disclaimer
Contrary to what most people would assume, I do not hate SystemD. I think  
that SystemD is a very useful suite, and that has never been my motivation  
when using alternative init/service management systems. I use alternatives  
to promote the diversity and compatability of these applications. While  
many claim SystemD is a modular suite, projects like eLogind are great  
examples of the work necessary to separate single components from the rest  
of Systemd. The clear reality is that it is only modular when in the context  
of the greater Systemd suite, making it possible to use Systemd without all  
of it's components; but not in the vain of (practical) usefulness outside.