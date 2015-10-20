From: Marcus Overhagen <marcus.overhagen@gmail.com>
Subject: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Tue, 20 Oct 2015 18:29:18 +0200
Message-ID: <CAJBHPohRA7T573AaZa2sMbyQspaV3KnUWNHcmVM5HzDh+xszYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Roger Tseng <rogerable@realtek.com>
List-Id: linux-mmc@vger.kernel.org

I tested again with a 4.2 kernel but the bug is still present and
happens more often. So far nobody has responded.
I don't know what to do, and whether it's related to usb, mmc or mfd.
Please advise.

When using the RTS5129 card reader (USB2 but internal to Samsung
NP7230U3E series 7 ultrabook) and a Samsung 128 GB SDXC microsd the
data that is read or written is always corrupted.
A 32 GB SDHC does not show data corruption with this card reader.

[root@goetterdaemmerung f3-5.0]# uname -a
Linux goetterdaemmerung 4.2.3-1-ARCH #1 SMP PREEMPT Sat Oct 3 18:52:50
CEST 2015 x86_64 GNU/Linux
[root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 1752476/   279302/      9/  65365
Validating file 2.h2w ... 1755153/   164013/      7/ 177979
Validating file 3.h2w ... 1751003/   126213/     16/ 219920
Validating file 4.h2w ...  123986/    15442/      0/  12348^C
[root@goetterdaemmerung f3-5.0]#

many errors logged, but always the same:

[39143.853105] mmc0: new ultra high speed SDR50 SDXC card at address 59=
b4
[39143.860019] mmcblk0: mmc0:59b4 00000 119 GiB
[39143.862649]  mmcblk0: p1
[39144.654751] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39145.322333] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39161.533429] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39174.344246] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39174.961629] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39175.602352] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39176.229774] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39176.853664] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39177.468247] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39178.071814] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39178.672414] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39179.279727] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[39179.890435] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900

regards
Marcus

---------- Forwarded message ----------
=46rom: Marcus Overhagen <marcus.overhagen@gmail.com>
Date: Mon, Sep 28, 2015 at 9:42 PM
Subject: Fwd: Data corruption with RTS5129 card reader and 128 GB SDXC =
microsd
To: kernel list <linux-kernel@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>


Can somebody help me with this issue? Linux is corrupting data when
using the SD card reader!

I already sent it to linux-mmc on September 11th, and on September
17th forwarded it to Roger Tseng (author of rtsx_usb) and Samuel Ortiz
(maintainer of MFD) but have received no response,

---------- Forwarded message ----------
=46rom: Marcus Overhagen <marcus.overhagen@gmail.com>
Date: Fri, Sep 11, 2015 at 3:26 PM
Subject: Data corruption with RTS5129 card reader and 128 GB SDXC micro=
sd
To: linux-mmc@vger.kernel.org


I have a data corruption problem with RTS5129 sd card reader and a
128GB Samsung EVO microsd.

This is not a fake card, its tested ok with H2testw in another windows =
machine.
The card also works when I put it in an external microSD=3D>USB card re=
ader.

Previously I was using a 32 GB Sandisk Ultra microsd UHS-I without
noticing any issues.
With the 128GB card, playback of dashcam videos shows many broken
frames, but is ok when using external card reader.

A test with F3 software shows "overwritten" sectors, I think in this
case they indicate that the wrong sector is read.

Bus 003 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129
Card Reader Controller

[root@goetterdaemmerung marcus]# uname -a
Linux goetterdaemmerung 4.1.6-1-ARCH #1 SMP PREEMPT Mon Aug 17
08:52:28 CEST 2015 x86_64 GNU/Linux

[    1.033568] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.033575] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 3
[    1.033673] xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci
version 0x100 quirks 0x0000b930
[    1.033682] xhci_hcd 0000:00:14.0: cache line size of 64 is not supp=
orted
[    1.033931] hub 3-0:1.0: USB hub found

