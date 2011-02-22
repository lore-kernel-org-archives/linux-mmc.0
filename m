From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 17:15:07 +0100
Message-ID: <201102221715.07480.arnd@arndb.de>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com> <20110222085256.GA19871@S2100-06.ap.freescale.net> <20110222103349.GA2755@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62717 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab1BVQPh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 11:15:37 -0500
In-Reply-To: <20110222103349.GA2755@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

On Tuesday 22 February 2011, Wolfram Sang wrote:
> # mount -t vfat /dev/mmcblk0p1 /mnt
> # dd if=/mnt/test.dat of=/tmp/a bs=1024
> # umount /mnt
> # ./dd --version
> dd (coreutils) 8.5

In general, you should try to rule out file system, garbage collection,
partitioning and cache effects.

With coreutils dd, a good command is

dd if=/dev/zero of=/dev/mmcblk0 bs=64K count=64 seek=256 oflag=direct

* Always write multiples of 4 MB to avoid garbage collection
* smaller block sizes may be faster, so writing 64 times 64K may
  be better than writing 4 MB once, depending on the card
* don't write to the FAT area, so start writing at 16 MB into the
  device.
* use direct I/O to bypass the page cache.
* read from /dev/zero instead of a disk file to avoid measuring the
  wrong thing

	Arnd
