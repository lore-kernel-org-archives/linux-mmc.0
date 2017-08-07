From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: See SD ECC errors with 4.13-rc kernel
Date: Mon, 7 Aug 2017 06:19:14 +0000
Message-ID: <TY1PR06MB0992B98FFB15D5EE52E4C59CD8B50@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <20170806031357.GX31819@dragon>
 <8f77f49c-118e-0aa0-41d8-b62db50fdb6a@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:64026 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751809AbdHGGTT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 02:19:19 -0400
In-Reply-To: <8f77f49c-118e-0aa0-41d8-b62db50fdb6a@rock-chips.com>
Content-Language: ja-JP
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

> -----Original Message-----
> From: Shawn Lin
> Sent: Monday, August 7, 2017 10:34 AM
>=20
> + Jaehoon,
>=20
> On 2017/8/6 11:14, Shawn Guo wrote:
> > Hi Wolfram,
> >
> > I'm seeing SD card errors on Hikey board with 4.13-rc kernel.  Full log
> > can be found at the bottom.
> >
> > As it's never seen before with 4.12, I ran bisect down to the following
> > commits.
> >
> > 9820a5b11101 (mmc: core: for data errors, take response of stop cmd int=
o account)
> > a04e6bae9e6f (mmc: core: check also R1 response for stop commands)
> >
> > I understand that the commits might just expose the problem with my
> > platform (dw_mmc-k3 driver, Kingston 16GB UHS-I card).  But I'd like to
> > fix the problem, so I appreciate it if you can give some suggestion on
> > where I should start looking into.  Thanks.
>=20
> I did slove this last week but haven't had time to sent out the patch
> until now.
>=20
> Could you try this?
>=20
> https://patchwork.kernel.org/patch/9884197/

I also tested this patch and it could resolve the issue.
So, I would like to send my "Tested-by" for the patch.
But, I realized my linux-mmc subscription was ended now...

To Ulf-san,

If possible, could you add my "Tested-by" on the patch below?
https://patchwork.kernel.org/patch/9884197/

Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

< Testing method >
 - Connect 1GB sd card to my environment (H3 on Salvator-X)
 - I ran the following command:
  # dd if=3D/dev/mmcblk1 of=3D/dev/null bs=3D512k skip=3D1700

Best regards,
Yoshihiro Shimoda

>=20
> >
> > Shawn
> >
> > ---
> >
> > [    4.906950] VFS: Mounted root (ext4 filesystem) readonly on device 1=
79:258.
> > [    4.921943] Freeing unused kernel memory: 576K
> > SELinux:  Could not open policy file <=3D /etc/selinux/targeted/policy/=
policy.31:  No such file or directory
> >
> > Welcome to Debian GNU/Linux 8 (jessie)!
> >
> > [    5.404283] mmcblk1: error -5 sending stop command, original cmd res=
ponse 0x900, card status 0x900
> > [    5.418355] mmcblk1: error -5 transferring data, sector 31268856, nr=
 8, cmd response 0x900, card status 0x80000b00
> > [    5.459775] mmc_host mmc1: Bus speed (slot 0) =3D 24800000Hz (slot r=
eq 400000Hz, actual 400000HZ div =3D 31)
> > [    5.523587] mmc_host mmc1: Bus speed (slot 0) =3D 49600000Hz (slot r=
eq 50000000Hz, actual 49600000HZ div =3D 0)
> > [    5.543513] mmcblk1: error -5 sending stop command, original cmd res=
ponse 0x900, card status 0x900
> > [    5.561422] mmcblk1: error -5 transferring data, sector 31268856, nr=
 8, cmd response 0x900, card status 0x80000b00
