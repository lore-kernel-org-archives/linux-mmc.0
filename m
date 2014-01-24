From: John Tobias <john.tobias.ph@gmail.com>
Subject: iMX6SL Suspend mode (S3)
Date: Fri, 24 Jan 2014 13:14:08 -0800
Message-ID: <CACUGKYMxozVYUZ1neX9iRqRoaTCTOOY8VV92UAtcwUa_1f0XSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:49699 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbaAXVOK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2014 16:14:10 -0500
Received: by mail-la0-f44.google.com with SMTP id hm7so2976413lab.17
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jan 2014 13:14:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Dong Aisheng <b29396@freescale.com>, Fabio Estevam <festevam@gmail.com>, "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>

Hello all,

I am testing the suspend mode (S3) for my custom board with iMX6SL and
the iMX6SL EVK as well. I am using 3.13 kernel, eMMC and MMC for the
storage and systemd to control the OS. If I put my device in S3 mode,
I got the following messages:

[   27.949393] PM: Syncing filesystems ... done.
[   27.972392] mmc0: card 0001 removed
[   28.033613] end_request: I/O error, dev mmcblk0, sector 0
[   28.063493] end_request: I/O error, dev mmcblk0, sector 0
[   28.107933] end_request: I/O error, dev mmcblk0, sector 0
[   28.131456] end_request: I/O error, dev mmcblk0, sector 0
[   28.153651] end_request: I/O error, dev mmcblk0, sector 0
[   28.215530] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   28.224284] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   28.233658] Suspending console(s) (use no_console_suspend to debug)

If I press any key, it will wake up. But, I got the following errors:

[   17.815008] mmc0: new high speed DDR MMC card at address 0001
[   17.828024] mmcblk0: mmc0:0001 SEM04G 3.68 GiB
[   17.833522] mmcblk0boot0: mmc0:0001 SEM04G partition 1 2.00 MiB
[   17.839699] mmcblk0boot1: mmc0:0001 SEM04G partition 2 2.00 MiB
[   17.847150] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 2.00 MiB
[   17.860116]  mmcblk0: p1 p2 p3 p4 < p5 p6 >
[   17.883550]  mmcblk0boot1: unknown partition table
[   17.899549]  mmcblk0boot0: unknown partition table
[   17.959186] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.126790] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.173370] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.207744] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.316736] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.448542] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.496749] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.530178] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.575861] EXT4-fs error (device mmcblk0p2):
__ext4_get_inode_loc:3909: inode #33300: block 131267: comm systemd:
unable to read itable block
[   18.660139] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:908: error reading directory block (ino 33142,
block 0)
[   18.717386] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 2001,
block 0)
[   18.830148] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:908: error reading directory block (ino 33135,
block 0)
[   19.045944] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 32928,
block 0)
[   19.058510] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 32928,
block 0)
[   19.071681] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 90, block
0)
[   19.083810] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 90, block
0)
[   19.097369] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 2001,
block 0)
[   19.110210] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 2001,
block 0)
[   19.153687] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 2001,
block 0)
[   29.800522] EXT4-fs warning: 1 callbacks suppressed
[   29.805425] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 2001,
block 0)
[   29.842343] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 90, block
0)
[   29.875698] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 32928,
block 0)
[   29.906757] EXT4-fs warning (device mmcblk0p2):
__ext4_read_dirblock:681: error reading directory block (ino 90, block
0)

Regards,

john
