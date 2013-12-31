From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [REGRESSION] 3.13-rc2: locks up hard on trying to transfer a file to mmc based internal SD card slot [FOUND]
Date: Tue, 31 Dec 2013 14:42:48 +0100
Message-ID: <1470750.49FZyOuFaa@merkaba>
References: <4578341.ZjSDW1Al5s@merkaba> <1675183.WJhkhxy1y0@merkaba> <6041244.1lSELMd6YL@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6041244.1lSELMd6YL@merkaba>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rt-users@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Am Dienstag, 31. Dezember 2013, 13:52:05 schrieb Martin Steigerwald:
> Am Dienstag, 31. Dezember 2013, 13:41:22 schrieb Martin Steigerwald:
> > Am Samstag, 30. November 2013, 14:53:51 schrieb Martin Steigerwald:
> > > Just added linux-mmc. And I might git-bisect that at some time, b=
ut I do
> > > not intend to do it during my precious weekend. The chances of me
> > > bisecting it increase with workable suggestions on how to cut dow=
n the
> > > amount of iterations needed and avoid testing highly experimental
> > > between
> > > 3.12 and 3.13-rc1 kernels on a production laptop. I may be willin=
g to
> > > test a patch or two. As I see there seem to have been quite some =
changes
> > > in MMC subsystem.
> > >=20
> > >=20
> > >=20
> > >=20
> > > Hi!
> > >=20
> > > Just does that on a ThinkPad T520 with:
> > >=20
> > > merkaba:~> lspci -nn | grep MMC
> > > 0d:00.0 System peripheral [0880]: Ricoh Co Ltd PCIe SDXC/MMC Host
> > > Controller [1180:e823] (rev 08)
> > >=20
> > > Mouse pointer freezes, no Ctrl-Alt-F1.
> >=20
> > It just does that with
> >=20
> > Linux version 3.13.0-rc6-tp520 (martin@merkaba) (gcc version 4.8.2 =
(Debian
> > 4.8.2-10) ) #41 SMP PREEMPT Mon Dec 30 13:39:07 CET 2013
> >=20
> > as well.
>=20
> I missed some important data. Kernel runs with threadirqs:
>=20
> merkaba:~> cat /proc/cmdline
> BOOT_IMAGE=3D/vmlinuz-3.12.6-tp520
> root=3DUUID=3D2f5c334d-249b-4c89-95cc-18572f750bd7 ro rootflags=3Dsub=
vol=3Droot
> resume=3D/dev/mapper/merkaba-swap threadirqs i915_enable_rc6=3D7
>=20
> Oh, and I see i915_enable_rc6=3D7. This always worked flawlessly. But=
 maybe
> this changed? Cause according to powertop the GPU never entered deepe=
r
> sleep states anyway. Maybe this now works (and thus may hang)?
>=20
> These are values on 3.12.6:
>                     |             GPU     |
>                     |=20
>                     | Powered On 96,3%    |
>                     | RC6         3,7%    |
>                     | RC6p        0,0%    |
>                     | RC6pp       0,0%    |
>=20
> I also attach kernel configs of non working 3.13-rc6 and working 3.12=
=2E6
> kernels.
>=20
> Its a ThinkPad T520 with Sandybridge:
>=20
> merkaba:~> lspci -nn | grep VGA
> 00:02.0 VGA compatible controller [0300]: Intel Corporation 2nd Gener=
ation
> Core Processor Family Integrated Graphics Controller [8086:0126] (rev=
 09)
>=20
> Debian kernel packages available. But well=E2=80=A6 optimized for Thi=
nkPad T520, may
> not run nicely otherwere.
>=20
>=20
> Please give suggestions on what to try next. Whats comes to mind is t=
ryining
> without rc6_enable option and then without threadirq option.
>=20
> Any other idea?

So there we go:

1) Without kernel options (except resume option) copying works in deskt=
op.

2) But then otherwise as I expected: With just "threadirqs" kernel opti=
on it=20
hangs. I would have suspected the "i915_enable_rc6" option instead.

3) But only when triggering copy via KDE desktop dolphin=C2=B4s file ma=
nager. I=20
tried copying on tty1 again and no hang there. Also again I/O seemed to=
 go on=20
after mouse pointer freeze (without Ctrl-Alt-F1) working. kwin ran in=20
compositing mode.

4) With just "i915_enable_rc6=3D7" it works. But since according to pow=
ertop=20
that option doesn=C2=B4t give me the benefit of doing into deeper GPU s=
leep states=20
anyway, I removed that one now as well.


