From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Wed, 9 Feb 2011 09:37:40 +0100
Message-ID: <AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54740 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab1BIIhk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Feb 2011 03:37:40 -0500
Received: by pzk35 with SMTP id 35so1335113pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 09 Feb 2011 00:37:40 -0800 (PST)
In-Reply-To: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

[Quoting in verbatin so the orginal mail hits linux-mmc, this is very
interesting!]

2011/2/8 Andrei Warkentin <andreiw@motorola.com>:
> Hi,
>
> I'm not sure if this is the best place to bring this up, but Russel's
> name is on a fair share of drivers/mmc code, and there does seem to be
> quite a bit of MMC-related discussions. Excuse me in advance if this
> isn't the right forum :-).
>
> Certain MMC vendors (maybe even quite a bit of them) use a pretty
> rigid buffering scheme when it comes to handling writes. There is
> usually a buffer A for random accesses, and a buffer B for sequential
> accesses. For certain Toshiba parts, it looks like buffer A is 8KB
> wide, with buffer B being 4MB wide, and all accesses larger than 8KB
> effectively equating to 4MB accesses. Worse, consecutive small (8k)
> writes are treated as one large sequential access, once again ending
> up in buffer B, thus necessitating out-of-order writing to work around
> this.
>
> What this means is decreased life span for the parts, and it also
> means a performance impact on small writes, but the first item is much
> more crucial, especially for smaller parts.
>
> As I've mentioned, probably more vendors are affected. How about a
> generic MMC_BLOCK quirk that splits the requests (and optionally
> reorders) them? The thresholds would then be adjustable as
> module/kernel parameters based on manfid. I'm asking because I have a
> patch now, but its ugly and hardcoded against a specific manufacturer.

There is a quirk API so that specific quirks can be flagged for certain
vendors and cards, e.g. some Toshibas in this case. e.g. grep the
kernel source for MMC_QUIRK_BLKSZ_FOR_BYTE_MODE.

But as Russell says this probably needs to be signalled up to the
block layer to be handled properly.

Why don't you post the code you have today as an RFC: patch,
I think many will be interested?

Yours,
Linus Walleij
