From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: outstanding TMIO MMC patches
Date: Wed, 5 Jan 2011 13:53:47 +0900
Message-ID: <20110105045347.GA23889@linux-sh.org>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 05, 2011 at 11:10:18AM +0900, Magnus Damm wrote:
> mmc: tmio_mmc: allow multi-element scatter-gather lists
> mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
> [1/3] mmc: tmio: merge the private header into the driver
> [2/3] mmc: tmio: implement a bounce buffer for unaligned DMA
> [3/3] mfd: sdhi: require the tmio-mmc driver to bounce unaligned buffers
> mmc: tmio_mmc: silence compiler warnings
> [1/6] mmc: tmio: implement SDIO IRQ
> [2/6] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
> [3/6] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
> [4/6] sh: sh7724 Enable SDIO IRQs
> [5/6] sh: sh7722 Enable SDIO IRQs
> [6/6] sh: sh7723 / ap325rxa enable SDIO IRQs
> [1/2] tmio_mmc: handle missing HW interrupts
> [2/2] tmio_mmc: fix CMD irq handling
> 
> [14 outstanding patches including 2 unlisted from Arnd]
> 
> Guennadi, thanks a lot for this list of outstanding patches. I've
> tested most of them myself and I think they are all a welcome addition
> to the SDHI hardware block on SH-Mobile / R-Mobile SoCs. I'm not sure
> how they affect other platforms though.
> 
> Ian, would it be possible for you to give some feedback? I know it's
> holiday season and all, but the first version of most patches were
> posted about a month ago.
> 
> If we can't get any feedback then perhaps someone else can maintain
> the tmio-mmc driver together with Ian? Or maybe it's easier to just
> easier to create a SDHI specific fork of the tmio-mmc driver which can
> be modified more easily.
> 
The situation is actually much worse than this, the initial patches are
more than 2 months old, and have never been commented on once by the
alleged "maintainer" of the TMIO driver. This is not the first time
either, and indeed, every single time patches are posted that touch this
driver, months pass before anything at all gets done.

My expectation was that if the subsystem had a maintainer that claimed to
be active they would step up and do something when repeated efforts to
engage with an absentee driver maintainer fall short. If neither one of
these things are the case, then I really see no reason to bring changes
to this driver to the attention of either the author or the subsystem
author, and will just start to merge them directly.

Having this amount of work backlogged without so much as a single bit of
feedback or activity from anyone that pretends to be a maintainer is
simply nonsense. It's not acceptable to have progress stalled
indefinitely simply because 'real life got in the way' or any other
number of baseless excuses. If you can't commit to doing the job you
elected to as a maintainer, then set the driver orphaned and get out of
the way.

The MMC subsystem has been pretty much a disaster in terms of maintenance
for as long as I can remember, so this is certainly not a new situation,
but I had hoped that the situation had rather improved recently with at
least some people stepping up and being a bit more active. For now, -mm
is probably the only way for these to make any sort of forward progress,
but it's a bit counter-intuitive to have to sideline an allegedly
maintained subsystem in order for anything to happen at all.
