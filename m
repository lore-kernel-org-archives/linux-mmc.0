From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: adding aliases to mmc ... again
Date: Fri, 23 May 2014 11:23:59 +0200
Message-ID: <20140523092359.GG15686@pengutronix.de>
References: <1400772623-8390-1-git-send-email-s.hauer@pengutronix.de>
 <537E22E3.3010601@wwwdotorg.org>
 <20140522182134.GD15686@pengutronix.de>
 <537E4EAF.5000309@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52575 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbaEWJYD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 05:24:03 -0400
Content-Disposition: inline
In-Reply-To: <537E4EAF.5000309@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-mmc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Fabio Estevam <festevam@gmail.com>, ptx@pengutronix.de

On Thu, May 22, 2014 at 01:23:27PM -0600, Stephen Warren wrote:
> >> Does it solve the following, which AFAIK has always been the primary
> >> argument against aligning block device IDs with controller IDs:
> >>
> >> - User inserts SD card into MMC controller ID (or alias) 1.
> >> - /dev/mmcblk1 now exists
> >> - Mount /dev/mmcblk1 on /mnt/tmp
> >> - User removes that SD card
> >> - /dev/mmcblk1 still exists, since it's mounted so can't be deleted
> >> after the card removal.
> >> - User inserts SD card into MMC controller ID (or alias) 1.
> >> - /dev/mmcblkN (N is something other than 1) now exists
> >>
> >> Now, the block device ID must be != the original ID, since two block
> >> devices exist.
> > 
> > No, it shouldn't solve that, but it's out of scope for this patch. All
> > it solves is to reliably find the rootfs. If the card containing your
> > rootfs is removed you are in trouble anyway and it won't help if it gets
> > the same mmcblkno once it's plugged again. For other devices which don't
> > contain the rootfs there are enough possibilities to find them in userspace.
> 
> I don't think there should be any special cases for the root fs.
> 
> I don't think the disadvantage of the UUID= or PARTUUID= issue you
> mention enough is really an issue in general. If it is for some
> platform, then the root fs should be cryto-signed and validated to
> prevent someone from using the wrong root fs.

That argument came up here aswell. Crypto signing would prevent the Kernel
from starting the wrong userspace, but it would not start the correct one
either.
Crypto signing is quite a heavy approach for just making sure to boot from a
particular device.
Booting with UUID= is fine for several usecases, but I can't really
understand why it shouldn't be possible to point with the finger to the
bootdevice and just boot it. Instead we can just say "boot some device that
looks like this one".

Speaking of which my preferred solution is another one. As a bootloader
developer it really annoys me that I don't have the possibility to tell
the kernel to boot a particular device. What I really want to do is to
pass a devicetree phandle to the kernel for the rootfs (Or a device path
for the EFI/ACPI guys). This would solve a whole lot of problems here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
