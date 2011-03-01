From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 1 Mar 2011 20:11:51 +0100
Message-ID: <201103012011.51855.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102251321.09232.arnd@arndb.de> <4D6D3F71.4040605@kernel.dk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60735 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1CATL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 14:11:59 -0500
In-Reply-To: <4D6D3F71.4040605@kernel.dk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrei Warkentin <andreiw@motorola.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Tuesday 01 March 2011 19:48:17 Jens Axboe wrote:
> 
> On 2011-02-25 07:21, Arnd Bergmann wrote:
> > On Friday 25 February 2011, Andrei Warkentin wrote:
> >> Yup. I understand :-).  That's the strategy I'm going to follow. For
> >> page_size-alignment/splitting I'm looking at the block layer now. Is
> >> that the right approach or should I still submit a (cleaned up) patch
> >> to mmc/card/block.c for that performance improvement.
> > 
> > I guess it should live in block/cfq-iosched in the long run, but I don't
> > know how easy it is to implement it there for test purposes.
> 
> I don't think I saw the original patch(es) for this?

Nobody has posted one yet, only discussions. Andrei made a patch for the
MMC block driver to split requests in some cases, but I think the
concept has changed enough that it's probably not useful to look at
that patch.

I think what needs to be done here is to split requests in these cases:

* Small requests should be split on flash page boundaries, where a page
is typically 8 to 32 KB. Sending one hardware request that spans two
partial pages can be slower than sending two requests with the same
data, but on page boundaries.

* If a hardware transfer is limited to a few sectors, these should be
aligned to page boundaries. E.g. assuming a 16 sector page and 32 sector
maximum transfers, a request that spans from sector 7 to 62 should be
split into three transfers: 7-15, 16-47 and 48-62, not 7-38 and 39-62.
This reduces the number of page read-modify-write cycles that the drive
does.

* No request should ever span multiple erase blocks. Most flash drives today
have 4MB erase blocks (sometimes 1, 2 or 8), and the I/O scheduler should
treat the erase block boundary like a seek on a hard drive. The I/O
scheduler should try to send all sector writes of an erase block in sequence,
but after that it can chose any other erase block to write to next.

I think if we get this logic, we can deal well with all cheap flash drives.
The two parameters we need are the page size and the erase block size,
which the kernel can sometimes guess, but should also be tunable in
sysfs for devices that don't tell us or lie to the kernel about them.

I'm not sure if we want to do this for all nonrotational media, or
add another flag to enable these optimizations. On proper SSDs that have
an intelligent controller and enough RAM, they probably would not help
all that much, or even make it slightly slower due to a higher number
of separate write requests.

	Arnd
