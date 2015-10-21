From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Wed, 21 Oct 2015 14:02:26 +0200
Message-ID: <CAPDyKFomPVogHwHe7pBTUptW=Ge8nrUeE_DXP4Na8k1UsXxcLQ@mail.gmail.com>
References: <CAJBHPohRA7T573AaZa2sMbyQspaV3KnUWNHcmVM5HzDh+xszYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37932 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbbJUMC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 08:02:28 -0400
Received: by wicll6 with SMTP id ll6so70836838wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 05:02:26 -0700 (PDT)
In-Reply-To: <CAJBHPohRA7T573AaZa2sMbyQspaV3KnUWNHcmVM5HzDh+xszYw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcus Overhagen <marcus.overhagen@gmail.com>, Roger Tseng <rogerable@realtek.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-usb@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>

On 20 October 2015 at 18:29, Marcus Overhagen
<marcus.overhagen@gmail.com> wrote:
> I tested again with a 4.2 kernel but the bug is still present and
> happens more often. So far nobody has responded.
> I don't know what to do, and whether it's related to usb, mmc or mfd.
> Please advise.

Sorry for the delay. I was hoping to get some input from Roger as me
personally don't know much about this HW.
I can't tell whether this is a regression or not. The rtsx_usb driver
were added in Linux 3.16. Perhaps you can verify if this is a
regression or not!?

>
> When using the RTS5129 card reader (USB2 but internal to Samsung
> NP7230U3E series 7 ultrabook) and a Samsung 128 GB SDXC microsd the
> data that is read or written is always corrupted.

Have you tried other SDXC cards which supports the "ultra high speed
SDR50" mode? BTW, the speed mode is logged when the card is detected.

> A 32 GB SDHC does not show data corruption with this card reader.

As I don't know the HW, I can just provide some guesses of how to
narrow down the problem.

If you re-build the kernel and make changes around which MMC_CAPS the
host supports, you can try to narrow down the problem if it's related
to speed modes.

=46or example start by using *only* the following MMC_CAPS (updates to
be made in rtsx_usb_init_host() - drivers/mmc/host/rtsx_usb.c):

MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED | MMC_CAP_NEEDS_POLL

=2E.and if no error, try add cap by cap to see what happens.

Sorry, not being able to help you more - but at least this is a start!

Kind regards
Uffe

