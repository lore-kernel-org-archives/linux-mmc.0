From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: [REGRESSION] 3.13-rc2: locks up hard on trying to transfer a file to mmc based internal SD card slot
Date: Sat, 30 Nov 2013 14:53:51 +0100
Message-ID: <4578341.ZjSDW1Al5s@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Just added linux-mmc. And I might git-bisect that at some time, but I d=
o not=20
intend to do it during my precious weekend. The chances of me bisecting=
 it=20
increase with workable suggestions on how to cut down the amount of ite=
rations=20
needed and avoid testing highly experimental between 3.12 and 3.13-rc1 =
kernels=20
on a production laptop. I may be willing to test a patch or two. As I s=
ee=20
there seem to have been quite some changes in MMC subsystem.




Hi!

Just does that on a ThinkPad T520 with:

merkaba:~> lspci -nn | grep MMC
0d:00.0 System peripheral [0880]: Ricoh Co Ltd PCIe SDXC/MMC Host Contr=
oller=20
[1180:e823] (rev 08)

Mouse pointer freezes, no Ctrl-Alt-F1.


merkaba:~> fdisk -l /dev/mmcblk0

Disk /dev/mmcblk0: 31.4 GB, 31439454208 bytes
255 heads, 63 sectors/track, 3822 cylinders, total 61405184 sectors
Units =3D sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

        Device Boot      Start         End      Blocks   Id  System
/dev/mmcblk0p1            8192    61405183    30698496    c  W95 FAT32 =
(LBA


merkaba:/sys/block/mmcblk0#2> grep . * 2>/dev/null
alignment_offset:0
capability:10
dev:179:0
discard_alignment:0
ext_range:8
force_ro:0
inflight:       0        0
range:8
removable:0
ro:0
size:61405184
stat:     176       33     1672      102        0        0        0    =
    0       =20
0      102      102
uevent:MAJOR=3D179
uevent:MINOR=3D0
uevent:DEVNAME=3Dmmcblk0
uevent:DEVTYPE=3Ddisk


I do not want to take the time to diagnose this further, especially as =
its one=20
of those nasty "I just lock up and I don=B4t tell you what went wrong" =
kind of=20
bugs. Thats just not a nice way to tell that there has been an error.


If there is any five or ten minute information gathering task, I am wil=
ling to=20
provide more information, but right now there is no chance on Earth tha=
t I=20
will be bisecting while having a long list of more interesting things t=
o do=20
than that.


Thus for now I just use 3.12 kernel again. Maybe I will try with some r=
c5 or=20
so again.

Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
