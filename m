From: Angelo Dureghello <angelo70@gmail.com>
Subject: davinci_mmc issues on kernel 3.17.0
Date: Wed, 19 Nov 2014 15:32:45 +0100
Message-ID: <546CAA0D.3090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44281 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbaKSOcs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 09:32:48 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so1025995wgg.15
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 06:32:46 -0800 (PST)
Received: from [192.168.0.2] (host15-234-dynamic.54-79-r.retail.telecomitalia.it. [79.54.234.15])
        by mx.google.com with ESMTPSA id kn5sm2496542wjb.48.2014.11.19.06.32.45
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 06:32:46 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear all,

i am moving from a working 3.5.1 kernel to the 3.17.0.
My system is am1808 (ti arm) based, and i access a 4 data
wires microsd card.

mmc access is not working properly anymore on kernel
3.17.0

For example, trying a simple mkfs.ext3 on the mmc card, verifying
just after with fsck.ext3, i get several errors. Similarly, i get errors
if i use ext2, ext4 or fa.

See below:



|kernel 3.5.1

|
||
|[root@barix ~]# mkfs.ext3 /dev/mmcblk0p1 |
|mke2fs 1.42.4 (12-June-2012) |
|Filesystem label= |
|OS type: Linux |
|Block size=4096 (||log||=2) |
|Fragment size=4096 (||log||=2) |
|Stride=0 blocks, Stripe width=0 blocks |
|488640 inodes, 1952881 blocks |
|97644 blocks (5.00%) reserved ||for| |the super user |
|First data block=0 |
|Maximum filesystem blocks=2000683008 |
|60 block groups |
|32768 blocks per group, 32768 fragments per group |
|8144 inodes per group |
|Superblock backups stored on blocks: |
|||32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632 |
||
|Allocating group tables: done |
|Writing inode tables: done |
|Creating journal (32768 blocks): done |
|Writing superblocks and filesystem accounting information: done

** fsck now gives a clean state. **


|
||
|kernel 3.17.0 |
||
|
[root@barix ~]# mkfs.ext3 /dev/mmcblk0p1 |
|mke2fs 1.42.4 (12-June-2012) |
|Filesystem label= |
|OS type: Linux |
|Block size=4096 (||log||=2) |
|Fragment size=4096 (||log||=2) |
|Stride=0 blocks, Stripe width=0 blocks |
|240000 inodes, 959232 blocks |
|47961 blocks (5.00%) reserved ||for| |the super user |
|First data block=0 |
|Maximum filesystem blocks=985661440 |
|30 block groups |
|32768 blocks per group, 32768 fragments per group |
|8000 inodes per group |
|Superblock backups stored on blocks: |
|||32768, 98304, 163840, 229376, 294912, 819200, 884736 |
||
|Allocating group tables: done |
|Writing inode tables: done |
|Creating journal (16384 blocks): done |
|Writing superblocks and filesystem accounting information: done

||
[root@barix ~]# fsck.ext3 /dev/mmcblk0p1
e2fsck 1.42.4 (12-June-2012)
ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
fsck.ext3: Group descriptors look bad... trying backup blocks...
Superblock has an invalid journal (inode 8).
Clear<y>? Automount: /dev/mmcblk0p1 inserted
Automount: DEVICE LOCK found quiting...
yes
*** ext3 journal has been deleted - filesystem is now ext2 only ***

/dev/mmcblk0p1 was not cleanly unmounted, check forced.
Resize inode not valid.  Recreate<y>? yes
Pass 1: Checking inodes, blocks, and sizes
The bad block inode looks invalid.  Clear<y>? yes
Root inode is not a directory.  Clear<y>? yes
Inode 5 has EXTENTS_FL flag set on filesystem without extents support.
Clear<y>? yes
Inode 6 has EXTENTS_FL flag set on filesystem without extents support.
Clear<y>? yes
Inode 8 has EXTENTS_FL flag set on filesystem without extents support.
Clear<y>? yes
Inode 9 has EXTENTS_FL flag set on filesystem without extents support.
Clear<y>? yes
Inode 10 has EXTENTS_FL flag set on filesystem without extents support.
Clear<y>?
.... (continue)


I am suspecting of a mmc driver issue, or, something new to be set
from my board.c.

I also strangely see different inodes number, in kernel 3.5.1 are double.

hope in some help,

Regards,
angelo


|