> > [    5.580871] mmcblk1: retrying using single block read
> > Cannot add dependency job for unit display-manager.service, ignoring: U=
nit display-manager.service failed to load: No
> such file or directory.
> >           Expecting device dev-ttyAMA3.device...
> > [  OK  ] Reached target Remote File Systems (Pre).
> > [  OK  ] Reached target Encrypted Volumes.
> > [  OK  ] Reached target Swap.
> >           Expecting device dev-disk-by\x2dpartlabel-boot.device...
> > [  OK  ] Created slice Root Slice.
> > [  OK  ] Created slice User and Session Slice.
> > [  OK  ] Listening on Delayed Shutdown Socket.
> > [  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
> > [  OK  ] Listening on Journal Socket (/dev/log).
> > [  OK  ] Listening on udev Control Socket.
> > [  OK  ] Listening on udev Kernel Socket.
> > [  OK  ] Listening on Journal Socket.
> > [  OK  ] Created slice System Slice.
> >           Starting File System Check on Root Device...
> > [  OK  ] Created slice system-getty.slice.
> > [  OK  ] Created slice system-serial\x2dgetty.slice.
> >           Starting Increase datagram queue length...
> >           Starting Nameserver information manager...
> >           Mounting Debug File System...
> >           Starting udev Coldplug all Devices...
> >           Starting Create Static Device Nodes in /dev...
> >           Mounting Huge Pages File System...
> >           Starting Load Kernel Modules...
> >           Mounting POSIX Message Queue File System...
> > [  OK  ] Reached target Slices.
> > [  OK  ] Started Load Kernel Modules.
> >           Mounting FUSE Control File System...
> >           Starting Apply Kernel Variables...
> >           Mounting Configuration File System...
> > [    6.212549] mmcblk1: error -5 sending stop command, original cmd res=
ponse 0x900, card status 0x900
> > [    6.230979] mmcblk1: error -5 transferring data, sector 31268856, nr=
 8, cmd response 0x900, card status 0x80000b00
> > [    6.275381] mmc_host mmc1: Bus speed (slot 0) =3D 24800000Hz (slot r=
eq 400000Hz, actual 400000HZ div =3D 31)
> > [    6.343205] mmc_host mmc1: Bus speed (slot 0) =3D 49600000Hz (slot r=
eq 50000000Hz, actual 49600000HZ div =3D 0)
> > [    6.364615] mmcblk1: error -5 sending stop command, original cmd res=
ponse 0x900, card status 0x900
> > [    6.384189] mmcblk1: error -5 transferring data, sector 31268856, nr=
 8, cmd response 0x900, card status 0x80000b00
> > [    6.405302] mmcblk1: retrying using single block read
> > [  OK  ] Started udev Coldplug all Devices.
> > [  OK  ] Mounted Huge Pages File System.
> > [  OK  ] Mounted Debug File System.
> > [  OK  ] Mounted FUSE Control File System.
> > [  OK  ] Mounted POSIX Message Queue File System.
> > [  OK  ] Mounted Configuration File System.
> > [  OK  ] Started Increase datagram queue length.
> > [  OK  ] Listening on Syslog Socket.
> >           Starting Journal Service...
> > [  OK  ] Started Journal Service.
> > [  OK  ] Started Nameserver information manager.
> > [  OK  ] Started Apply Kernel Variables.
> > [  OK  ] Started Create Static Device Nodes in /dev.
> >           Starting udev Kernel Device Manager...
> > [    6.597344] systemd-udevd[2082]: starting version 215
> > [  OK  ] Started udev Kernel Device Manager.
> >           Starting Copy rules generated while the root was ro...
> >           Starting LSB: Set preliminary keymap...
> > [  OK  ] Started Copy rules generated while the root was ro.
> > [    6.866318] systemd-fsck[1346]: system: clean, 65196/974848 files, 4=
27653/3891968 blocks
> > [  OK  ] Started File System Check on Root Device.
> > [  OK  ] Found device /dev/ttyAMA3.
> > [  OK  ] Started LSB: Set preliminary keymap.
> >           Starting Remount Root and Kernel File Systems...
> > [  OK  ] Reached target Sound Card.
> > [  OK  ] Found device /dev/disk/by-partlabel/boot.
> > [    9.331908] EXT4-fs (mmcblk1p2): re-mounted. Opts: errors=3Dremount-=
ro
> > [  OK  ] Started Remount Root and Kernel File Systems.
> >           Starting Load/Save Random Seed...
> > [  OK  ] Reached target Local File Systems (Pre).
> >           Mounting /boot/efi...
> > [  OK  ] Mounted /boot/efi.
> > [  OK  ] Reached target Local File Systems.
> >           Starting Create Volatile Files and Directories...
> >           Starting Tell Plymouth To Write Out Runtime Data...
> > [  OK  ] Reached target Remote File Systems.
> >           Starting Trigger Flushing of Journal to Persistent Storage...
> >           Starting LSB: Prepare console...
> > [  OK  ] Started Tell Plymouth To Write Out Runtime Data.
> > [  OK  ] Started Load/Save Random Seed.
> >           Starting LSB: Raise network interfaces....
> > [  OK  ] Started Create Volatile Files and Directories.
> > [    9.568943] systemd-journald[2076]: Received request to flush runtim=
e journal from PID 1
> >           Starting Update UTMP about System Boot/Shutdown...
> > [  OK  ] Started Trigger Flushing of Journal to Persistent Storage.
> > [  OK  ] Started Update UTMP about System Boot/Shutdown.
> > [  OK  ] Started LSB: Prepare console.
> >           Starting LSB: Set console font and keymap...
> > [  OK  ] Started LSB: Raise network interfaces..
> > [  OK  ] Reached target Network.
> > [  OK  ] Reached target Network is Online.
> > [  OK  ] Started LSB: Set console font and keymap.
> > [  OK  ] Reached target System Initialization.
> > [  OK  ] Listening on D-Bus System Message Bus Socket.
> > [  OK  ] Listening on ACPID Listen Socket.
> > [  OK  ] Reached target Sockets.
> > [  OK  ] Reached target Timers.
> >           Starting Restore Sound Card State...
> > [  OK  ] Reached target Paths.
> > [  OK  ] Reached target Basic System.
> >           Starting Restore /etc/resolv.conf if the system cras...s shut=
 down....
> >           Starting Modem Manager...
> >           Starting Initialize hardware monitoring sensors...
> >           Starting Regular background program processing daemon...
> > [  OK  ] Started Regular background program processing daemon.
> >           Starting Network Manager...
> >           Starting OpenBSD Secure Shell server...
> > [  OK  ] Started OpenBSD Secure Shell server.
> >           Starting /etc/rc.local Compatibility...
> >           Starting Login Service...
> >           Starting LSB: exim Mail Transport Agent...
> >           Starting LSB: SANE network scanner server...
> >           Starting LSB: Load kernel modules needed to enable cpufreq sc=
aling...
> >           Starting LSB: Advanced IEEE 802.11 management daemon...
> >           Starting LSB: network benchmark...
> >           Starting D-Bus System Message Bus...
> > [  OK  ] Started D-Bus System Message Bus.
> >           Starting System Logging Service...
> >           Starting Permit User Sessions...
> >           Starting ACPI event daemon...
> > [  OK  ] Started ACPI event daemon.
> > [  OK  ] Started Restore Sound Card State.
> > [  OK  ] Started Restore /etc/resolv.conf if the system crash...was shu=
t down..
> > [  OK  ] Started /etc/rc.local Compatibility.
> > [  OK  ] Started LSB: SANE network scanner server.
> > [  OK  ] Started LSB: Load kernel modules needed to enable cpufreq scal=
ing.
> > [  OK  ] Started LSB: Advanced IEEE 802.11 management daemon.
> > [  OK  ] Started LSB: network benchmark.
> > [  OK  ] Started Permit User Sessions.
> > [  OK  ] Started Initialize hardware monitoring sensors.
> > [  OK  ] Started System Logging Service.
> > [  OK  ] Started Login Service.
> >           Starting Authenticate and Authorize Users to Run Privileged T=
asks...
> >           Starting LSB: set CPUFreq kernel parameters...
> >           Starting Wait for Plymouth Boot Screen to Quit...
> >           Starting Terminate Plymouth Boot Screen...
> > [  OK  ] Started Wait for Plymouth Boot Screen to Quit.
> > [  OK  ] Started Terminate Plymouth Boot Screen.
> >           Starting Getty on tty1...
> > [  OK  ] Started Getty on tty1.
> >           Starting Serial Getty on ttyAMA3...
> > [  OK  ] Started Serial Getty on ttyAMA3.
> > [  OK  ] Reached target Login Prompts.
> > [  OK  ] Started LSB: set CPUFreq kernel parameters.
> > [  OK  ] Started Authenticate and Authorize Users to Run Privileged Tas=
ks.
> > [  OK  ] Started Network Manager.
> > [  OK  ] Started Modem Manager.
> > [  OK  ] Started LSB: exim Mail Transport Agent.
> > [  OK  ] Reached target Multi-User System.
> > [  OK  ] Reached target Graphical Interface.
> >           Starting Update UTMP about System Runlevel Changes...
> > [  OK  ] Start
> > Debian GNU/Linux 8 linaro-developer ttyAMA3
> >
> > linaro-developer login: root (automatic login)
> >
> > Last login: Thu Jan  1 00:00:34 UTC 1970 on ttyAMA3
> > Linux linaro-developer 4.13.0-rc1-00021-g6e300ca3015c-dirty #70 SMP PRE=
EMPT Wed Aug 2 [   12.715455] random: crng init
> done
> > 17:08:14 CST 2017 aarch64
> >
> > The programs included with the Debian GNU/Linux system are free softwar=
e;
> > the exact distribution terms for each program are described in the
> > individual files in /usr/share/doc/*/copyright.
> >
> > Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
> > permitted by applicable law.
> > root@linaro-developer:~#
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >

