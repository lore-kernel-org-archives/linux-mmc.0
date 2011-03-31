From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 13:17:21 +0200
Message-ID: <201103311317.22110.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <201103301403.20779.arnd@arndb.de> <AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54304 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab1CaLRf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 07:17:35 -0400
In-Reply-To: <AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Wednesday 30 March 2011, Andrei Warkentin wrote:
> On Wed, Mar 30, 2011 at 7:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Since eMMC 4.41, you can create "general purpose" partitions (up to
> 4), which will be carved out of the user partition, and can be used in
> any way possible, thus potentially holding file system partitions.

My feeling is that these should be separate from the boot partition.
It could probably be done using a new fs/partitions/mmc.c file
that directly interacts with the mmc layer instead of looking
at the MS-DOS master boot record. That way, you could define the
same partitions (mmcblk0p1, ...) using a different method.

It also requires a user interface that a new mmc-fdisk tool
can talk to, in order to modify the partition table, not sure
if it's possible to use the BLKPG ioctl for this.
 
> There is also the "Replay Protected Memory Block" device partition,
> which is not able to host a file system in the normal sense (because
> layer over the MMC block transfer protocol is a "replay protected
> transaction" protocol, which could be used by a user-mode application
> directly reading/writing from /dev/block/mmcblkXXX).

Ok. That sounds like a use case for an ioctl interface then, if
we even want to expose it.
 
> > * What devices specifically have these new partitions? Only eMMC 4.4
> >  or also other versions?
> >
> 
> Boot partitions are available in 4.3. The other ones (4 general
> purpose ones, rpmb since 4.41).
 
ok.

> Unfortunately, since the SD spec is proprietary, I have no way of
> confirming whether the SD device partitioning (AFAIK there is a
> concept of boot partitions for eSD) works the same way or not, so I
> was maximally safe in supporting MMC device partitioning.

The public parts of the SD standard specifically require MS-DOS
partitioning to be used, so I assume that there is no internal
method in addition. They also describe the presence of a "secure
area" that can only be accessed after authentication. This could
use a similar method as the boot partition, but it's unclear to
me whether that is something that anyone is interested in.

> > * How does a user identify which hardware partition corresponds to
> >  a given block device and vice versa?
> 
> Right now, you would just need to know. With postfixes like
> mmcblk0b0/mmcblk0g0 you would be able to tell the device partitions
> apart from the main mmcblk0.

Regarding the naming, I would not use a trailing zero, but it's probably
a subjective thing. The other names I could imagine for the boot partition
of mmc 0 are mmcboot0, mmcblk0b or mmcblk0boot.

I also mentioned the character device option. Yet another way would be
to add a sysfs_bin_attribute that corresponds to the boot partition and
can be accessed using read/write, like we do for PCI resources.

	Arnd
