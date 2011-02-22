From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 22 Feb 2011 18:00:16 +0100
Message-ID: <201102221800.17196.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102201539.08496.arnd@arndb.de> <AANLkTi=ZOUrNoT1W1n3d+9KTMewKZ3kxo71AQsas9OpD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56496 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab1BVRA2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 12:00:28 -0500
In-Reply-To: <AANLkTi=ZOUrNoT1W1n3d+9KTMewKZ3kxo71AQsas9OpD@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Tuesday 22 February 2011, Andrei Warkentin wrote:
> On Sun, Feb 20, 2011 at 8:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > E.g. the I/O scheduler can also make sure that we always submit all
> > blocks from the start of one erase unit (e.g. 4 MB) to the end, but
> > not try to merge requests across erase unit boundaries. It can
> > also try to group the requests in aligned power-of-two sized chunks
> > rather than merging as many sectors as possible up to the maximum
> > request size, ignoring the alignment.
> 
> I agree. These are common things that affect any kind of flash
> storage, and it belongs in the I/O scheduler as simple tuneables. I'll
> see if I can figure my way around that...
> 
> What belongs in mmc card driver are tunable workarounds for MMC/SD
> brokeness. For example - needing to use 8K-spitted reliable writes to
> ensure that a 64KB access doesn't wind up in the 4MB buffer B (as to
> improve lifespan of the card.) But you want a waterline above which
> you don't do this anymore, otherwise the overall performance will go
> to 0 - i.e. there is a need to balance between performance and
> reliability, so the range of access size for which the workaround
> works needs to be runtime controlled, as it's potentially different.
> Another example (this one is apparently affecting Sandisk) - do
> special stuff for block erase, since the card violates spec in that
> regard (touch ext_csd instead of argument, I believe). A different
> example might be turning on reliable writes for WRITE_META (or all)
> blocks for a certain partition (but I just made that up... ).

Yes, makes sense.

> You could put the entire MMC block policy interface through an API
> usable by system integrators - i.e. you would really only care for
> tuning the MMC parameters if you're creating a device around an emmc.
> 
> Idea (1). One idea is to keep the "policies" from my previous mail.
> Policies are registered through platform-specific code. The policies
> could be then matched for enabling against a specific block device by
> manfid/date/etc at the time of mmc_block_alloc... For removable media
> no one would fiddle with the tunable parameters anyway, unless there
> was some global database of cards and workarounds and a daemon or some
> such to take care of that... Probably don't want to add such baggage
> to the kernel.
> 
> Idea (2). There is probably no need to overcomplicate. Just add a
> platform callback (something like int
> (*mmc_platform_block_workaround)(struct request *, struct
> mmc_blk_request *)). This will be usable as-is for R/W accesses, and
> the discard code will need to be slightly modified.
> 
> Do you think there is any need for runtime tuning of the MMC
> workarounds (disregarding ones that really belong in the I/O
> scheduler)? Should the workarounds be simply platform callbacks, or
> should they be something heftier ("policies")?

The platform hook seems the wrong place, because you might use
the same chip in multiple platforms, and a single platform might
have a large number of different boards, all of which require
separate workarounds.

A per-card quirk table does not seem so bad, we have that in
other subsystems as well. I wouldn't necessarily make it
a list of possible quirks, but rather a __devinit function that
is called for a new card on insertion, in order to tweak various
parameters.

	Arnd
