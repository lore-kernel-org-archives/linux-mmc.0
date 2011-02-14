From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Mon, 14 Feb 2011 21:22:54 +0100
Message-ID: <201102142122.54766.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102131839.08517.arnd@arndb.de> <AANLkTin=bkzvdQXoWUKRfX8Xs=4bXnxWf88TUG+VvjPD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:64421 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab1BNUXD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 15:23:03 -0500
In-Reply-To: <AANLkTin=bkzvdQXoWUKRfX8Xs=4bXnxWf88TUG+VvjPD@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Monday 14 February 2011 20:29:59 Andrei Warkentin wrote:
> On Sun, Feb 13, 2011 at 11:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Ah sorry, I had to look that one up myself, I thought it was the local
> jargon associated with the problem space :-). Program/Erase cycle.

Ok, makes sense.

> >> So T suggested for random data to better go into buffer A. How? Two suggestions.
> >> 1) Split smaller accesses into 8KB and write with reliable write.
> >> 2) Split smaller accesses into 8KB and write in reverse.
> >>
> >> The patch does both and I am verifying if that is really necessary. I
> >> need to go see the mmc spec and what it says about reliable write.
> >
> > I should add this to my test tool once I can reproduce it. If it turns
> > out that other media do the same, we can also trigger the same behavior
> > for those.
> >
> 
> As I mentioned, I am checking with T right now on whether we can use
> suggestion (1) or
> suggestion (2) or if they need to be combined. The documentation we
> got was open to interpretation and the patch created from that did
> both.
> You mentioned that writing in reverse is not a good idea. Could you
> elaborate why? I would guess because you're always causing a write
> into a different AU (on these Toshiba cards), causing extra GC on
> every write?

Probably both the reliable write and writing small blocks in reverse
order will cause any card to do something that is different from
what it does on normal 64kb (or larger) aligned accesses.

There are multiple ways how this could be implemented:

1. Have one exception cache for all "special" blocks. This would normally
   be for FAT32 subdirectory updates, which always write to the same
   few blocks. This means you can do small writes efficiently anywhere
   on the card, but only up to a (small) fixed number of block addresses.
   If you overflow the table, the card still needs to go through an
   extra PE for each new entry you write, in order to free up an entry.

2. Have a small number of AUs that can be in a special mode with efficient
   small writes but inefficient large writes. This means that when you
   alternate between small and large writes in the same AU, it has to go
   through a PE on every switch. Similarly, if you do small writes to
   more than the maximum number of AUs that can be held in this mode, you
   get the same effect. This number can be as small as one, because that
   is what FAT32 requires.

In both cases, you don't actually have a solution for the problem, you just
make it less likely for specific workloads.

	Arnd
