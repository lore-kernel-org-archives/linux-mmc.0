From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Corruption on shutdown outside the current partition
Date: Mon, 30 May 2011 16:04:46 +0000 (UTC)
Message-ID: <is0f6q$45g$1@dough.gmane.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45578 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757346Ab1E3QKH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 30 May 2011 12:10:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1QR52a-00034W-Pp
	for linux-mmc@vger.kernel.org; Mon, 30 May 2011 18:10:04 +0200
Received: from ram94-11-88-187-113-157.fbx.proxad.net ([88.187.113.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 18:10:04 +0200
Received: from romain.izard.pro by ram94-11-88-187-113-157.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 18:10:04 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Hello,

During reliability testing of an embedded Linux system using a eMMC chip
for code storage and execution, I have encountered occurences of
corruption outside of the partition being tested, typically breaking the
test in progress. This is a random occurence with a relatively low
frequency, but I can reproduce it with little effort. The corruption
always occurs during shutdown, after calling the kernel syscall
reboot(RB_AUTOBOOT), to test for forcible shutdown.

There is no flushing done at this precise point, because I am trying to
test for user reboots or power shutdowns, a use case where the flushing
or unmounting cannot be expected. However, the call to reset is done on
a thread independant from the testing code, which means that the code
being tested continues to run until it encounters an error in its file
system operations. This means that there still are calls to read, write,
mkdir, rmdir, etc. until the processes are killed by the kernel during
the shutdown process.

If I use a hardware reset method instead of the kernel syscall, by
triggering a watchdog with interrupts locked, or doing a power cycle
with a testing machine, the problem does not happen. This led me to
think it could be a software failure, rather than the hardware failure I
was expecting. After activating the traces in the mmc subsystem, I
finally managed to catch write commands to an area outside the partition
being tested, which means that the problem is really due to software.

For this test, the eMMC is partitioned in 6 partitions, as described
below. The testing partition is mmcblk0p5, formatted in ext3, as are all
other Linux partitions. The bootloader is stored in mmcblk0p2, and is
able to load the kernel image stored in a directory of /dev/mmcblk0p1.

------------------------------------------------------------
Partitioning:
------------------------------------------------------------
# sfdisk -l -uS /dev/mmcblk0

Disk /dev/mmcblk0: 120832 cylinders, 4 heads, 16 sectors/track
Units = sectors of 512 bytes, counting from 0

   Device Boot    Start       End   #sectors  Id  System
/dev/mmcblk0p1          4096    262143     258048  83  Linux
/dev/mmcblk0p2             1      4095       4095  da  Non-FS data
/dev/mmcblk0p3        524288   7733247    7208960   5  Extended
/dev/mmcblk0p4        262144    524287     262144  83  Linux
/dev/mmcblk0p5        524289   1048575     524287  83  Linux
/dev/mmcblk0p6       1048577   7733247    6684671  83  Linux

------------------------------------------------------------

Unfortunately, all this is not running on an up-to-date kernel, since
there is no updated BSP for the SoC in use in my embedded system. Unless
I spend a lot of time porting all the SoC drivers to 2.6.39, I am
restricted to working with my current kernel, which is based on
linux-2.6.32 with a set of android patches. This means that the bug may
already have been corrected ages ago, or that the problem is due to an
error in the SoC drivers, or even that the problem still exists in the
current kernel.

Thus, I am looking for help to interpret the traces I have collected,
and to understand what is happenning in the file system when the problem
occurs. I am also interested in any additional tracing method that can
help me to extract more information from my system, since I do not have
hardware debug means at my disposition.

My tracing setup only uses traces from printk displayed on the serial
port, with an additional delay for flushing the trace buffer before
reset is called. I tried using ftrace to get the origin of the error,
but the trace stops too early during shutdown when my 'cat' process is
shut down. The kernel trace level is switch to 8 when the reboot is
requested, while my test software continues to display its terse
execution report (a letter by test) until it encounters a filesystem
error.

Up to now, my analysis is as follows:

>From the traces, you can observe than the mmc write command (CMD25)
usually writes blocks between 0x80001-0xFFFFF, which correspond to the
tested file system, and 0x40000-0x7FFFF, which correspond to the root
file system, mounted as R/W. However, while observing the last 5 write
commands, one of them direclty writes an address well below the root
file system, which corresponds to the boot image partition, which is not
mounted at this time. This means that this write command is an error,
and it corrupts the partition containing the boot images. This is
coherent with the fact that at the next boot, the bootloader complains
that it cannot read that partition, and stops.


------------------------------------------------------------
Traces:
------------------------------------------------------------

Do syscall rese[   21.484080] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.488670] mmc0:     8192 bytes transferred: 0
[   21.493098] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.502808] mmc2: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[   21.510434] mmc1: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[   21.517766] mmc0: card 0001 removed
t !
[   21.530798] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.546844] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.577562] mmc0: starting CMD25 arg 000e0003 flags 000000b5
[   21.596441] mmc0:     blksz 512 blocks 28 flags 00000100 tsac 1600 ms nsac 0
[   21.612791] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.617141] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.622175] mmc0:     14336 bytes transferred: 0
[   21.626727] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.634024] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.642066] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.647082] mmc0: starting CMD25 arg 000e0021 flags 000000b5
[   21.651953] mmc0:     blksz 512 blocks 4 flags 00000100 tsac 1600 ms nsac 0
[   21.658925] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.665155] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.670884] mmc0:     2048 bytes transferred: 0
[   21.675343] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.681899] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.687530] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.694790] mmc0: starting CMD25 arg 000b9753 flags 000000b5
[   21.699986] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   21.706918] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.713293] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.718949] mmc0:     1024 bytes transferred: 0
[   21.723432] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.729944] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.735722] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.744549] mmc0: starting CMD25 arg 000b9755 flags 000000b5
[   21.748112] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   21.755044] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.761500] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.767035] mmc0:     1024 bytes transferred: 0
[   21.771548] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.778080] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.783720] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.791487] mmc0: starting CMD25 arg 000e1005 flags 000000b5
[   21.796195] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   21.803094] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.810297] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.815109] mmc0:     3072 bytes transferred: 0
[   21.819612] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.826107] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.831801] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.839391] mmc0: starting CMD25 arg 000e1475 flags 000000b5
[   21.844276] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   21.851200] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.857946] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.863196] mmc0:     1024 bytes transferred: 0
[   21.867697] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.874209] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.879952] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.886968] mmc0: starting CMD25 arg 00080003 flags 000000b5
[   21.892378] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   21.899337] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.906342] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.911301] mmc0:     1024 bytes transferred: 0
[   21.915785] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.922329] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.927970] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.935074] mmc0: starting CMD25 arg 00080207 flags 000000b5
[   21.940513] mmc0:     blksz 512 blocks 8 flags 00000100 tsac 1600 ms nsac 0
[   21.947360] mmc0:     CMD12 arg 00000000 flags 0000049d
[   21.953941] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   21.959371] mmc0:     4096 bytes transferred: 0
[   21.963870] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   21.970388] mmc0: starting CMD13 arg 00010000 flags 00000015
[   21.976116] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   21.983165] mmc0: starting CMD25 arg 0008040b flags 000000b5
[   21.988562] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   21.995520] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.001722] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.007457] mmc0:     1024 bytes transferred: 0
[   22.011973] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.018504] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.024143] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.034635] mmc0: starting CMD25 arg 00081415 flags 000000b5
[   22.037619] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   22.044530] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.050906] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.056559] mmc0:     3072 bytes transferred: 0
[   22.061058] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.067543] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.073246] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.081284] mmc0: starting CMD25 arg 000e1505 flags 000000b5
[   22.085731] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.092747] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.099616] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.104644] mmc0:     1024 bytes transferred: 0
[   22.109154] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.115721] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.121321] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.128449] mmc0: starting CMD25 arg 000b9757 flags 000000b5
[   22.133842] mmc0:     blksz 512 blocks 26 flags 00000100 tsac 1600 ms nsac 0
[   22.140870] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.148480] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.152838] mmc0:     13312 bytes transferred: 0
[   22.157396] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.163963] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.169603] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.177128] mmc0: starting CMD25 arg 000e153f flags 000000b5
[   22.182065] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.189001] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.195990] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.200991] mmc0:     1024 bytes transferred: 0
[   22.205482] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.212003] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.217770] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.224847] mmc0: starting CMD25 arg 000e1583 flags 000000b5
[   22.230156] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.237139] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.243372] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.249107] mmc0:     1024 bytes transferred: 0
[   22.253576] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.260127] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.265760] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.272995] mmc0: starting CMD25 arg 000b9771 flags 000000b5
[   22.278221] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.285142] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.292245] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.297161] mmc0:     1024 bytes transferred: 0
[   22.301672] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.308144] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.313846] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
T[   22.324405] mmc0: starting CMD25 arg 0008141d flags 000000b5
[   22.327393] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.334342] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.341380] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.346327] mmc0:     1024 bytes transferred: 0
[   22.350852] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.357378] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.363010] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.370517] mmc0: starting CMD25 arg 000e15db flags 000000b5
[   22.375579] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.382410] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.389379] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.394417] mmc0:     1024 bytes transferred: 0
[   22.398917] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.405459] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.411109] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.418259] mmc0: starting CMD25 arg 0008141b flags 000000b5
[   22.423574] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.430495] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.437550] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.442501] mmc0:     1024 bytes transferred: 0
[   22.446993] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.453517] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.459247] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.466799] mmc0: starting CMD25 arg 000e15e1 flags 000000b5
[   22.471768] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.478577] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.485497] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.490611] mmc0:     1024 bytes transferred: 0
[   22.495090] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.501700] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.507252] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.514401] mmc0: starting CMD25 arg 000b9773 flags 000000b5
[   22.519840] mmc0:     blksz 512 blocks 16 flags 00000100 tsac 1600 ms nsac 0
[   22.526761] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.570545] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.574676] mmc0:     8192 bytes transferred: 0
[   22.579171] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.585690] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.591350] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.598935] mmc0: starting CMD25 arg 000e16f3 flags 000000b5
[   22.603827] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.610753] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.618715] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.622834] mmc0:     1024 bytes transferred: 0
[   22.627335] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.633862] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.639586] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.646728] mmc0: starting CMD25 arg 000e1711 flags 000000b5
[   22.652003] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.658988] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.665192] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.670954] mmc0:     1024 bytes transferred: 0
[   22.675424] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.681978] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.687616] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.694932] mmc0: starting CMD25 arg 000b9783 flags 000000b5
[   22.700088] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.706992] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.714069] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.719035] mmc0:     1024 bytes transferred: 0
[   22.723513] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.730030] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.735784] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.745872] mmc0: starting CMD25 arg 000e1739 flags 000000b5
[   22.750030] mmc0:     blksz 512 blocks 4 flags 00000100 tsac 1600 ms nsac 0
[   22.755808] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.763054] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.767806] mmc0:     2048 bytes transferred: 0
[   22.772315] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.778858] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.784483] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.791624] mmc0: starting CMD25 arg 00081403 flags 000000b5
[   22.797043] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   22.803883] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.810855] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.815897] mmc0:     3072 bytes transferred: 0
[   22.820377] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.826880] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.832570] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.840531] mmc0: starting CMD25 arg 000e17ff flags 000000b5
[   22.845055] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.851985] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.859489] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.863981] mmc0:     1024 bytes transferred: 0
[   22.868465] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.874982] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.880766] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.887856] mmc0: starting CMD25 arg 000b9785 flags 000000b5
[   22.893143] mmc0:     blksz 512 blocks 16 flags 00000100 tsac 1600 ms nsac 0
[   22.900211] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.907336] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.912168] mmc0:     8192 bytes transferred: 0
[   22.916663] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.923203] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.928839] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.936320] mmc0: starting CMD25 arg 000e1855 flags 000000b5
[   22.941310] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.948220] mmc0:     CMD12 arg 00000000 flags 0000049d
[   22.955224] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   22.960237] mmc0:     1024 bytes transferred: 0
[   22.964751] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   22.971247] mmc0: starting CMD13 arg 00010000 flags 00000015
[   22.976985] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   22.984052] mmc0: starting CMD25 arg 000e1893 flags 000000b5
[   22.989413] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   22.996377] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.002823] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.008323] mmc0:     1024 bytes transferred: 0
[   23.012836] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.019378] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.025009] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.032126] mmc0: starting CMD25 arg 000b9795 flags 000000b5
[   23.037553] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.044398] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.051570] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.056411] mmc0:     1024 bytes transferred: 0
[   23.060905] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.067405] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.073109] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
M[   23.083955] mmc0: starting CMD25 arg 0008140b flags 000000b5
[   23.086940] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.093882] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.100889] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.105881] mmc0:     1024 bytes transferred: 0
[   23.110388] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.116937] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.122552] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.130221] mmc0: starting CMD25 arg 000e18c1 flags 000000b5
[   23.135042] mmc0:     blksz 512 blocks 4 flags 00000100 tsac 1600 ms nsac 0
[   23.141940] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.148884] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.153979] mmc0:     2048 bytes transferred: 0
[   23.158462] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.165028] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.170774] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.177845] mmc0: starting CMD25 arg 00081409 flags 000000b5
[   23.183120] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.190045] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.197042] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.202052] mmc0:     1024 bytes transferred: 0
[   23.206548] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.213068] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.218802] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.226365] mmc0: starting CMD25 arg 000e1937 flags 000000b5
[   23.231244] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.238204] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.245154] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.250157] mmc0:     1024 bytes transferred: 0
[   23.254640] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.261185] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.266833] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.274022] mmc0: starting CMD25 arg 000b9797 flags 000000b5
[   23.279303] mmc0:     blksz 512 blocks 16 flags 00000100 tsac 1600 ms nsac 0
[   23.286292] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.293514] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.298328] mmc0:     8192 bytes transferred: 0
[   23.302817] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.309329] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.315071] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.322373] mmc0: starting CMD25 arg 000e193d flags 000000b5
[   23.327480] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.334405] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.341464] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.346415] mmc0:     1024 bytes transferred: 0
[   23.350915] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.357449] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.363087] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.370198] mmc0: starting CMD25 arg 000e1953 flags 000000b5
[   23.375693] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   23.382468] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.388816] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.394505] mmc0:     3072 bytes transferred: 0
[   23.398997] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.405536] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.411187] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.418371] mmc0: starting CMD25 arg 000b97a7 flags 000000b5
[   23.423680] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.430566] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.437732] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.442569] mmc0:     1024 bytes transferred: 0
[   23.447083] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.453584] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.459330] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.466903] mmc0: starting CMD25 arg 000e19d7 flags 000000b5
[   23.471764] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.478766] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.485688] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.490684] mmc0:     1024 bytes transferred: 0
[   23.495164] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.501744] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.507332] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.514474] mmc0: starting CMD25 arg 000e19ef flags 000000b5
[   23.519901] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.526735] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.533027] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.538763] mmc0:     1024 bytes transferred: 0
[   23.543246] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.549774] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.555488] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.562541] mmc0: starting CMD25 arg 000e19ff flags 000000b5
[   23.567908] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   23.574829] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.581352] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.586843] mmc0:     3072 bytes transferred: 0
[   23.591348] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.597901] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.603516] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.610807] mmc0: starting CMD25 arg 000e1a3d flags 000000b5
[   23.615987] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.622895] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.629160] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.634932] mmc0:     1024 bytes transferred: 0
[   23.639414] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.645975] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.651620] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.658855] mmc0: starting CMD25 arg 000e1a59 flags 000000b5
[   23.664077] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.671008] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.677551] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.683024] mmc0:     1024 bytes transferred: 0
[   23.687502] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.694025] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.699784] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.706920] mmc0: starting CMD25 arg 000e1a89 flags 000000b5
[   23.712195] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.719157] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.725360] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.731128] mmc0:     1024 bytes transferred: 0
[   23.735596] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.742144] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.747781] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.755023] mmc0: starting CMD25 arg 000e1ad3 flags 000000b5
[   23.760239] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.767163] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.773500] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.779208] mmc0:     1024 bytes transferred: 0
[   23.783689] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.790192] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.795937] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.802963] mmc0: starting CMD25 arg 000e1b2d flags 000000b5
[   23.808340] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.815273] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.821603] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.827281] mmc0:     1024 bytes transferred: 0
[   23.831798] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.838319] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.843956] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.851085] mmc0: starting CMD25 arg 000e1b31 flags 000000b5
[   23.856507] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.863356] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.869710] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.875368] mmc0:     1024 bytes transferred: 0
[   23.879867] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.886386] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.892056] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.899252] mmc0: starting CMD25 arg 000e1c27 flags 000000b5
[   23.904523] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   23.911452] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.917989] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.923447] mmc0:     3072 bytes transferred: 0
[   23.927949] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.934460] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.940197] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.947286] mmc0: starting CMD25 arg 000e1c7f flags 000000b5
[   23.952758] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   23.959521] mmc0:     CMD12 arg 00000000 flags 0000049d
[   23.965860] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   23.971547] mmc0:     1024 bytes transferred: 0
[   23.976031] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   23.982582] mmc0: starting CMD13 arg 00010000 flags 00000015
[   23.988213] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   23.995323] mmc0: starting CMD25 arg 000e1c83 flags 000000b5
[   24.000780] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.007605] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.013918] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.019633] mmc0:     1024 bytes transferred: 0
[   24.024115] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.030751] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.036301] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.043407] mmc0: starting CMD25 arg 000e1d73 flags 000000b5
[   24.048793] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.055705] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.062107] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.067709] mmc0:     1024 bytes transferred: 0
[   24.072221] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.078759] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.084387] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.091500] mmc0: starting CMD25 arg 000e1d97 flags 000000b5
[   24.096966] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.103788] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.110071] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.115817] mmc0:     1024 bytes transferred: 0
[   24.120289] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.126786] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.132493] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.139730] mmc0: starting CMD25 arg 000e1d9b flags 000000b5
[   24.144926] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.151874] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.158295] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.163899] mmc0:     1024 bytes transferred: 0
[   24.168375] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.174891] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.180675] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.187729] mmc0: starting CMD25 arg 000e1e9b flags 000000b5
[   24.193041] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.200036] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.206254] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.211999] mmc0:     1024 bytes transferred: 0
[   24.216468] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.223019] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.228686] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.235882] mmc0: starting CMD25 arg 000e2009 flags 000000b5
[   24.241120] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.248042] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.255037] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.260066] mmc0:     1024 bytes transferred: 0
[   24.264551] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.271063] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.276804] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.283910] mmc0: starting CMD25 arg 000e2569 flags 000000b5
[   24.289207] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.296145] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.302499] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.308156] mmc0:     1024 bytes transferred: 0
[   24.312668] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.319196] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.324826] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.332066] mmc0: starting CMD25 arg 000e264d flags 000000b5
[   24.337311] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.344218] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.350496] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.356252] mmc0:     1024 bytes transferred: 0
[   24.360740] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.367229] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.372924] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.380075] mmc0: starting CMD25 arg 000e4207 flags 000000b5
[   24.385395] mmc0:     blksz 512 blocks 16 flags 00000100 tsac 1600 ms nsac 0
[   24.392401] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.398993] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.404407] mmc0:     8192 bytes transferred: 0
[   24.408899] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.415429] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.421160] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.428272] mmc0: starting CMD25 arg 000e5439 flags 000000b5
[   24.433591] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.440548] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.446882] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.452508] mmc0:     1024 bytes transferred: 0
[   24.456996] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.463546] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.469176] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.476225] mmc0: starting CMD25 arg 000e543d flags 000000b5
[   24.481753] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.488565] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.494886] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.500592] mmc0:     1024 bytes transferred: 0
[   24.505085] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.511596] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.517323] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.524380] mmc0: starting CMD25 arg 000e5449 flags 000000b5
[   24.529776] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.536759] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.542905] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.548673] mmc0:     1024 bytes transferred: 0
[   24.553178] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.559736] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.565338] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.572467] mmc0: starting CMD25 arg 000e545b flags 000000b5
[   24.577915] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.584743] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.591189] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.596774] mmc0:     1024 bytes transferred: 0
[   24.601246] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.607749] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.613445] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.620594] mmc0: starting CMD25 arg 000e549f flags 000000b5
[   24.625928] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.632839] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.639142] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.644855] mmc0:     1024 bytes transferred: 0
[   24.649339] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.655856] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.661592] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.668723] mmc0: starting CMD25 arg 000e54cf flags 000000b5
[   24.673993] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.680992] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.687225] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.692962] mmc0:     1024 bytes transferred: 0
[   24.697429] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.703980] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.709662] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.716844] mmc0: starting CMD25 arg 000e5519 flags 000000b5
[   24.722075] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.728997] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.735270] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.741031] mmc0:     1024 bytes transferred: 0
[   24.745517] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.752030] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.757792] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.764870] mmc0: starting CMD25 arg 000e5521 flags 000000b5
[   24.770185] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.777164] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.783497] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.789111] mmc0:     1024 bytes transferred: 0
[   24.793639] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.800143] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.805784] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.815850] mmc0: starting CMD25 arg 000e5549 flags 000000b5
[   24.820231] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.825793] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.832054] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.837790] mmc0:     1024 bytes transferred: 0
[   24.842271] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.848770] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.854459] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.861622] mmc0: starting CMD25 arg 00081415 flags 000000b5
[   24.866945] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   24.873853] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.880891] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.885856] mmc0:     3072 bytes transferred: 0
[   24.890371] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.896916] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.902535] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.910865] mmc0: starting CMD25 arg 000e556f flags 000000b5
[   24.915002] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   24.921917] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.928960] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.933968] mmc0:     1024 bytes transferred: 0
[   24.938444] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.945010] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.950669] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   24.957871] mmc0: starting CMD25 arg 000b97a9 flags 000000b5
[   24.963098] mmc0:     blksz 512 blocks 26 flags 00000100 tsac 1600 ms nsac 0
[   24.970117] mmc0:     CMD12 arg 00000000 flags 0000049d
[   24.977858] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   24.982114] mmc0:     13312 bytes transferred: 0
[   24.986702] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   24.993230] mmc0: starting CMD13 arg 00010000 flags 00000015
[   24.998965] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.006358] mmc0: starting CMD25 arg 000e55eb flags 000000b5
[   25.011402] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.018357] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.079518] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.083636] mmc0:     1024 bytes transferred: 0
[   25.088131] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.094732] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.100308] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.107482] mmc0: starting CMD25 arg 000e560d flags 000000b5
[   25.112829] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.119791] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.126866] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.131749] mmc0:     1024 bytes transferred: 0
[   25.136224] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.142781] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.148404] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.155566] mmc0: starting CMD25 arg 000b97c3 flags 000000b5
[   25.160974] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.167809] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.174890] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.179816] mmc0:     1024 bytes transferred: 0
[   25.184306] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.190832] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.196560] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
T[   25.207121] mmc0: starting CMD25 arg 0008141d flags 000000b5
[   25.210141] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.217109] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.223979] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.229042] mmc0:     1024 bytes transferred: 0
[   25.233549] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.240093] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.245736] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.253283] mmc0: starting CMD25 arg 000e5677 flags 000000b5
[   25.258209] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.265100] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.272132] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.277135] mmc0:     1024 bytes transferred: 0
[   25.281625] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.288123] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.293828] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.301003] mmc0: starting CMD25 arg 0008141b flags 000000b5
[   25.306288] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.313218] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.320206] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.325220] mmc0:     1024 bytes transferred: 0
[   25.329715] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.336223] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.341960] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.349428] mmc0: starting CMD25 arg 000e567b flags 000000b5
[   25.354408] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.361378] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.368253] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.373321] mmc0:     1024 bytes transferred: 0
[   25.377806] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.384350] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.390002] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.397156] mmc0: starting CMD25 arg 000b97c5 flags 000000b5
[   25.402461] mmc0:     blksz 512 blocks 16 flags 00000100 tsac 1600 ms nsac 0
[   25.409452] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.416777] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.421473] mmc0:     8192 bytes transferred: 0
[   25.425985] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.432494] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.438233] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.445535] mmc0: starting CMD25 arg 000e5697 flags 000000b5
[   25.450774] mmc0:     blksz 512 blocks 4 flags 00000100 tsac 1600 ms nsac 0
[   25.457555] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.464576] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.469564] mmc0:     2048 bytes transferred: 0
[   25.474091] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.480620] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.486243] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.497870] mmc0: starting CMD25 arg 000b97d5 flags 000000b5
[   25.503993] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.513806] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.521568] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.525745] mmc0:     1024 bytes transferred: 0
[   25.530225] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.536798] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.550417] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.565232] mmc0: starting CMD18 arg 00061d9a flags 000000b5
[   25.568313] mmc0:     blksz 512 blocks 2 flags 00000200 tsac 100 ms nsac 0
[   25.575111] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.582236] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[   25.587074] mmc0:     1024 bytes transferred: 0
[   25.591593] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
truncate: No su[   25.601850] mmc0: starting CMD25 arg 0005821a flags 000000b5
[   25.606259] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.612015] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.619049] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.623969] mmc0:     1024 bytes transferred: 0
[   25.628454] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.634981] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.640762] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.647965] mmc0: starting CMD25 arg 00040002 flags 000000b5
[   25.653147] mmc0:     blksz 512 blocks 4 flags 00000100 tsac 1600 ms nsac 0
[   25.660119] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.666437] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.672081] mmc0:     2048 bytes transferred: 0
[   25.676554] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.683107] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.688733] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.695973] mmc0: starting CMD25 arg 00050002 flags 000000b5
[   25.701204] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   25.708118] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.714478] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.720147] mmc0:     3072 bytes transferred: 0
[   25.724645] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.731145] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.736881] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.743969] mmc0: starting CMD25 arg 00001402 flags 000000b5
[   25.749298] mmc0:     blksz 512 blocks 6 flags 00000100 tsac 1600 ms nsac 0
[   25.756227] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.762811] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.768222] mmc0:     3072 bytes transferred: 0
[   25.772745] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.779274] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.784910] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.792425] mmc0: starting CMD18 arg 00038420 flags 000000b5
[   25.797475] mmc0:     blksz 512 blocks 2 flags 00000200 tsac 100 ms nsac 0
[   25.804216] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.810003] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[   25.816233] mmc0:     1024 bytes transferred: 0
[   25.820723] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[   25.827426] journal_bmap: journal block not found at offset 2780 on mmcblk0p5
[   25.834508] mmc0: starting CMD25 arg 0005000a flags 000000b5
[   25.840075] Aborting journal on device mmcblk0p5.
[   25.844679] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.851918] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.857933] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.863622] mmc0:     1024 bytes transferred: 0
[   25.868119] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.874757] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.880289] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.887398] mmc0: starting CMD25 arg 00038206 flags 000000b5
[   25.892809] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.899766] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.906018] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.911727] mmc0:     1024 bytes transferred: 0
[   25.916204] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.922752] mmc0: starting CMD13 arg 00010000 flags 00000015
[   25.928376] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   25.935489] journal commit I/O error
[   25.938923] mmc0: starting CMD25 arg 00051402 flags 000000b5
[   25.944469] ext3_abort called.
[   25.947418] EXT3-fs error (device mmcblk0p5): ext3_journal_start_sb: 
[   25.953718] mmc0:     blksz 512 blocks 2 flags 00000100 tsac 1600 ms nsac 0
[   25.960865] Detected aborted journal
[   25.964176] mmc0:     CMD12 arg 00000000 flags 0000049d
[   25.969536] 
[   25.971001] Remounting filesystem read-only
ch [   25.976374] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[   25.982322] mmc0:     1024 bytes transferred: 0
[   25.986783] mmc0:     (CMD12): 0: 00000c00 00000000 00000000 00000000
[   25.993346] mmc0: starting CMD13 arg 00010000 flags 00000015
file o[   26.001292] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
r directory
fclose: Read-only file system
unlink: Read-only file system
rename: R[   26.015883] mmc0: starting CMD18 arg 00061008 flags 000000b5
ead-only file system
[   26.023784] mmc0:     blksz 512 blocks 2 flags 00000200 tsac 100 ms nsac 0
[   26.029900] mmc0:     CMD12 arg 00000000 flags 0000049d
[   26.034136] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[   26.040019] mmc0:     1024 bytes transferred: 0
[   26.044491] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[   26.051158] EXT3-fs error (device mmcblk0p5): ext3_dx_find_entry: 
[   26.057062] MMC: killing requests for dead queue
[   26.061667] end_request: I/O error, dev mmcblk0, sector 332802
[   26.067786] EXT3-fs error (device mmcblk0p4): ext3_find_entry: reading directory #8193 offset 0
[   26.076413] Buffer I/O error on device mmcblk0p4, logical block 1
[   26.082365] lost page write due to I/O error on mmcblk0p4
[   26.087775] bad entry in directory #49153: rec_len is smaller than minimal - offset=3072, inode=0, rec_len=0, name_len=0
[   26.108167] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
[   26.114289] Restarting system.

------------------------------------------------------------



Best regards,
-- 
Romain Izard

