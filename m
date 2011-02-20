From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sun, 20 Feb 2011 16:03:41 +0100
Message-ID: <201102201603.41856.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102191054.48706.arnd@arndb.de> <AANLkTi=GO8N15pCnZWuuJ6FfyQMytFt23LPS5oYMNuMu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59488 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab1BTPDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Feb 2011 10:03:48 -0500
In-Reply-To: <AANLkTi=GO8N15pCnZWuuJ6FfyQMytFt23LPS5oYMNuMu@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Sunday 20 February 2011 05:39:06 Andrei Warkentin wrote:
> Actually it would be a good idea to also bail/warn if you do the au
> test with more open au's than the size of the passed device allows,
> since it'll just wrap around and skew the results.

Yes, that's a bug. I never noticed because all the devices I tested
have much more space than the test can possibly exercise. I'll
fix it tomorrow.

> > Right, you should try larger values for --open-au-nr here. It's at
> > least a good sign that the drive can do random access inside a segment
> > and that it can have at least 4 segments open. This is much better
> > than I expected from your descriptions at first.
> 
> Actually the Toshiba one seems to have 7 AUs if I interpret this correctly.
> ^C
> # ./flashbench -O -0 6  -b 512 /dev/block/mmcblk0p9
> 4MiB    5.91M/s
> 2MiB    8.84M/s
> 1MiB    10.8M/s
> 512KiB  13M/s
> 256KiB  13.6M/s
> 
> ^C
> # ./flashbench -O -0 7  -b 512 /dev/block/mmcblk0p9
> 4MiB    6.32M/s
> 2MiB    8.63M/s
> 1MiB    10.5M/s
> 512KiB  13.2M/s
> 256KiB  13M/s
> ^[[A^[[D^[[A128KiB  12.3M/s
> ^C
> # ./flashbench -O -0 8  -b 512 /dev/block/mmcblk0p9
> 4MiB    6.65M/s
> 2MiB    7.02M/s
> 1MiB    6.36M/s
> 512KiB  3.17M/s
> 256KiB  1.53M/s

Yes, very good. I've never seen 7, but I've seen all other numbers
betwen 1 and 8 ;-).

> The Sandisk one has 20 AUs.
> 
> # ./flashbench -O -0 20  -b 512 /dev/block/mmcblk0p9
> 4MiB    11.3M/s
> 2MiB    12.8M/s
> 1MiB    9.87M/s
> 512KiB  9.97M/s
> 256KiB  9.13M/s
> 128KiB  8.05M/s
> ^C
> # ./flashbench -O -0 50  -b 512 /dev/block/mmcblk0p9
> 4MiB    7.19M/s
> ^C
> # ./flashbench -O -0 2  -b 512 /dev/block/mmcblk0p9
> ^C
> # ./flashbench -O -0 22  -b 512 /dev/block/mmcblk0p9
> 4MiB    11.6M/s
> 2MiB    12.3M/s
> 1MiB    5.13M/s
> 512KiB  2.57M/s
> 256KiB  1.59M/s
> 128KiB  1.16M/s
> 64KiB   776K/s
> ^C
> # ./flashbench -O -0 21  -b 512 /dev/block/mmcblk0p9
> 4MiB    11.2M/s
> 2MiB    12.4M/s
> 1MiB    4.65M/s
> 512KiB  1.95M/s
> 256KiB  955K/s

20 is a lot, more than any other device I've tested, but that's
good. Sandisk keeps impressing me ;-)

Are you sure you have the allocation unit size correctly for
this device and you don't get into the wrap-around bug
you mention above?

If it indeed uses 4 MB allocation units, flashbench will show
only 10 open segments when run with --erasesize=$[8*1024*1024],
but 20 open segments when run with --erasesize=$[2*1024*1024].

>From your flashbench -a run, I would guess that it uses
8 MB allocation units, although the data is not 100% conclusive
there.

> > However, the drop from 32 KB to 16 KB in performance is horrifying
> > for the Toshiba drive, it's clear that this one does not like
> > to be accessed smaller than 32 KB at a time, an obvious optimization
> > for FAT32 with 32 KB clusters. How does this change with your
> > kernel patches?
> 
> Since the only performance-increasing patch here would be just the one
> that splits unaligned accesses, I wouldn't expect any improvements for
> page-aligned accesses < 32KB. As you can see here...

Ok.

> > For the sandisk drive, it's funny how it is consistently faster
> > doing random access than linear access. I don't think I've seem that
> > before. It does seem to have some cache for linear access using
> > smaller than 16 KB, and can probably combine them when it's only
> > writing to a single segment.
> 
> Yes, that is pretty interesting. Smaller than 16K? Not smaller than
> 32K? I wonder what it is doing...

My interpretation is that it uses 16 KB pages, but can do two page-sized
writes in a single access (multi-plane write). Anything smaller than
a page goes to a temporary buffer first (like the Toshiba chip), but
gets flushed when the next one is not contiguous. If you manage to fill
the entire 16 KB page using small contiguous writes, it can do a single
efficient write access instead.

To confirm that 16 KB is the page size, you can try 

flashbench -s --scatter-span=1 --scatter-order=10 -o plot.data \
	/dev/mmcblk1 -c 32 --blocksize=16384
gnuplot -p -e 'plot "plot.data" '

On most MLC flashes, this will show a pattern alternating between slow
and fast pages like the one from https://lwn.net/Articles/428836/

	Arnd
