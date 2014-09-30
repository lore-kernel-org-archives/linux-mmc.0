From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: eMMC and "mkfs.ext3" hangs without "-E nodiscard"
Date: Tue, 30 Sep 2014 09:05:55 +0200
Message-ID: <CAOpc7mEqcVopJ_RB8GDKJXnHNNuwSr88Q=kguXGf_yfZ=8qetw@mail.gmail.com>
References: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
	<2065626.g5SozRVghv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:56523 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaI3HF5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Sep 2014 03:05:57 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so4879898wiv.9
        for <linux-mmc@vger.kernel.org>; Tue, 30 Sep 2014 00:05:55 -0700 (PDT)
In-Reply-To: <2065626.g5SozRVghv@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

Hi Arnd,

> Are you sure that it's not just taking very long?

Hmm, after one or two minutes I lost my patience. Also, hitting Ctrl-C
didn't abort the application. Suspending it with Ctrl-Z doesn't work
either. I did an strace, and the last few lines look like this:

stat64("/dev/mmcblk0p1", {st_mode=S_IFBLK|0660, st_rdev=makedev(179,
5), ...}) = 0
open("/dev/mmcblk0p1", O_RDONLY|O_EXCL) = 3
close(3)                                = 0
open("/dev/mmcblk0p1", O_RDONLY|O_LARGEFILE) = 3
uname({sys="Linux", node="mde", ...})   = 0
ioctl(3, BLKGETSIZE64, 0xbea40610)      = 0
close(3)                                = 0
write(1, "fs_types for mke2fs.conf resolut"..., 37fs_types for
mke2fs.conf resolution: ) = 37
write(1, "'ext3'", 6'ext3')                   = 6
write(1, "\n", 1
)                       = 1
open("/dev/mmcblk0p1", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, BLKSSZGET, 0xbea408b8)         = 0
close(3)                                = 0
open("/dev/mmcblk0p1", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, BLKPBSZGET, 0xbea408bc)        = 0
close(3)                                = 0
stat64("/dev/mmcblk0p1", {st_mode=S_IFBLK|0660, st_rdev=makedev(179,
5), ...}) = 0
open("/dev/mmcblk0p1", O_RDONLY|O_LARGEFILE) = 3
fadvise64_64(3, 0, 0, POSIX_FADV_RANDOM) = 0
fstat64(3, {st_mode=S_IFBLK|0660, st_rdev=makedev(179, 5), ...}) = 0
uname({sys="Linux", node="mde", ...})   = 0
ioctl(3, BLKGETSIZE64, 0x53a4b8)        = 0
ioctl(3, CDROM_GET_CAPABILITY, 0)       = -1 EINVAL (Invalid argument)
ioctl(3, BLKALIGNOFF, 0xbea40764)       = 0
ioctl(3, BLKIOMIN, 0xbea40764)          = 0
ioctl(3, BLKIOOPT, 0xbea40764)          = 0
ioctl(3, BLKPBSZGET, 0xbea40764)        = 0
ioctl(3, BLKSSZGET, 0x53a4d0)           = 0
close(3)                                = 0
access("/sys/fs/ext4/features/lazy_itable_init", R_OK) = -1 ENOENT (No
such file or directory)
open("/dev/mmcblk0p1", O_RDWR|O_EXCL|O_LARGEFILE) = 3
stat64("/dev/mmcblk0p1", {st_mode=S_IFBLK|0660, st_rdev=makedev(179,
5), ...}) = 0
ioctl(3, BLKDISCARDZEROES, 0xbea40880)  = 0
ioctl(3, BLKROGET, 0xbea40884)          = 0
uname({sys="Linux", node="mde", ...})   = 0
gettimeofday({1403353145, 564428}, NULL) = 0
gettimeofday({1403353145, 564587}, NULL) = 0
gettimeofday({1403353145, 564709}, NULL) = 0
ioctl(3, BLKDISCARD

Too bad I cannot see the arguments/results from the ioctls ...



I also noticed that it takes an awful lot of kernel task time:

root@mde:~# top | head -n9
top - 14:09:59 up 2 min,  2 users,  load average: 1.84, 0.79, 0.30
Tasks:  86 total,   2 running,  84 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.3 us, 22.2 sy,  0.0 ni, 54.6 id, 22.5 wa,  0.0 hi,  0.4 si,  0.0 st
KiB Mem:   1034092 total,    86760 used,   947332 free,     2808 buffers
KiB Swap:        0 total,        0 used,        0 free,    52128 cached

  PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
   71 root      20   0     0    0    0 R  99.5  0.0   2:23.54 mmcqd/1
  323 root      20   0  2640 1640 1304 R   5.5  0.2   0:00.02 top

Maybe it's hanging in the kernel ?  The whan stays at get_request:

root@mde:~# ps -a -o pid,f,stat,pcpu,pmem,psr,comm,wchan=WIDE-WCHAN | grep mkfs
  296 0 D+    0.0  0.1   2 mkfs.ext3       get_request



> Can you try erasing a smaller region of the device

Sure, this seems to work.

root@mde:~# blkdiscard /dev/mmcblk0 0 1
erasing 0 to 1 on /dev/mmcblk0
ioctl: Invalid argument
root@mde:~# blkdiscard /dev/mmcblk0 0 512
erasing 0 to 512 on /dev/mmcblk0
root@mde:~# blkdiscard /dev/mmcblk0 0 4096
erasing 0 to 4096 on /dev/mmcblk0
root@mde:~# blkdiscard /dev/mmcblk0 0 8192
erasing 0 to 8192 on /dev/mmcblk0
root@mde:~# blkdiscard /dev/mmcblk0 0 16384
erasing 0 to 16386 on /dev/mmcblk0
ioctl: Invalid argument
root@mde:~# xxd -g0 </dev/mmcblk0 | head
0000000: 00000000000000000000000000000000  ................
0000010: 00000000000000000000000000000000  ................
0000020: 00000000000000000000000000000000  ................
0000030: 00000000000000000000000000000000  ................
0000040: 00000000000000000000000000000000  ................
0000050: 00000000000000000000000000000000  ................
0000060: 00000000000000000000000000000000  ................
0000070: 00000000000000000000000000000000  ................
0000080: 00000000000000000000000000000000  ................
0000090: 00000000000000000000000000000000  ................
