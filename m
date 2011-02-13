From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sun, 13 Feb 2011 18:39:08 +0100
Message-ID: <201102131839.08517.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102121937.24933.arnd@arndb.de> <AANLkTikGvUZ2sWfox9Ws+gbuCw1JiykO=y-rk9QjL8xJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62840 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1BMRjR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 12:39:17 -0500
In-Reply-To: <AANLkTikGvUZ2sWfox9Ws+gbuCw1JiykO=y-rk9QjL8xJ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sunday 13 February 2011 01:10:09 Andrei Warkentin wrote:
> On Sat, Feb 12, 2011 at 12:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > This part might make sense in general, though it's hard to know the
> > page size in the general case. For many SD cards, writing naturally
> > aligned 64 KB blocks was the ideal case in my testing, but some need
> > larger alignment or can deal well with smaller blocks.
> >
> 
> ...which is why I believe this should be a boot per-card parameter,
> and that it really only makes sense for embedded parts, where you know
> nothing else is going to be used as, say, mmcblk0.

I don't think it needs to be boot-time, it can easily be run-time
tuneable using sysfs, where you can configure it using an init script
or some other logic from user space.

> > I could imagine that this will cause problems on your eMMC once you
> > write small blocks to more than erase block group, because that probably
> > causes it to start garbage collection -- it makes sense for the cards
> > to know that something is a directory, but it can only know about
> > a small number of directories, so it will turn the segment into a regular
> > one as soon something else becomes a directory.
> >
> 
> It's difficult for me to argue one way or another. The code provided
> is implementing Toshiba's suggestions for mitigating excessive wear.
> Basically, as far as certain Android products are concerned, Motorola
> created some "typical usage" cases, and collected data logs. These
> logs were analyzed by Toshiba, which reported an approx x16
> multiplication factor for writes.

Yes, I've seen similar numbers in my measurements. My experience with
the Kingston/Toshiba cards is that they combine two unfortunate
problems:

* Only one 4 MB AU can be open, writing to a different AU waits for
garbage collection on the old one. Other cards typically have
five buffers for open AUs, which makes them much easier to work with.

* Only linear access within one AU is fast. Writing to a block with
a lower address in the same AU causes garbage collection of the AU.

> Analysis of data written showed that there were many random accesses
> with 16KB or 32KB, meaning they go into buffer B. 

I have started a remapping layer that should be able to deal with
this independent of the card, see
https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashDeviceMapper
It's still in the early stages, but maybe something like that will
help you as well.

The real solution would be to have a file system that knows what
accesses are fast and reorders file data accordingly. Right now,
the only thing that is normally fast is FAT32 using 32KB clusters,
and only if the file system is aligned properly.

> According to T, that
> means extra GC and PE cycle. I'm guessing per write.

Yes.

What is "PE" here?

> So T suggested for random data to better go into buffer A. How? Two suggestions.
> 1) Split smaller accesses into 8KB and write with reliable write.
> 2) Split smaller accesses into 8KB and write in reverse.
> 
> The patch does both and I am verifying if that is really necessary. I
> need to go see the mmc spec and what it says about reliable write.

I should add this to my test tool once I can reproduce it. If it turns
out that other media do the same, we can also trigger the same behavior
for those.

> Basically, whatever behavior you choose is going to be wrong some set
> of cards. Which is why tuning it probably only makes sense for eMMC
> parts, and should be a set of runtime/compile-time quirks. What do you
> think?

Your explanation makes sense, but I'd definitely favor a run-time solution
over compile-time or boot-time, because it would be much more flexible.
We should also be able to find some optimizations that are universally
good so we can always use them.

	Arnd
