From: vadivelan mani <vadivelan.mani@toshiba-tsip.com>
Subject: eMMC write error in IMX6 Sabre AI board
Date: Fri, 7 Nov 2014 11:35:51 +0000 (UTC)
Message-ID: <loom.20141107T122543-102@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59854 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbaKGLkI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Nov 2014 06:40:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Xmhtc-0002qs-Mp
	for linux-mmc@vger.kernel.org; Fri, 07 Nov 2014 12:40:04 +0100
Received: from 202.56.254.194 ([202.56.254.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 07 Nov 2014 12:40:04 +0100
Received: from vadivelan.mani by 202.56.254.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Fri, 07 Nov 2014 12:40:04 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear all,
     I'm facing this unique problem during emmc write operation. I'm using a
Toshiba emmc device on Sabre AI board and linux kernel version 3.0.35.

The write operation is successful when i disable multi-block read/write.
But when multi block read/write is enabled, the writes fail for data of size
above 12KBytes. Please find the logs below for your reference. Any data
write upto 12KB, there is no problem. The error message is a data crc error
which i'm unable to figure why it is occuring.

===========================================================================
Data size <= 12KB - SUCCESS
-------------------
===========================================================================
root@freescale ~$ dd if=/file of=/dev/mmcblk0 bs=1024 count=12

mmc0: starting CMD18 arg 00000000 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f80000

mmc0: starting CMD18 arg 00000008 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f80000

mmc0: starting CMD18 arg 00000010 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f80000

mmc0: starting CMD25 arg 00000000 flags 000000b5

mmc0:     blksz 512 blocks 24 flags 00000100 tsac 800 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 24
 Block size 29184
 Block size 7
=========> transfer_ mode 0x23
=============> flags 0x3a, cmd 25
 intmask 0x8

 Address after failure 0x74f80000
 intmask 0x2
 Address after failure 0x74f80000

mmc0: starting CMD13 arg 00010000 flags 00000195

===========host flags 0x5
--------------- ACMD23
=============> flags 0x1a, cmd 13
12+0 records in
12+0 records out
12288 bytes (12.0KB) copied, 0.178464 seconds, 67.2KB/s

============================================================================
Data size > 12KB - FAIL
-----------------
============================================================================

root@freescale ~$ dd if=/file of=/dev/mmcblk0 bs=1024 count=15

mmc0: starting CMD18 arg 00000000 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f00000

mmc0: starting CMD18 arg 00000008 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f00000

mmc0: starting CMD18 arg 00000010 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f00000

mmc0: starting CMD18 arg 00000018 flags 000000b5

mmc0:     blksz 512 blocks 8 flags 00000200 tsac 50 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 8
 Block size 29184
 Block size 7
=========> transfer_ mode 0x33
=============> flags 0x3a, cmd 18
 intmask 0xa

 Address after failure 0x74f00000

mmc0: starting CMD25 arg 00000000 flags 000000b5

mmc0:     blksz 512 blocks 32 flags 00000100 tsac 800 ms nsac 0

mmc0:     CMD12 arg 00000000 flags 0000049d

===========host flags 0x5
=============> flags 0x1a, cmd 23
--------------- Not ACMD23
 data Block size 0 512
 Block count 32
 Block size 29184
 Block size 7
=========> transfer_ mode 0x23
=============> flags 0x3a, cmd 25
 intmask 0x200002
============> need to send cmd12
=============> flags 0x1b, cmd 12
 Address after failure 0x0

mmc0: starting CMD13 arg 00010000 flags 00000195

===========host flags 0x5
--------------- ACMD23
=============> flags 0x1a, cmd 13
mmcblk0: error -84 transferring data, sector 0, nr 32, cmd response 0x900,
card status 0xc00
end_request: I/O error, dev mmcblk0, sector 0
Buffer I/O error on device mmcblk0, logical block 0
lost page write due to I/O error on mmcblk0
end_request: I/O error, dev mmcblk0, sector 8
Buffer I/O error on device mmcblk0, logical block 1
lost page write due to I/O error on mmcblk0
end_request: I/O error, dev mmcblk0, sector 16
Buffer I/O error on device mmcblk0, logical block 2
lost page write due to I/O error on mmcblk0
end_request: I/O error, dev mmcblk0, sector 24
Buffer I/O error on device mmcblk0, logical block 3
lost page write due to I/O error on mmcblk0
15+0 records in
15+0 records out
15360 bytes (15.0KB) copied, 0.277967 seconds, 54.0KB/s

Please provide your valuable inputs for the same.


