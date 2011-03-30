From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Wed, 30 Mar 2011 15:07:20 -0500
Message-ID: <AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<1300828300-8677-2-git-send-email-andreiw@motorola.com>
	<AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
	<201103301403.20779.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:41487 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab1C3UHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 16:07:23 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2UK5j8P021641
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 16:05:45 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2UJEk8Q023014
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 16:05:45 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so1839114wwb.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2011 13:07:20 -0700 (PDT)
In-Reply-To: <201103301403.20779.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

Hi Arnd,

On Wed, Mar 30, 2011 at 7:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I have no objections to the code, but I don't completely understand
> what it does. Maybe you can elaborate more in the patch description.
>

Sorry, will make it more concrete. This patch allows "device
partitions" to be accessed. Device partitions provide their own
address space - hence, you cannot access the boot partition data at
all unless you specifically switch to the partition using MMC_SWITCH.

> A few questions from me that I suppose should be answered by the
> description:
>
> * Is each of the MMC partitions in turn a partitionable device
> =A0like the user partition with its mmcblk0p1/p2/p3... devices?
>

Potentially yes. The current patch adds only the boot partitions,
which generally are just some binary blobs specific to the ROM
bootloaders found on embedded platforms.

Since eMMC 4.41, you can create "general purpose" partitions (up to
4), which will be carved out of the user partition, and can be used in
any way possible, thus potentially holding file system partitions.

There is also the "Replay Protected Memory Block" device partition,
which is not able to host a file system in the normal sense (because
layer over the MMC block transfer protocol is a "replay protected
transaction" protocol, which could be used by a user-mode application
directly reading/writing from /dev/block/mmcblkXXX).

> * Will this patch impact device naming? Suppose you have an
> =A0existing machine with mmcblk0 and mmcblk1 on two physical
> =A0eMMC devices. When you show the partitions as new block
> =A0devices, could it happen that the names are now different
> =A0as you get additional devices inbetween? That would need to
> =A0be documented carefully, as it could break existing setups.
>

Unfortunately yes, although I am open for suggestions. An idea I
considered is to add a postfix for device partitions. So, for card 0,
the user area will remain mmcblk0, while boot partitions will be
mmcblk0b0 and mmcblk0b1, generic partitions will be mmcblk0g0, and so
on.

> * What devices specifically have these new partitions? Only eMMC 4.4
> =A0or also other versions?
>

Boot partitions are available in 4.3. The other ones (4 general
purpose ones, rpmb since 4.41).

> * Would the same method work to support the secure partition on
> =A0SD cards?
>

Most of the generic changes inside block.c apply. I specifically made
the code easy to extend for SD boot partitions. You would just
need the right changes for mmc_blk_part_switch (it already checks for
mmc_card_mmc) and in mmc_blk_alloc_parts.

Unfortunately, since the SD spec is proprietary, I have no way of
confirming whether the SD device partitioning (AFAIK there is a
concept of boot partitions for eSD) works the same way or not, so I
was maximally safe in supporting MMC device partitioning.

> * How does a user identify which hardware partition corresponds to
> =A0a given block device and vice versa?

Right now, you would just need to know. With postfixes like
mmcblk0b0/mmcblk0g0 you would be able to tell the device partitions
apart from the main mmcblk0.

Thanks for the feedback,
A
