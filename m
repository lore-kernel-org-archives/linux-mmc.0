From: Chris Ball <cjb@laptop.org>
Subject: Re: outstanding TMIO MMC patches
Date: Wed, 5 Jan 2011 22:24:08 +0000
Message-ID: <20110105222408.GM9198@void.printf.net>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange> <4D1B3937.80708@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D1B3937.80708@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Just to check we're agreed on the current status:

On Wed, Dec 29, 2010 at 02:35:51PM +0100, Arnd Hannemann wrote:
> > my patches:
> > 
> > mmc: tmio_mmc: allow multi-element scatter-gather lists
> > 	https://patchwork.kernel.org/patch/317142/
> > 	should go in via linux-mmc
> > 
> > mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
> > 	https://patchwork.kernel.org/patch/317162/
> > 	should go in via linux-mmc
> > 
> > [1/3] mmc: tmio: merge the private header into the driver
> > 	https://patchwork.kernel.org/patch/349931/
> > 	should go in via linux-mmc
> > 
> > [2/3] mmc: tmio: implement a bounce buffer for unaligned DMA
> > 	https://patchwork.kernel.org/patch/426661/
> > 	should go in via linux-mmc
> > 
> > [3/3] mfd: sdhi: require the tmio-mmc driver to bounce unaligned buffers
> > 	https://patchwork.kernel.org/patch/349961/
> > 	acked by Samuel Ortiz, should go in via linux-mmc
> > 
> > patches from Arnd Hannemann:
> > 
> > mmc: tmio_mmc: silence compiler warnings
> > 	https://patchwork.kernel.org/patch/418931/
> > 	should go in via linux-mmc
> > 
> > [1/6] mmc: tmio: implement SDIO IRQ
> > 	https://patchwork.kernel.org/patch/437441/
> > 	should go in via linux-mmc
> > 
> > [2/6] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
> > 	https://patchwork.kernel.org/patch/437451/
> > 	acked by Samual Ortiz, should go in via linux-mmc

I've merged all of the above patches.

> > [3/6] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
> > 	https://patchwork.kernel.org/patch/437491/
> > 	Either via linux-mmc: Ack needed by Paul Mundt
> > 	or later separately via sh-2.6
> > 
> > [4/6] sh: sh7724 Enable SDIO IRQs
> > 	https://patchwork.kernel.org/patch/437471/
> > 	Either via linux-mmc: Ack needed by Paul Mundt
> > 	or later separately via sh-2.6
> > 
> > [5/6] sh: sh7722 Enable SDIO IRQs
> > 	https://patchwork.kernel.org/patch/437521/
> > 	Either via linux-mmc: Ack needed by Paul Mundt
> > 	or later separately via sh-2.6
> > 
> > [6/6] sh: sh7723 / ap325rxa enable SDIO IRQs
> > 	https://patchwork.kernel.org/patch/437511/
> > 	Either via linux-mmc: Ack needed by Paul Mundt
> > 	or later separately via sh-2.6

I haven't merged these because I'd prefer them to go via architecture
trees.

> There are also these two:
> 
> [1/2] tmio_mmc: handle missing HW interrupts
> 	https://patchwork.kernel.org/patch/201962/
> [2/2] tmio_mmc: fix CMD irq handling
> 	https://patchwork.kernel.org/patch/201982/

I haven't merged these because 1/2 breaks the build without TMIO_MMC_DMA=y.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
