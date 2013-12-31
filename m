From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [REGRESSION] 3.13-rc2: locks up hard on trying to transfer a file to mmc based internal SD card slot
Date: Tue, 31 Dec 2013 13:41:22 +0100
Message-ID: <1675183.WJhkhxy1y0@merkaba>
References: <4578341.ZjSDW1Al5s@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:42519 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab3LaMlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Dec 2013 07:41:37 -0500
In-Reply-To: <4578341.ZjSDW1Al5s@merkaba>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.orgintel-gfx@lists.freedesktop.org

Am Samstag, 30. November 2013, 14:53:51 schrieb Martin Steigerwald:
> Just added linux-mmc. And I might git-bisect that at some time, but I=
 do not
> intend to do it during my precious weekend. The chances of me bisecti=
ng it
> increase with workable suggestions on how to cut down the amount of
> iterations needed and avoid testing highly experimental between 3.12 =
and
> 3.13-rc1 kernels on a production laptop. I may be willing to test a p=
atch
> or two. As I see there seem to have been quite some changes in MMC
> subsystem.
>=20
>=20
>=20
>=20
> Hi!
>=20
> Just does that on a ThinkPad T520 with:
>=20
> merkaba:~> lspci -nn | grep MMC
> 0d:00.0 System peripheral [0880]: Ricoh Co Ltd PCIe SDXC/MMC Host Con=
troller
> [1180:e823] (rev 08)
>=20
> Mouse pointer freezes, no Ctrl-Alt-F1.

It just does that with

Linux version 3.13.0-rc6-tp520 (martin@merkaba) (gcc version 4.8.2 (Deb=
ian=20
4.8.2-10) ) #41 SMP PREEMPT Mon Dec 30 13:39:07 CET 2013

as well.

But, only when trying to write a file via desktop environment via dolph=
in from=20
KDE in that case. When I am on tty1 it seems to be stable to write to t=
he SD=20
card. But with dolphin on writing a large few files vom /usr/bin mouse =
pointer=20
froze again. But according to harddisk led from ThinkPad T520 there has=
 been=20
some write activity afterwards. The LED also lits up for MMC card acces=
ses.=20
Still after reboot there is none of the copied files visible on the FAT=
32=20
formatted SD card.

Thus adding Intel gfx and dri devel lists to CC.


This crashing only under GUI might still be a coindidence. I only tried=
 once.=20
But since the crash usually came almost immediately and it didn=C2=B4t =
crash with=20
reading or writing files on TTY1 and it somehow continued I/O according=
 to=20
harddisk led instead of seeming to be completely stopped=E2=80=A6 well =
I can try again=20
to make sure. Would be good to make it crash on TTY1 since then I might=
 see=20
some kernel output.


Back to 3.12.6 for now. I just tried the same with that kernel and ther=
e the=20
copying just works nice.

I can also report a bug at bugzilla.kernel.org if needed.


May comments about bisecting still applies. I do not feel comfortable w=
ith=20
doing it on this production machine with production data on it=E2=80=A6=
 especially=20
given the major block layer changes. There may be points in history wer=
e the=20
kernel produces data corruption or so.

Thanks,
Martin



>=20
>=20
> merkaba:~> fdisk -l /dev/mmcblk0
>=20
> Disk /dev/mmcblk0: 31.4 GB, 31439454208 bytes
> 255 heads, 63 sectors/track, 3822 cylinders, total 61405184 sectors
> Units =3D sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk identifier: 0x00000000
>=20
>         Device Boot      Start         End      Blocks   Id  System
> /dev/mmcblk0p1            8192    61405183    30698496    c  W95 FAT3=
2 (LBA
>=20
>=20
> merkaba:/sys/block/mmcblk0#2> grep . * 2>/dev/null
> alignment_offset:0
> capability:10
> dev:179:0
> discard_alignment:0
> ext_range:8
> force_ro:0
> inflight:       0        0
> range:8
> removable:0
> ro:0
> size:61405184
> stat:     176       33     1672      102        0        0        0  =
      0
> 0      102      102
> uevent:MAJOR=3D179
> uevent:MINOR=3D0
> uevent:DEVNAME=3Dmmcblk0
> uevent:DEVTYPE=3Ddisk
>=20
>=20
> I do not want to take the time to diagnose this further, especially a=
s its
> one of those nasty "I just lock up and I don=C2=B4t tell you what wen=
t wrong"
> kind of bugs. Thats just not a nice way to tell that there has been a=
n
> error.
>=20
>=20
> If there is any five or ten minute information gathering task, I am w=
illing
> to provide more information, but right now there is no chance on Eart=
h that
> I will be bisecting while having a long list of more interesting thin=
gs to
> do than that.
>=20
>=20
> Thus for now I just use 3.12 kernel again. Maybe I will try with some=
 rc5 or
> so again.
>=20
> Ciao,

--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
