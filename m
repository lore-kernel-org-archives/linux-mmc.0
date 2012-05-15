From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Tue, 15 May 2012 09:49:24 +0530
Message-ID: <1337055564.16185.5356.camel@vkoul-udesk3>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:3016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab2EOE0e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 May 2012 00:26:34 -0400
In-Reply-To: <20120423160409.GE24299@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

On Mon, 2012-04-23 at 17:04 +0100, Russell King - ARM Linux wrote:
> For the full text, please see 
> 
> http://lists.arm.linux.org.uk/lurker/message/20120418.100954.7fa7acf8.en.html
> 
> This version contains updates for some of the comments received from the
> previous round, and adds the OMAP1/2 MMC and SPI drivers to the conversion.
> 
> I've also added a note to feature-removal noting that the existing APIs
> will be removed around 2013 - I'm planning January for that at the
> moment.  Having drivers around which are unconverted blocks further work
> on the DMA engine conversion, so it's actually important that we get
> as many drivers converted as soon as possible.
> 
> Anything which isn't converted will probably have its DMA code removed,
> or if that results in the driver not being usable, the driver itself
> will be removed.
> 
> This series is still in RFC mode...
Hi Russell,

What is the state of this series, would be good to have this merged in
upcoming merge window.
> 
>  Documentation/feature-removal-schedule.txt |   11 +
>  arch/arm/mach-omap1/board-h2-mmc.c         |    1 -
>  arch/arm/mach-omap1/board-h3-mmc.c         |    1 -
>  arch/arm/mach-omap1/board-nokia770.c       |    1 -
>  arch/arm/mach-omap2/board-n8x0.c           |    1 -
>  arch/arm/mach-omap2/hsmmc.c                |    1 -
>  arch/arm/plat-omap/dma.c                   |   14 +
>  arch/arm/plat-omap/include/plat/mmc.h      |    2 -
>  drivers/dma/Kconfig                        |   10 +
>  drivers/dma/Makefile                       |    2 +
>  drivers/dma/omap-dma.c                     |  521 ++++++++++++++++++++++++++++
>  drivers/dma/sa11x0-dma.c                   |  249 ++++---------
>  drivers/dma/virt-dma.c                     |   99 ++++++
>  drivers/dma/virt-dma.h                     |  138 ++++++++
>  drivers/mmc/host/omap.c                    |  369 +++++++++-----------
>  drivers/mmc/host/omap_hsmmc.c              |  206 ++++++------
>  drivers/spi/spi-omap2-mcspi.c              |  228 +++++++------
>  17 files changed, 1268 insertions(+), 586 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
~Vinod

