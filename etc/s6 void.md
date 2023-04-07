https://www.reddit.com/r/voidlinux/comments/cqck5d/change_runit_to_s6_is_possible/
#66pkgs from repos and https://github.com/mobinmob
This is really simple to do and do not ask for hard work. Follow this instructions below and you should be able to boot void on S6. Also, s6 with 66 can be installed aside with runit and so you should do not have trouble at update time as far as you keep runit installed on your system.

Install skalibs execline oblibs s6 s6-rc s6-linux-utils s6-portable-utils 66 66-tools.

Those packages already exist on Void repo even for musl version.

Now make a backup of your /usr/bin/{init,halt,reboot,poweroff,reboot,shutdown} to something like init.runit,halt.runit,... and replace it by those coming from 66 package by making a copy from /etc/66/{init,halt,reboot,poweroff,shutdown} to the /usr/bin directory.

edit the /usr/bin/init as it :

#!/usr/bin/execlineb -P
66-boot -m /run

The /run directory is mounted with the noexec option on Void, the -m option to 66-boot will remount it without this options. Note , the live directory can be handled at compilation time or by passing command option at 66 API but for the example i will use the default one.

Now clone the https://framagit.org/obarun/boot-66serv.git git repo. The boot-66serv is not provided yet on the Void repository (i think mobinmob will make this package available soon). This set of service is portable and works out of the box on the majority of linux distribution (proof of concept for funtoo here: https://forum.obarun.org/viewtopic.php?id=956)

cd to the cloned folder and :

./configure --bindir=/usr/bin --shebangdir=/usr/bin --with-system-service=/usr/share/66/service

then

make install

edit the /etc/66/boot.conf to suit your needs (self explained boot configuration file)

Now, create a tree and enable the service for the boot

66-tree -n boot
66-enable -t boot boot

the 66-tree command create a tree named boot, the 66-enable command enable the set of service called boot inside the tree boot.

You may want tty and some other service.

You can find a lot of example as frontend service file for 66 here: https://framagit.org/pkg/observice.

To be able to run a tty, create a file at /etc/66/service/tty@ containing this:

[main]
@type = classic
@description = "Launch @I" 
@user = ( root )
@options = ( env )  

[start]
@build = auto
@execute = ( execl-cmdline -s { agetty ${cmd_args} @I } )

[environment]
cmd_args=!-J 38400 

then create a new tree (to separate boot service from runtime service) called e.g root and enable the tty service into it:

66-tree -nE root
66-enable -t root tty@tty1 tty@tty2 tty@tty3

Yes, 66 can deal with instantiated service :).

Now reboot, do not use the reboot command but the runit command instead (to be honest i don't remember the exact runit command to shut the scandir).

And voila, you have Void on s6 with the useful 66 manager tools

Proof of concept here: https://forum.obarun.org/viewtopic.php?id=957

Mailing list for 66: https://obarun.org/mailman/listinfo/66_obarun.org

66 online documentation: http://web.obarun.org/software/

Happy hack :)


Note: zfs is supported but surely need improvement, encryption is also supported but not really and deeply tested
