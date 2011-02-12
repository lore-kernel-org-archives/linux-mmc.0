From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 12 Feb 2011 11:45:41 +0100
Message-ID: <201102121145.42053.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102091013.56670.arnd@arndb.de> <AANLkTimZb-hxz-31nGmycdtU-i=t=9wBoDJ-chAXUmD6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64671 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab1BLKpo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 05:45:44 -0500
In-Reply-To: <AANLkTimZb-hxz-31nGmycdtU-i=t=9wBoDJ-chAXUmD6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>, Ulf Hansson <Ulf.Hansson@stericsson.com>

On Saturday 12 February 2011 00:23:37 Linus Walleij wrote:
> H'm! That's an interesting resource indeed. When you write
> "From measurements, it appears that the size in which data is
> managed is typically 64 kb on SD cards" and "the size of the
> medium is always a multiple of entire allocation groups, and
> the most common size today is 4 MB" and then list
> Size, Allocation Unit, Write Size, Page Size, FAT Location,
> open AUs linear, open AUs random, Algorithm.
> 
> How exactly do you measure that?

It's not an exact science, but for most cards I have found
reasonably good ways to identify these numbers:

* the allocation unit size can almost always be found
  using read-only tests: reading 2kb across an allocation
  unit boundary is slightly slower than reading 2kb
  just before or just after the boundary.
  For a few cards where this doesn't work, I do write tests.
  After finding out how many allocation units can be open,
  it's trivial to find out the size.

* Finding the number of open allocation units means I write
  to the start of a few AUs alternating. Up to a certain
  number, the throughput is constant, above that, it drops
  sharply, sometimes by one or two orders of magnitude.

* The page size can also be found doing read-only tests, with
  varying block sizes. Smaller reads always give lower throughput
  than larger reads, but getting smaller than page size
  drops down significantly more than the difference between
  multi-page reads. This effect is more prominent in write tests.

* Finding the algorithm basically means I write an allocation
  unit using varying block sizes two times, using both linear
  access and random access. Cards that are optimized for
  linear access can be unbelievably slow in the random access
  tests. Sometimes the performance is the same above a specific
  block size, but slower for random access below that size.
  This is the write block size.

* Finding the write block size in cases where this is not the
  case can be harder. Most cards have a noticable performance
  drop in writes of less than a few pages, so that's the
  size I put in the table.

* The FAT location is clearly visible in a number of tests
  done inside of an allocation unit. It's normally slower for
  linear access, but faster for random access. Sometimes
  reading the FAT is also slower than reading elsewhere.

> I'm sort of smelling a card-probe.git with this tool that you
> can run on your device and get out data like that listed
> in your table. We have a rather large stash of cards we can
> probe for you to get that kind of data out if it is useful, and
> I believe other Linaro members may have such stuff too,
> if empirical data is usefult to your work.

The tool I'm using is on http://git.linaro.org/gitweb?p=people/arnd/flashbench.git
Unfortunately, it's not yet in the state that I'm recommending
anyone besides me to run it. I'm still rewriting the source
for every new card I get to nail down the specific properties.

I will make an announcement when I have the tool in a state
of general usefulness, and at that point I would really
appreciate people to run it, but just not yet.

	Arnd
