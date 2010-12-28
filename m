From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: outstanding TMIO MMC patches
Date: Wed, 29 Dec 2010 00:32:13 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1012281211560.21647@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Ian

There are a number of outstanding tmio-mmc patches from Arnd Hannemann and 
myself, many of them posted weeks ago. We really would like to have them 
in 2.6.38. Would you have time to process them? Otherwise, could someone 
else maybe apply them? Listed in the order, in which they should be 
applied.

my patches:

mmc: tmio_mmc: allow multi-element scatter-gather lists
	https://patchwork.kernel.org/patch/317142/
	should go in via linux-mmc

mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
	https://patchwork.kernel.org/patch/317162/
	should go in via linux-mmc

[1/3] mmc: tmio: merge the private header into the driver
	https://patchwork.kernel.org/patch/349931/
	should go in via linux-mmc

[2/3] mmc: tmio: implement a bounce buffer for unaligned DMA
	https://patchwork.kernel.org/patch/426661/
	should go in via linux-mmc

[3/3] mfd: sdhi: require the tmio-mmc driver to bounce unaligned buffers
	https://patchwork.kernel.org/patch/349961/
	acked by Samuel Ortiz, should go in via linux-mmc

patches from Arnd Hannemann:

mmc: tmio_mmc: silence compiler warnings
	https://patchwork.kernel.org/patch/418931/
	should go in via linux-mmc

[1/6] mmc: tmio: implement SDIO IRQ
	https://patchwork.kernel.org/patch/437441/
	should go in via linux-mmc

[2/6] mfd: sh_mobile_sdhi: activate SDIO IRQ for tmio_mmc
	https://patchwork.kernel.org/patch/437451/
	acked by Samual Ortiz, should go in via linux-mmc

[3/6] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
	https://patchwork.kernel.org/patch/437491/
	Either via linux-mmc: Ack needed by Paul Mundt
	or later separately via sh-2.6

[4/6] sh: sh7724 Enable SDIO IRQs
	https://patchwork.kernel.org/patch/437471/
	Either via linux-mmc: Ack needed by Paul Mundt
	or later separately via sh-2.6

[5/6] sh: sh7722 Enable SDIO IRQs
	https://patchwork.kernel.org/patch/437521/
	Either via linux-mmc: Ack needed by Paul Mundt
	or later separately via sh-2.6

[6/6] sh: sh7723 / ap325rxa enable SDIO IRQs
	https://patchwork.kernel.org/patch/437511/
	Either via linux-mmc: Ack needed by Paul Mundt
	or later separately via sh-2.6

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

