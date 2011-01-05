From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: outstanding TMIO MMC patches
Date: Wed, 5 Jan 2011 11:10:18 +0900
Message-ID: <AANLkTi=NWFmskvAosK9fO65OGNLrqEY-_PdvKydyn=G2@mail.gmail.com>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 29, 2010 at 8:32 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Ian
>
> There are a number of outstanding tmio-mmc patches from Arnd Hannemann and
> myself, many of them posted weeks ago. We really would like to have them
> in 2.6.38. Would you have time to process them? Otherwise, could someone
> else maybe apply them? Listed in the order, in which they should be
> applied.

mmc: tmio_mmc: allow multi-element scatter-gather lists
mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
[1/3] mmc: tmio: merge the private header into the driver
[2/3] mmc: tmio: implement a bounce buffer for unaligned DMA
[3/3] mfd: sdhi: require the tmio-mmc driver to bounce unaligned buffers
mmc: tmio_mmc: silence compiler warnings
[1/6] mmc: tmio: implement SDIO IRQ
[2/6] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
[3/6] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
[4/6] sh: sh7724 Enable SDIO IRQs
[5/6] sh: sh7722 Enable SDIO IRQs
[6/6] sh: sh7723 / ap325rxa enable SDIO IRQs
[1/2] tmio_mmc: handle missing HW interrupts
[2/2] tmio_mmc: fix CMD irq handling

[14 outstanding patches including 2 unlisted from Arnd]

Guennadi, thanks a lot for this list of outstanding patches. I've
tested most of them myself and I think they are all a welcome addition
to the SDHI hardware block on SH-Mobile / R-Mobile SoCs. I'm not sure
how they affect other platforms though.

Ian, would it be possible for you to give some feedback? I know it's
holiday season and all, but the first version of most patches were
posted about a month ago.

If we can't get any feedback then perhaps someone else can maintain
the tmio-mmc driver together with Ian? Or maybe it's easier to just
easier to create a SDHI specific fork of the tmio-mmc driver which can
be modified more easily.

Any ideas?

Thanks,

/ magnus
