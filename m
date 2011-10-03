From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: slow eMMC write speed
Date: Mon, 3 Oct 2011 13:19:16 -0700 (PDT)
Message-ID: <1680748273.3852.1317673156420.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <4E89F890.9040503@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:10304 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757232Ab1JCUTR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2011 16:19:17 -0400
In-Reply-To: <4E89F890.9040503@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: J Freyensee <james_p_freyensee@linux.intel.com>
Cc: Praveen G K <praveen.gk@gmail.com>, =?utf-8?Q?Per_F=C3=B6rlin?= <per.forlin@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>, "Andrei E. Warkentin" <andrey.warkentin@gmail.com>

Hi James,

----- Original Message -----
> From: "J Freyensee" <james_p_freyensee@linux.intel.com>
> 
> Yeah, I know I'd be doing myself a huge favor by working off of
> mmc-next
> (or close to it), but product-wise, my department doesn't care for
> sustaining current platforms...yet (still trying to convince).
> 

I'd suggest working on linux-mmc. You can always back-port.

> So I was looking into sticking a write cache into block.c driver as a
> parameter, so it can be turned on and off upon driver load.  Any
> write
> operation goes to the cache and only on a cache collision will the
> write operation get sent to the host controller for a write.  What I
> have working so far is just with an MMC card in an MMC slot of a
> laptop,
> and just bare-bones.  No general flush routine, error-handling, etc.
>  From a couple performance measurements I did on the MMC slot using
> blktrace/blkparse and 400MB write transactions, I was seeing huge
> performance boost with no data corruption.  So it is not looking like
> a
> total hair-brained idea.  But I am still pretty far from
> understanding
> everything here.  And the real payoff we want to see is performance a
> user can see on a handheld (i.e., Android) systems.
> 

Interesting. Thanks for sharing. I don't want to seem silly, but how is what you're doing different from
the page cache? The page cache certainly defers write back (and I believe this is tunable...I'm not too
familiar yet or comfortable around the rest of blk I/O and VM). What are your test workloads? I would
guess this wouldn't have too great of an impact on a non O_DIRECT access, and O_DIRECT access anyway have
to bypass any caching logic.

A
