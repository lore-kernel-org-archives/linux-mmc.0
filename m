From: nitin vishnoi <nitvishnoi@gmail.com>
Subject: Re: [PATCH v3 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for
	Samsung SoC
Date: Wed, 28 Jul 2010 08:47:54 +0530
Message-ID: <AANLkTim1RtuRzdoCs4ozCjnA-f1wmZxwJE6T4BvnFVLL@mail.gmail.com>
References: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
	<1279886191-9197-4-git-send-email-kgene.kim@samsung.com>
	<AANLkTiktYdBpgVtYUt69qfas4FHXvKvSEO4y9kf+DArE@mail.gmail.com>
	<001101cb2d86$4afddd90$e0f998b0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1207339533=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <001101cb2d86$4afddd90$e0f998b0$%kim@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Hyuk Lee <hyuk1.lee@samsung.com>, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--===============1207339533==
Content-Type: multipart/alternative; boundary=000e0cd185c245d449048c6a1039

--000e0cd185c245d449048c6a1039
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi

I am porting the 2.6.33.6 kernel,which i took from kernel.org.I am trying t=
o
port it on samsung-s3c2451 board.
But i am not getting the shell prompt,due to getting the following error.An=
y
body can tell due to what this error i am getting?

Starting kernel ...


Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33.6 (root@ubntu-desktop) (gcc version 4.2.2) #12 Mon Jul
26 18:39:19 IST 2010
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: SMDK2450
Ignoring unrecognised tag 0x00000000
Memory policy: ECC disabled, Data cache writeback
CPU S3C2450 EVT3 (id 0x32450003)
SPA   epll  80200102  Mpll  80640061   clkdiv0 557
S3C24XX Clocks, (c) 2004 Simtec Electronics
S3C2450: mpll on 800.000 MHz, cpu 400.000 MHz, mem 133.333 MHz, pclk 66.666
MHz
S3C2450: epll on 96.000 MHz, usb-bus 48.000 MHz
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: root=3D/dev/ram0 initrd=3D0x30800000,16M ramdisk=3D327=
68
init=3D/bin/sh console=3DttySAC3,115200 mem=3D64M
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB =3D 64MB total
Memory: 45432KB available (2588K code, 271K data, 116K init, 0K highmem)
Hierarchical RCU implementation.
NR_IRQS:109
irq: clearing subpending status 02000006
irq: clearing subpending status 02000002
timer tcon=3D00000000, tcnt 28af, tcfg 00000f00,00000000, usec 00007ae2
Console: colour dummy device 80x30
console [ttySAC3] enabled
Calibrating delay loop... 398.95 BogoMIPS (lpj=3D997376)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
whats up blady
hello
entered machine init
S3C Power Management, Copyright 2004 Simtec Electronics
S3C2450: Initialising architecture
SPA s3c2450_init
S3C2450: IRQ Support
bio: create slab <bio-0> at 0
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 16384K
NetWinder Floating Point Emulator V0.97 (double precision)
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
ROMFS MTD (C) 2007 Red Hat, Inc.
msgmni has been set to 120
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
brd: module loaded
loop: module loaded
Uniform Multi-Platform E-IDE driver
ide-gd driver 1.18
ide-cd driver 5.00
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
PPP MPPE Compression module registered
NET: Registered protocol family 24
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256).
CSLIP: code copyright 1989 Regents of the University of California.
mice: PS/2 mouse device common for all mice
TCP cubic registered
RAMDISK: gzip image found at block 0
EXT2-fs (ram0): warning: maximal mount count reached, running e2fsck is
recommended
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing init memory: 116K
Warning: unable to open an initial console.
Kernel panic - not syncing: Attempted to kill init!
[<c002b900>] (unwind_backtrace+0x0/0xe0) from [<c003fe9c>]
(panic+0x40/0x12c)
[<c003fe9c>] (panic+0x40/0x12c) from [<c0042cac>] (do_exit+0x58/0x57c)
[<c0042cac>] (do_exit+0x58/0x57c) from [<c0043254>]
(do_group_exit+0x84/0xb8)
[<c0043254>] (do_group_exit+0x84/0xb8) from [<c004329c>]
(sys_exit_group+0x14/0x20)
[<c004329c>] (sys_exit_group+0x14/0x20) from [<c0025e80>]
(ret_fast_syscall+0x0/0x28)


Regards

Nitin

--000e0cd185c245d449048c6a1039
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Hi <br><br>I am porting the 2.6.33.6 kernel,which i took from kernel.or=
g.I am trying to port it on samsung-s3c2451 board.<br>But i am not getting =
the shell prompt,due to getting the following error.Any body can tell due t=
o what this error i am getting?<br>

<br>Starting kernel ...<br><br><br>Uncompressing Linux... done, booting the=
 kernel.<br>Linux version 2.6.33.6 (root@ubntu-desktop) (gcc version 4.2.2)=
 #12 Mon Jul 26 18:39:19 IST 2010<br>CPU: ARM926EJ-S [41069265] revision 5 =
(ARMv5TEJ), cr=3D00053177<br>

CPU: VIVT data cache, VIVT instruction cache<br>Machine: SMDK2450<br>Ignori=
ng unrecognised tag 0x00000000<br>Memory policy: ECC disabled, Data cache w=
riteback<br>CPU S3C2450 EVT3 (id 0x32450003)<br>SPA=A0=A0 epll=A0 80200102=
=A0 Mpll=A0 80640061=A0=A0 clkdiv0 557 <br>

