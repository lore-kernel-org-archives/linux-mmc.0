From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 22 Feb 2011 17:42:25 +0100
Message-ID: <201102221742.25612.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102201603.41856.arnd@arndb.de> <AANLkTin0BVMgpjmeg682F7zcJJajRumLYcsgNriBwX2v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55090 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab1BVQmb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 11:42:31 -0500
In-Reply-To: <AANLkTin0BVMgpjmeg682F7zcJJajRumLYcsgNriBwX2v@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Tuesday 22 February 2011, Andrei Warkentin wrote:
> On Sun, Feb 20, 2011 at 9:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > From your flashbench -a run, I would guess that it uses
> > 8 MB allocation units, although the data is not 100% conclusive
> > there.
> >
>=20
> Because the 8MB aligned write time is significantly faster, right?

I mean because a read spanning an 8 MB boundary is noticably
slower than one spanning a 4 MB boundary (diff 242=B5s instead of 187=B5=
s),
while everything below the numbers for the 4 and 2 MB boundaries
are quite similar.

> I am attaching some graphs. The 16k sandisk shows the slow and fast
> page parallel lines, as does the 8k toshiba (but we knew it for the
> toshiba case), but the boundaries are strange for the sandisk case,
> and there an interesting 2mb variation in the toshiba 8k graph. What
> is the correct way to interpret graphs with other block sizes?

Not sure if it's correct, but my interpretation of your output
is this:

In the Toshiba graph, you see parallel lines that show measurements
30=B5s apart, e.g. 1.06ms and 1.09 ms in the first one. I assume what
you see here are fast and slow pages, respectively. It's a bit hard
to tell in the resolution you have, and it would make sense to zoom
into the picture to see if they are alternating or just random.
The three groups of double lines are probably just some jitter
from the timing of the interrupt controller. If you run with a larger
--count=3D value, these should become less visible.

The sandisk plot shows some sector ranges taht are slower than others,
I'd assume that those are the ones that have been recently written.
The 16KB page plot has parallel lines (again, I'd have to see a
finer resolution plot to see if they are alternating), which the
32KB page plot does not have. I see this as an indication that the
pages are indeed 16KB, and in the 32KB plot the results are just
averaged out.

	Arnd
