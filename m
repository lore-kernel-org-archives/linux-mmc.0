From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Thu, 31 Mar 2011 14:29:46 -0500
Message-ID: <AANLkTik-TJxfUJdOUJUjFy1ej8tjKNKfRft6QiA4JWx3@mail.gmail.com>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com>
	<201103301403.20779.arnd@arndb.de>
	<AANLkTimD=vwG-Jh0a4E2tYYYwA9sG5sVWS8BFrDBeThb@mail.gmail.com>
	<201103311317.22110.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og113.obsmtp.com ([64.18.0.26]:33563 "EHLO
	exprod5og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620Ab1CaT3u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2011 15:29:50 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2VJU9Dq005105
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 15:30:09 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2VJRri1004058
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 15:30:09 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so3017649wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 31 Mar 2011 12:29:47 -0700 (PDT)
In-Reply-To: <201103311317.22110.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Thu, Mar 31, 2011 at 6:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> My feeling is that these should be separate from the boot partition.
> It could probably be done using a new fs/partitions/mmc.c file
> that directly interacts with the mmc layer instead of looking
> at the MS-DOS master boot record. That way, you could define the
> same partitions (mmcblk0p1, ...) using a different method.
>

Nope. The device partitions are one time programmable (partition
once), so you definitely don't want to expose them as regular
partitions. The point
behind the GP partitions is that they can be implemented with enhanced
features (such as better reliability), and so like the enhanced area,
are meant as a complement, not a replacement for file system
partitions.

I don't think there is a need to over complicate this. It's just going
to get more confusing and involve more changes. The device
partitioning support is pretty orthogonal right now.

>
>> There is also the "Replay Protected Memory Block" device partition,
>> which is not able to host a file system in the normal sense (because
>> layer over the MMC block transfer protocol is a "replay protected
>> transaction" protocol, which could be used by a user-mode application
>> directly reading/writing from /dev/block/mmcblkXXX).
>
> Ok. That sounds like a use case for an ioctl interface then, if
> we even want to expose it.
>

Pretty much.

> Regarding the naming, I would not use a trailing zero, but it's probably
> a subjective thing. The other names I could imagine for the boot partition
> of mmc 0 are mmcboot0, mmcblk0b or mmcblk0boot.
>

Since we have two boot partitions and 4 GP ones, for mmcblk0 I'd stick
with something like
mmcblk0boot0, mmcblk0boot1, mmcblk0gp0-mmcblk0gp4. I'd want to keep
the first mmcblk0, so that
a user can easily associate the actual card the device partitions are for.

> I also mentioned the character device option. Yet another way would be
> to add a sysfs_bin_attribute that corresponds to the boot partition and
> can be accessed using read/write, like we do for PCI resources.

I don't think this gains anything, other than a separate path for
performing I/O, inability to use existing tools (filesystems, dd, etc)
more code and a even less obvious way of bricking something =).

A