S3C24XX Clocks, (c) 2004 Simtec Electronics<br>S3C2450: mpll on 800.000 MHz=
, cpu 400.000 MHz, mem 133.333 MHz, pclk 66.666 MHz<br>S3C2450: epll on 96.=
000 MHz, usb-bus 48.000 MHz<br>Built 1 zonelists in Zone order, mobility gr=
ouping on.=A0 Total pages: 16256<br>

Kernel command line: root=3D/dev/ram0 initrd=3D0x30800000,16M ramdisk=3D327=
68 init=3D/bin/sh console=3DttySAC3,115200 mem=3D64M<br>PID hash table entr=
ies: 256 (order: -2, 1024 bytes)<br>Dentry cache hash table entries: 8192 (=
order: 3, 32768 bytes)<br>

Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)<br>Memory: 64M=
B =3D 64MB total<br>Memory: 45432KB available (2588K code, 271K data, 116K =
init, 0K highmem)<br>Hierarchical RCU implementation.<br>NR_IRQS:109<br>
irq: clearing subpending status 02000006<br>
irq: clearing subpending status 02000002<br>timer tcon=3D00000000, tcnt 28a=
f, tcfg 00000f00,00000000, usec 00007ae2<br>Console: colour dummy device 80=
x30<br>console [ttySAC3] enabled<br>Calibrating delay loop... 398.95 BogoMI=
PS (lpj=3D997376)<br>

Mount-cache hash table entries: 512<br>CPU: Testing write buffer coherency:=
 ok<br>NET: Registered protocol family 16<br>whats up blady <br>hello=A0 <b=
r>entered machine init <br>S3C Power Management, Copyright 2004 Simtec Elec=
tronics<br>

S3C2450: Initialising architecture<br>SPA s3c2450_init=A0 <br>S3C2450: IRQ =
Support<br>bio: create slab &lt;bio-0&gt; at 0<br>SCSI subsystem initialize=
d<br>NET: Registered protocol family 2<br>IP route cache hash table entries=
: 1024 (order: 0, 4096 bytes)<br>

TCP established hash table entries: 2048 (order: 2, 16384 bytes)<br>TCP bin=
d hash table entries: 2048 (order: 1, 8192 bytes)<br>TCP: Hash tables confi=
gured (established 2048 bind 2048)<br>TCP reno registered<br>UDP hash table=
 entries: 256 (order: 0, 4096 bytes)<br>

UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)<br>NET: Registered =
protocol family 1<br>Trying to unpack rootfs image as initramfs...<br>rootf=
s image is not initramfs (no cpio magic); looks like an initrd<br>Freeing i=
nitrd memory: 16384K<br>

NetWinder Floating Point Emulator V0.97 (double precision)<br>JFFS2 version=
 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.<br>ROMFS MTD (C) 2007 Red Hat, =
Inc.<br>msgmni has been set to 120<br>alg: No test for stdrng (krng)<br>Blo=
ck layer SCSI generic (bsg) driver version 0.4 loaded (major 254)<br>

io scheduler noop registered<br>io scheduler deadline registered<br>io sche=
duler cfq registered (default)<br>brd: module loaded<br>loop: module loaded=
<br>Uniform Multi-Platform E-IDE driver<br>ide-gd driver 1.18<br>ide-cd dri=
ver 5.00<br>

PPP generic driver version 2.4.2<br>PPP Deflate Compression module register=
ed<br>PPP BSD Compression module registered<br>PPP MPPE Compression module =
registered<br>NET: Registered protocol family 24<br>SLIP: version 0.8.4-NET=
3.019-NEWTTY (dynamic channels, max=3D256).<br>

CSLIP: code copyright 1989 Regents of the University of California.<br>mice=
: PS/2 mouse device common for all mice<br>TCP cubic registered<br>RAMDISK:=
 gzip image found at block 0<br>EXT2-fs (ram0): warning: maximal mount coun=
t reached, running e2fsck is recommended<br>

VFS: Mounted root (ext2 filesystem) on device 1:0.<br>Freeing init memory: =
116K<br>Warning: unable to open an initial console.<br>Kernel panic - not s=
yncing: Attempted to kill init!<br>[&lt;c002b900&gt;] (unwind_backtrace+0x0=
/0xe0) from [&lt;c003fe9c&gt;] (panic+0x40/0x12c)<br>

[&lt;c003fe9c&gt;] (panic+0x40/0x12c) from [&lt;c0042cac&gt;] (do_exit+0x58=
/0x57c)<br>[&lt;c0042cac&gt;] (do_exit+0x58/0x57c) from [&lt;c0043254&gt;] =
(do_group_exit+0x84/0xb8)<br>[&lt;c0043254&gt;] (do_group_exit+0x84/0xb8) f=
rom [&lt;c004329c&gt;] (sys_exit_group+0x14/0x20)<br>

[&lt;c004329c&gt;] (sys_exit_group+0x14/0x20) from [&lt;c0025e80&gt;] (ret_=
fast_syscall+0x0/0x28)<br><br><br>Regards<br><font color=3D"#888888"><br>Ni=
tin<br><br></font><br>

--000e0cd185c245d449048c6a1039--


--===============1207339533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1207339533==--
