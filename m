From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Fri, 1 Apr 2011 12:38:02 +0200
Message-ID: <201104011238.02551.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <201103311317.22110.arnd@arndb.de> <AANLkTik-TJxfUJdOUJUjFy1ej8tjKNKfRft6QiA4JWx3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49160 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab1DAKiH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 06:38:07 -0400
In-Reply-To: <AANLkTik-TJxfUJdOUJUjFy1ej8tjKNKfRft6QiA4JWx3@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 31 March 2011, Andrei Warkentin wrote:
> On Thu, Mar 31, 2011 at 6:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > My feeling is that these should be separate from the boot partition.
> > It could probably be done using a new fs/partitions/mmc.c file
> > that directly interacts with the mmc layer instead of looking
> > at the MS-DOS master boot record. That way, you could define the
> > same partitions (mmcblk0p1, ...) using a different method.
>
> Nope. The device partitions are one time programmable (partition
> once), so you definitely don't want to expose them as regular
> partitions. The point
> behind the GP partitions is that they can be implemented with enhanced
> features (such as better reliability), and so like the enhanced area,
> are meant as a complement, not a replacement for file system
> partitions.
> 
> I don't think there is a need to over complicate this. It's just going
> to get more confusing and involve more changes. The device
> partitioning support is pretty orthogonal right now.

Even if they are write-once, wouldn't we still need to provide an
interface to write them once?

The question if GP should be used together or instead of MS-DOS
partitions depends on the possible use cases. If you don't want
to partition a GP any further in software, exposing them directly
as mmcblk0pX would be a very nice and simple interface, but
it completely prevents you from creating subpartitions.

The other alternative is to allow each GP to contain a partition
table, but then you need a either a three-level naming (mmcblk0gp1p2)
or make each GP a device by itself (mmcblk0, mmcblk1) that can in
turn be partitioned.

> > Regarding the naming, I would not use a trailing zero, but it's probably
> > a subjective thing. The other names I could imagine for the boot partition
> > of mmc 0 are mmcboot0, mmcblk0b or mmcblk0boot.
> >
> 
> Since we have two boot partitions and 4 GP ones, for mmcblk0 I'd stick
> with something like
> mmcblk0boot0, mmcblk0boot1, mmcblk0gp0-mmcblk0gp4. I'd want to keep
> the first mmcblk0, so that
> a user can easily associate the actual card the device partitions are for.

I would find it rather confusing if the device can be partitioned in
software but the GP devices could not be.

	Arnd
