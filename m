From: Neeraj Jakhar <neeraj@fusiontoad.com>
Subject: Regarding SD card
Date: Sat, 15 Dec 2012 03:56:16 +0530
Message-ID: <CAPv8OKS061mNcpL1y_x7U9D+BDv8fjFYP5CmOsH+RMDWZGrXBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:32941 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab2LNW0R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 17:26:17 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so4795787vcd.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 14:26:16 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I have with me a bunch of "raw" Micro SD Cards (which I got
from a friend of my friend). Their capacity as reported by
Linux/Windows is around 30 MB. Further, most of the fields in
their CID and CSD register are empty. For example,  the
following values are set, Manufacturer ID: 0x00 ;
OEM/Application ID: 0x2020 (or "  "); Product name:
0x4e2f412020 (or "N/A  "). The CSD structure version is set
to 1 (which means SDSC card).

I am told that these Micro SD cards are actually SDHC cards
(anything between 4 GB - 32 GB). They are in pre-release state
and a process called "upgrade" will make them realize their
actual capacity, as noted in the previous statement instead of
its current 30 MB. From what I have gathered from the
documentation I need to modify C_SIZE, C_SIZE_MULT,
READ_BL_LEN (from SD card specifications) to change
the size of SD card.

However, before trying to modify these values, I tried the
following command

dd if=/dev/zero of=/dev/mmcblk0

I expected that the whole disk will be written with zeros, and I
can always use fdisk and mkfs to recreate the file system.

However, I got a big surprise. When I open drive in fdisk and
create partitions and save the partition table to the disk, nothing
gets saved to the SD card. The device can't be formatted on windows
either. Moreover, I created image of MBR, of another such raw
SD card using the command,

dd if=/dev/mmcblk0 of=mbr bs=512 count=1

and wrote it to the erring SD card using the command,

dd if=mbr of=/dev/mmcblk0 bs=512 count=1

At this point I expected that at least partition table should be
restored. But all this was to no avail. Moreover, a similar
effort with a disk image of entire SD card (instead of just the
initial 512 bytes) yielded no better results. From a look at the
contents it would appear that no matter what I write to this SD
card, its contents remain the same, and at the same time their
is no error that is reported by the dd command. In the dmesg
logs I can see the following output:

[13534.411447] mmc0: new SD card at address 0002
[13534.411709] mmcblk0: mmc0:0002 N/A   30.0 MiB
[13534.413899]  mmcblk0: unknown partition table
[13543.088097] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x580900
[13543.088152] mmcblk0: error -110 transferring data, sector 0, nr 8,
cmd response 0x900, card status 0x0
[13543.088252] end_request: I/O error, dev mmcblk0, sector 1
[13543.088257] Buffer I/O error on device mmcblk0, logical block 0
[13543.088259] lost page write due to I/O error on mmcblk0



Can somebody help me understand two things:

1) Why is dd not able to write to the SD card?
2) Is there such a thing as "upgrade" process during
manufacture of cards? If yes, how can I achieve the same
in Linux? Please forgive me if this question does not belong
to this mailing list.

Thanks for a patient read.
-N
