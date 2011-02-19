From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 19 Feb 2011 10:54:48 +0100
Message-ID: <201102191054.48706.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com> <AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56125 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196Ab1BSJzA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Feb 2011 04:55:00 -0500
In-Reply-To: <AANLkTi=rg2Du2RbakqpRNZZ7HHkhrsobz713YL29Wqoi@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Friday 18 February 2011 23:40:16 Andrei Warkentin wrote:
> On Fri, Feb 18, 2011 at 1:47 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>
> Flashbench timings for both Sandisk and Toshiba cards. Attaching due to size.

Very nice, thanks for the measurement!

I don't think having the results inline in the mail is a problem,
it would even make it easier to quote.
 
> Some interesting things that I don't understand. For the align test, I
> extended it to do a write align test (-A). I tried two partitions that
> I could write over, and both read and writes behaved differently for
> the two partitions on same device. Odd. They are both 4MB aligned.

I never did a write align test because the results will be highly
unreliable as soon as you get into thrashing. Your results seem
to be meaningful still, so maybe we should have it after all, but
I'll put a big warning on it.

> On the sandisk it was the write align that made the page size stand
> out.  The read align had pretty constant results.

I've noticed on other Sandisk media that the read align test is
sometimes useless. It may help to do a full erase of the partition,
or to fill it with data before running the test.

> On the toshiba the results varied wildly for the two partitions. For
> partition 6, there was a clear pattern in the diff values for read
> align. For 9, it was all over the place. For 9 with the write align,
> 8K and 16K the crossing writes took ~115ms!! Look in attached files
> for all the data.

Partition 6 is a lot smaller, so you have the accesses less than a
segment apart, so it shows other effects.

> The AU tests were interesting too, especially how with several open
> AUs the throughput is higher for certain smaller sizes on sandisk, but
> if I interpret it correctly both cards have at least 4 AUs, as I
> didn't see yet a significant drop for small sizes. The larger ones I
> am running now on mmcblk0p9 which is sufficiently larger for these
> tests... (mmcblk0p6 is only 40mb, p9 is 314 mb)

Right, you should try larger values for --open-au-nr here. It's at
least a good sign that the drive can do random access inside a segment
and that it can have at least 4 segments open. This is much better
than I expected from your descriptions at first.

However, the drop from 32 KB to 16 KB in performance is horrifying
for the Toshiba drive, it's clear that this one does not like
to be accessed smaller than 32 KB at a time, an obvious optimization
for FAT32 with 32 KB clusters. How does this change with your
kernel patches?

For the sandisk drive, it's funny how it is consistently faster
doing random access than linear access. I don't think I've seem that
before. It does seem to have some cache for linear access using
smaller than 16 KB, and can probably combine them when it's only
writing to a single segment.

	Arnd