[    1.393530] usb 3-3: new high-speed USB device number 2 using xhci_h=
cd
[    1.451468] hub 1-1:1.0: USB hub found
[    1.451580] hub 1-1:1.0: 6 ports detected
[    1.464698] hub 2-1:1.0: USB hub found
[    1.464847] hub 2-1:1.0: 6 ports detected
[    1.572914] usbcore: registered new interface driver rtsx_usb

[67697.876276] mmc0: new ultra high speed SDR50 SDXC card at address 59=
b4
[67697.876720] mmcblk0: mmc0:59b4 00000 119 GiB
[67697.881189]  mmcblk0: p1

some errors are loggged during card access:

[68223.345521] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[68224.446561] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900
[68247.455199] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900

read test errors:

[root@goetterdaemmerung f3-5.0]# mount /dev/mmcblk0p1 /mnt/dashcam1/
=46USE exfat 1.1.0
[root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 2096266/      184/      0/    702
Validating file 2.h2w ... 2096567/        2/      0/    583
Validating file 3.h2w ... 2097151/        1/      0/      0
Validating file 4.h2w ...  213984/        0/      0/      0^C

after unmounting and mounting it again, the result is different:

=46USE exfat 1.1.0
[root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 2096546/      370/      0/    236
Validating file 2.h2w ... 2096074/        6/      0/   1072
Validating file 3.h2w ... 2095924/      252/      0/    976
Validating file 4.h2w ... 1295451/        0/      0/    901^C

I got the impression yesterday that writing to the card results in
much more errors.
Thus today for this tests, data on the card was written with the other
windows machine and is 100% correct.

What can I do? What other information should I provide?

=46or comparision, this is the working external sd-card=3D>USB hardware=
 :

Bus 003 Device 011: ID aaaa:8816 MXT
or
Bus 003 Device 014: ID 0781:b7b1 SanDisk Corp.

[64645.868255] usb 3-4: new high-speed USB device number 15 using xhci_=
hcd
[64646.057349] usb-storage 3-4:1.0: USB Mass Storage device detected
[64646.057594] scsi host14: usb-storage 3-4:1.0
[64647.060934] scsi 14:0:0:0: Direct-Access     Generic  STORAGE
DEVICE   9407 PQ: 0 ANSI: 0
[64647.682113] sd 14:0:0:0: [sdb] 251131904 512-byte logical blocks:
(128 GB/119 GiB)
[64647.682986] sd 14:0:0:0: [sdb] Write Protect is off
[64647.682993] sd 14:0:0:0: [sdb] Mode Sense: 03 00 00 00
[64647.683957] sd 14:0:0:0: [sdb] No Caching mode page found
[64647.683966] sd 14:0:0:0: [sdb] Assuming drive cache: write through
[64647.690645]  sdb: sdb1
[64647.693784] sd 14:0:0:0: [sdb] Attached SCSI removable disk

[root@goetterdaemmerung f3-5.0]# mount /dev/sdb1 /mnt/dashcam1/
=46USE exfat 1.1.0
[root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 2097152/        0/      0/      0
Validating file 2.h2w ... 2097152/        0/      0/      0
Validating file 3.h2w ... 2097152/        0/      0/      0
Validating file 4.h2w ... 2097152/        0/      0/      0
Validating file 5.h2w ... 2097152/        0/      0/      0
Validating file 6.h2w ... 2097152/        0/      0/      0
Validating file 7.h2w ... 2097152/        0/      0/      0
Validating file 8.h2w ... 2097152/        0/      0/      0
Validating file 9.h2w ... 2097152/        0/      0/      0
Validating file 10.h2w ... 2097152/        0/      0/      0
Validating file 11.h2w ... 1080288/        0/      0/      0^C
[root@goetterdaemmerung f3-5.0]#

And this is when I tested the microSD card with another machine using
H2testw in windows and it's ok:

> Achtung: Nur 122590 von 122591 MByte getestet.
> Fertig, kein Fehler aufgetreten.
> Sie k=C3=B6nnen die Testdateien *.h2w jetzt l=C3=B6schen oder nach Be=
lieben
> nochmals =C3=BCberpr=C3=BCfen.
> Schreibrate: 18,6 MByte/s
> Leserate: 41,3 MByte/s
> H2testw v1.4

regards
Marcus