>
> [root@goetterdaemmerung f3-5.0]# uname -a
> Linux goetterdaemmerung 4.2.3-1-ARCH #1 SMP PREEMPT Sat Oct 3 18:52:5=
0
> CEST 2015 x86_64 GNU/Linux
> [root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 1752476/   279302/      9/  65365
> Validating file 2.h2w ... 1755153/   164013/      7/ 177979
> Validating file 3.h2w ... 1751003/   126213/     16/ 219920
> Validating file 4.h2w ...  123986/    15442/      0/  12348^C
> [root@goetterdaemmerung f3-5.0]#
>
> many errors logged, but always the same:
>
> [39143.853105] mmc0: new ultra high speed SDR50 SDXC card at address =
59b4
> [39143.860019] mmcblk0: mmc0:59b4 00000 119 GiB
> [39143.862649]  mmcblk0: p1
> [39144.654751] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39145.322333] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39161.533429] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39174.344246] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39174.961629] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39175.602352] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39176.229774] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39176.853664] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39177.468247] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39178.071814] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39178.672414] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39179.279727] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [39179.890435] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
>
> regards
> Marcus
>
> ---------- Forwarded message ----------
> From: Marcus Overhagen <marcus.overhagen@gmail.com>
> Date: Mon, Sep 28, 2015 at 9:42 PM
> Subject: Fwd: Data corruption with RTS5129 card reader and 128 GB SDX=
C microsd
> To: kernel list <linux-kernel@vger.kernel.org>
> Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
>
>
> Can somebody help me with this issue? Linux is corrupting data when
> using the SD card reader!
>
> I already sent it to linux-mmc on September 11th, and on September
> 17th forwarded it to Roger Tseng (author of rtsx_usb) and Samuel Orti=
z
> (maintainer of MFD) but have received no response,
>
> ---------- Forwarded message ----------
> From: Marcus Overhagen <marcus.overhagen@gmail.com>
> Date: Fri, Sep 11, 2015 at 3:26 PM
> Subject: Data corruption with RTS5129 card reader and 128 GB SDXC mic=
rosd
> To: linux-mmc@vger.kernel.org
>
>
> I have a data corruption problem with RTS5129 sd card reader and a
> 128GB Samsung EVO microsd.
>
> This is not a fake card, its tested ok with H2testw in another window=
s machine.
> The card also works when I put it in an external microSD=3D>USB card =
reader.
>
> Previously I was using a 32 GB Sandisk Ultra microsd UHS-I without
> noticing any issues.
> With the 128GB card, playback of dashcam videos shows many broken
> frames, but is ok when using external card reader.
>
> A test with F3 software shows "overwritten" sectors, I think in this
> case they indicate that the wrong sector is read.
>
> Bus 003 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129
> Card Reader Controller
>
> [root@goetterdaemmerung marcus]# uname -a
> Linux goetterdaemmerung 4.1.6-1-ARCH #1 SMP PREEMPT Mon Aug 17
> 08:52:28 CEST 2015 x86_64 GNU/Linux
>
> [    1.033568] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.033575] xhci_hcd 0000:00:14.0: new USB bus registered, assigne=
d
> bus number 3
> [    1.033673] xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci
> version 0x100 quirks 0x0000b930
> [    1.033682] xhci_hcd 0000:00:14.0: cache line size of 64 is not su=
pported
> [    1.033931] hub 3-0:1.0: USB hub found
>
> [    1.393530] usb 3-3: new high-speed USB device number 2 using xhci=
_hcd
> [    1.451468] hub 1-1:1.0: USB hub found
> [    1.451580] hub 1-1:1.0: 6 ports detected
> [    1.464698] hub 2-1:1.0: USB hub found
> [    1.464847] hub 2-1:1.0: 6 ports detected
> [    1.572914] usbcore: registered new interface driver rtsx_usb
>
> [67697.876276] mmc0: new ultra high speed SDR50 SDXC card at address =
59b4
> [67697.876720] mmcblk0: mmc0:59b4 00000 119 GiB
> [67697.881189]  mmcblk0: p1
>
> some errors are loggged during card access:
>
> [68223.345521] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [68224.446561] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
> [68247.455199] mmcblk0: error -110 sending stop command, original cmd
> response 0x900, card status 0x900
>
> read test errors:
>
> [root@goetterdaemmerung f3-5.0]# mount /dev/mmcblk0p1 /mnt/dashcam1/
> FUSE exfat 1.1.0
> [root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2096266/      184/      0/    702
> Validating file 2.h2w ... 2096567/        2/      0/    583
> Validating file 3.h2w ... 2097151/        1/      0/      0
> Validating file 4.h2w ...  213984/        0/      0/      0^C
>
> after unmounting and mounting it again, the result is different:
>
> FUSE exfat 1.1.0
> [root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2096546/      370/      0/    236
> Validating file 2.h2w ... 2096074/        6/      0/   1072
> Validating file 3.h2w ... 2095924/      252/      0/    976
> Validating file 4.h2w ... 1295451/        0/      0/    901^C
>
> I got the impression yesterday that writing to the card results in
> much more errors.
> Thus today for this tests, data on the card was written with the othe=
r
> windows machine and is 100% correct.
>
> What can I do? What other information should I provide?
>
> For comparision, this is the working external sd-card=3D>USB hardware=
 :
>
> Bus 003 Device 011: ID aaaa:8816 MXT
> or
> Bus 003 Device 014: ID 0781:b7b1 SanDisk Corp.
>
> [64645.868255] usb 3-4: new high-speed USB device number 15 using xhc=
i_hcd
> [64646.057349] usb-storage 3-4:1.0: USB Mass Storage device detected
> [64646.057594] scsi host14: usb-storage 3-4:1.0
> [64647.060934] scsi 14:0:0:0: Direct-Access     Generic  STORAGE
> DEVICE   9407 PQ: 0 ANSI: 0
> [64647.682113] sd 14:0:0:0: [sdb] 251131904 512-byte logical blocks:
> (128 GB/119 GiB)
> [64647.682986] sd 14:0:0:0: [sdb] Write Protect is off
> [64647.682993] sd 14:0:0:0: [sdb] Mode Sense: 03 00 00 00
> [64647.683957] sd 14:0:0:0: [sdb] No Caching mode page found
> [64647.683966] sd 14:0:0:0: [sdb] Assuming drive cache: write through
> [64647.690645]  sdb: sdb1
> [64647.693784] sd 14:0:0:0: [sdb] Attached SCSI removable disk
>
> [root@goetterdaemmerung f3-5.0]# mount /dev/sdb1 /mnt/dashcam1/
> FUSE exfat 1.1.0
> [root@goetterdaemmerung f3-5.0]# ./f3read /mnt/dashcam1/
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097152/        0/      0/      0
> Validating file 2.h2w ... 2097152/        0/      0/      0
> Validating file 3.h2w ... 2097152/        0/      0/      0
> Validating file 4.h2w ... 2097152/        0/      0/      0
> Validating file 5.h2w ... 2097152/        0/      0/      0
> Validating file 6.h2w ... 2097152/        0/      0/      0
> Validating file 7.h2w ... 2097152/        0/      0/      0
> Validating file 8.h2w ... 2097152/        0/      0/      0
> Validating file 9.h2w ... 2097152/        0/      0/      0
> Validating file 10.h2w ... 2097152/        0/      0/      0
> Validating file 11.h2w ... 1080288/        0/      0/      0^C
> [root@goetterdaemmerung f3-5.0]#
>
> And this is when I tested the microSD card with another machine using
> H2testw in windows and it's ok:
>
>> Achtung: Nur 122590 von 122591 MByte getestet.
>> Fertig, kein Fehler aufgetreten.
>> Sie k=C3=B6nnen die Testdateien *.h2w jetzt l=C3=B6schen oder nach B=
elieben
>> nochmals =C3=BCberpr=C3=BCfen.
>> Schreibrate: 18,6 MByte/s
>> Leserate: 41,3 MByte/s
>> H2testw v1.4
>
> regards
> Marcus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
