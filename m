From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Wed, 9 Feb 2011 10:13:56 +0100
Message-ID: <201102091013.56670.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51710 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab1BIJOF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Feb 2011 04:14:05 -0500
In-Reply-To: <AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org

On Wednesday 09 February 2011 09:37:40 Linus Walleij wrote:
> [Quoting in verbatin so the orginal mail hits linux-mmc, this is very
> interesting!]
> 
> 2011/2/8 Andrei Warkentin <andreiw@motorola.com>:
> > Hi,
> >
> > I'm not sure if this is the best place to bring this up, but Russel's
> > name is on a fair share of drivers/mmc code, and there does seem to be
> > quite a bit of MMC-related discussions. Excuse me in advance if this
> > isn't the right forum :-).
> >
> > Certain MMC vendors (maybe even quite a bit of them) use a pretty
> > rigid buffering scheme when it comes to handling writes. There is
> > usually a buffer A for random accesses, and a buffer B for sequential
> > accesses. For certain Toshiba parts, it looks like buffer A is 8KB
> > wide, with buffer B being 4MB wide, and all accesses larger than 8KB
> > effectively equating to 4MB accesses. Worse, consecutive small (8k)
> > writes are treated as one large sequential access, once again ending
> > up in buffer B, thus necessitating out-of-order writing to work around
> > this.

It's more complex, but I now have a pretty good understanding of
what the flash media actually do, after doing a lot of benchmarking.
Most of my results so far are documented on

https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashCardSurvey

but I still need to write about the more recent discoveries.

What you describe as buffer A is the "page size" of the underlying
flash. It depends on the size and brand of the NAND flash chip and
can be anywhere between 2 KB and 16 KB for modern cards, depending
on how they combine multiple chips and planes within the chips.

What you describe as buffer B is sometime called an "erase block
group" or an "allocation unit". This is the smallest unit that
gets kept in a global lookup table in the medium and can be anywhere
between 1 MB and 8 MB for cards larger than 4 GB, or as small as
128 KB (a single erase block) for smaller media, as far as I have
seen. When you don't write full aligned allocation units, the
card will have to eventually do garbage collection on the allocation
unit, which can take a long time (many milliseconds).

Most cards have a third size, typically somewhere between 32 and 128 KB,
which is the optimimum size for writes. While you can do linear
writes to the card in page size units (writing an allocation unit
from start to finish), doing random access within the allocation unit
will be much faster doing larger writes.

> > What this means is decreased life span for the parts, and it also
> > means a performance impact on small writes, but the first item is much
> > more crucial, especially for smaller parts.
> >
> > As I've mentioned, probably more vendors are affected. How about a
> > generic MMC_BLOCK quirk that splits the requests (and optionally
> > reorders) them? The thresholds would then be adjustable as
> > module/kernel parameters based on manfid. I'm asking because I have a
> > patch now, but its ugly and hardcoded against a specific manufacturer.

It's not just MMC specific: USB flash drives, CF cards and even cheap
PATA or SATA SSDs have the same patterns. I think this will need
to be solved on a higher level, in the block device elevator code
and in the file systems.

> There is a quirk API so that specific quirks can be flagged for certain
> vendors and cards, e.g. some Toshibas in this case. e.g. grep the
> kernel source for MMC_QUIRK_BLKSZ_FOR_BYTE_MODE.
> 
> But as Russell says this probably needs to be signalled up to the
> block layer to be handled properly.
> 
> Why don't you post the code you have today as an RFC: patch,
> I think many will be interested?

Yes, I agree, that would be good. Also, I'd be interested to see the
output of 'head /sys/block/mmcblk0/device/*' on that card. I'm guessing
that the manufacturer ID of 0x0002 is Toshiba, and these are indeed
the worst cards that I have seen so far, because they can not do
random access within an allocation unit, and they can not write to
multiple allocation units alternating (# open AUs linear is "1" in
my wiki table), while most cards can do at least two.

Andrei, I'm certainly interested in working with you on this.
The point you brought up about the toshiba cards being especially
bad is certainly vald, even if we do something better in the block
layer, we need to have a way to detect the worst-case scenario,
so we can work around that.

	Arnd