So my laptop is on 3.13-rc6 now without any special options and I learn=
ed=20
again:

Never try to tune the kernel :)

And if still tuning it: First remove any kernel option when facing any =
issue.=20
Sorry for the noise that not adhering to this has caused.


This is second time that threadirqs option caused problems here. Thus C=
Cing=20
rt-users mailing list as well.

If wished I compile this all into a bugzilla.kernel.org bug report in a=
=20
concise format as well. But thats for another day :)

Have a good shift into new year if not already in it=E2=80=A6 otherwise=
 a happy new=20
year,
Martin


>=20
> Ciao,
> Martin
>=20
> > But, only when trying to write a file via desktop environment via d=
olphin
> > from KDE in that case. When I am on tty1 it seems to be stable to w=
rite to
> > the SD card. But with dolphin on writing a large few files vom /usr=
/bin
> > mouse pointer froze again. But according to harddisk led from Think=
Pad
> > T520
> > there has been some write activity afterwards. The LED also lits up=
 for
> > MMC
> > card accesses. Still after reboot there is none of the copied files
> > visible
> > on the FAT32 formatted SD card.
> >=20
> > Thus adding Intel gfx and dri devel lists to CC.
> >=20
> >=20
> > This crashing only under GUI might still be a coindidence. I only t=
ried
> > once. But since the crash usually came almost immediately and it di=
dn=C2=B4t
> > crash with reading or writing files on TTY1 and it somehow continue=
d I/O
> > according to harddisk led instead of seeming to be completely stopp=
ed=E2=80=A6
> > well
> > I can try again to make sure. Would be good to make it crash on TTY=
1 since
> > then I might see some kernel output.
> >=20
> >=20
> > Back to 3.12.6 for now. I just tried the same with that kernel and =
there
> > the copying just works nice.
> >=20
> > I can also report a bug at bugzilla.kernel.org if needed.
> >=20
> >=20
> > May comments about bisecting still applies. I do not feel comfortab=
le with
> > doing it on this production machine with production data on it=E2=80=
=A6 especially
> > given the major block layer changes. There may be points in history=
 were
> > the kernel produces data corruption or so.
> >=20
> > Thanks,
> > Martin
> >=20
> > > merkaba:~> fdisk -l /dev/mmcblk0
> > >=20
> > > Disk /dev/mmcblk0: 31.4 GB, 31439454208 bytes
> > > 255 heads, 63 sectors/track, 3822 cylinders, total 61405184 secto=
rs
> > > Units =3D sectors of 1 * 512 =3D 512 bytes
> > > Sector size (logical/physical): 512 bytes / 512 bytes
> > > I/O size (minimum/optimal): 512 bytes / 512 bytes
> > > Disk identifier: 0x00000000
> > >=20
> > >         Device Boot      Start         End      Blocks   Id  Syst=
em
> > >=20
> > > /dev/mmcblk0p1            8192    61405183    30698496    c  W95 =
=46AT32
> > > (LBA
> > >=20
> > >=20
> > > merkaba:/sys/block/mmcblk0#2> grep . * 2>/dev/null
> > > alignment_offset:0
> > > capability:10
> > > dev:179:0
> > > discard_alignment:0
> > > ext_range:8
> > > force_ro:0
> > > inflight:       0        0
> > > range:8
> > > removable:0
> > > ro:0
> > > size:61405184
> > > stat:     176       33     1672      102        0        0       =
 0
> > > 0 0      102      102
> > > uevent:MAJOR=3D179
> > > uevent:MINOR=3D0
> > > uevent:DEVNAME=3Dmmcblk0
> > > uevent:DEVTYPE=3Ddisk
> > >=20
> > >=20
> > > I do not want to take the time to diagnose this further, especial=
ly as
> > > its
> > > one of those nasty "I just lock up and I don=C2=B4t tell you what=
 went wrong"
> > > kind of bugs. Thats just not a nice way to tell that there has be=
en an
> > > error.
> > >=20
> > >=20
> > > If there is any five or ten minute information gathering task, I =
am
> > > willing
> > > to provide more information, but right now there is no chance on =
Earth
> > > that
> > > I will be bisecting while having a long list of more interesting =
things
> > > to
> > > do than that.
> > >=20
> > >=20
> > > Thus for now I just use 3.12 kernel again. Maybe I will try with =
some
> > > rc5
> > > or so again.
> > >=20
> > > Ciao,

--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
