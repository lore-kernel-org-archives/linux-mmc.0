From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: outstanding TMIO MMC patches
Date: Wed, 29 Dec 2010 14:35:51 +0100
Message-ID: <4D1B3937.80708@arndnet.de>
References: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

Am 29.12.2010 00:32, schrieb Guennadi Liakhovetski:
> Hi Ian
> 
> There are a number of outstanding tmio-mmc patches from Arnd Hannemann and 
> myself, many of them posted weeks ago. We really would like to have them 
> in 2.6.38. Would you have time to process them? Otherwise, could someone 
> else maybe apply them? Listed in the order, in which they should be 
> applied.
> 
> my patches:
> 
> mmc: tmio_mmc: allow multi-element scatter-gather lists
> 	https://patchwork.kernel.org/patch/317142/
> 	should go in via linux-mmc
> 
> mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
> 	https://patchwork.kernel.org/patch/317162/
> 	should go in via linux-mmc
> 
> [1/3] mmc: tmio: merge the private header into the driver
> 	https://patchwork.kernel.org/patch/349931/
> 	should go in via linux-mmc
> 
> [2/3] mmc: tmio: implement a bounce buffer for unaligned DMA
> 	https://patchwork.kernel.org/patch/426661/
> 	should go in via linux-mmc
> 
> [3/3] mfd: sdhi: require the tmio-mmc driver to bounce unaligned buffers
> 	https://patchwork.kernel.org/patch/349961/
> 	acked by Samuel Ortiz, should go in via linux-mmc
> 
> patches from Arnd Hannemann:
> 
> mmc: tmio_mmc: silence compiler warnings
> 	https://patchwork.kernel.org/patch/418931/
> 	should go in via linux-mmc
> 
> [1/6] mmc: tmio: implement SDIO IRQ
> 	https://patchwork.kernel.org/patch/437441/
> 	should go in via linux-mmc
> 
> [2/6] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
> 	https://patchwork.kernel.org/patch/437451/
> 	acked by Samual Ortiz, should go in via linux-mmc
> 
> [3/6] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
> 	https://patchwork.kernel.org/patch/437491/
> 	Either via linux-mmc: Ack needed by Paul Mundt
> 	or later separately via sh-2.6
> 
> [4/6] sh: sh7724 Enable SDIO IRQs
> 	https://patchwork.kernel.org/patch/437471/
> 	Either via linux-mmc: Ack needed by Paul Mundt
> 	or later separately via sh-2.6
> 
> [5/6] sh: sh7722 Enable SDIO IRQs
> 	https://patchwork.kernel.org/patch/437521/
> 	Either via linux-mmc: Ack needed by Paul Mundt
> 	or later separately via sh-2.6
> 
> [6/6] sh: sh7723 / ap325rxa enable SDIO IRQs
> 	https://patchwork.kernel.org/patch/437511/
> 	Either via linux-mmc: Ack needed by Paul Mundt
> 	or later separately via sh-2.6
> 

There are also these two:

[1/2] tmio_mmc: handle missing HW interrupts
	https://patchwork.kernel.org/patch/201962/
[2/2] tmio_mmc: fix CMD irq handling
	https://patchwork.kernel.org/patch/201982/

I reposted them rebased on top of your header merge, otherwise
that would have been a mess:

http://marc.info/?l=linux-mmc&m=129362888209455&w=2

Thanks,
Arnd

