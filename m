From: Ming Lei <ming.lei@canonical.com>
Subject: Re: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
Date: Mon, 11 Jun 2012 15:20:22 +0800
Message-ID: <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
References: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
	<CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44901 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab2FKHUZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jun 2012 03:20:25 -0400
In-Reply-To: <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>

On Mon, Jun 11, 2012 at 2:21 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:
> Hi Ming Lei,
> Can you let me know if you noticed any write/timeout errors ?

Nothing error logs found during writing.

Below is one of my test case.

root@beagleboard:~# upk
updateing kernel...
flush storage...
root@beagleboard:~# cat bin/upk
#!/bin/sh

echo "updateing kernel..."
cp -f /mnt/nfs/t/uImage /media/mmcblk0p1/

echo "flush storage..."
sync
root@beagleboard:~# diff /mnt/nfs/t/uImage /media/mmcblk0p1/uImage
Binary files /mnt/nfs/t/uImage and /media/mmcblk0p1/uImage differ
root@beagleboard:~# umount /media/mmcblk0p1
root@beagleboard:~# mount -t vfat /dev/mmcblk0p1 /media/mmcblk0p1
root@beagleboard:~#
root@beagleboard:~#
root@beagleboard:~# diff /mnt/nfs/t/uImage /media/mmcblk0p1/uImage
Binary files /mnt/nfs/t/uImage and /media/mmcblk0p1/uImage differ


Thanks,
--
Ming Lei
