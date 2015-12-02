From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
Date: Wed, 2 Dec 2015 10:22:09 +0530
Message-ID: <20151202045209.GB1854@localhost>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <20151201165954.GA1696@localhost>
 <3124382.EhiMyQGKTA@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64832 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbbLBEtM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Dec 2015 23:49:12 -0500
Content-Disposition: inline
In-Reply-To: <3124382.EhiMyQGKTA@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org

On Tue, Dec 01, 2015 at 09:17:06PM +0100, Arnd Bergmann wrote:
> On Tuesday 01 December 2015 22:29:54 Vinod Koul wrote:
> > On Mon, Nov 30, 2015 at 03:45:30PM +0200, Peter Ujfalusi wrote:
> > > channel via DT, ACPI or in case if the kernel booted in non DT/ACPI mode
> > > it will use a filter lookup table and retrieves the needed information from
> > > the dma_filter_map provided by the DMA drivers.
> > 
> > That sounds right, for the third case would the arch, driver or someone else
> > configure this?
> 
> The typical case is for the configuration to be defined in arch or platform
> code and passed down to the dmaengine driver.
> 
> I just noticed that the text above (and probably the code too) should
> be changed so we always fall back to this. There are cases where the
> platform is booted with DT in principle, but the DMA engine does not
> (yet) use DT and still wants to be converted. I think we can easily
> handle that case by always trying this if the other methods fail.

I agree that this makes sense, not just for DT cases but ACPI as well

> 
> > > This legacy mode needs changes in platform code, in dmaengine drivers and
> > > finally the dmaengine user drivers can be converted:
> > 
> > Are you marking the current APIs as dericated in the end of this series
> 
> I think we practically stopped marking things as deprecated in general.
> Per Linus decree, whenever we want to get rid of something, we should
> instead change all users in tree and then remove the API, expecting
> driver maintainers to do something just because you marked it as deprecated
> often doesn't work.

Yes but while we do conversion we don't know if new users get added which use
old API..

> 
> I can help out converting a few platforms, maybe one interface at a time.

Great yes we all will have to chip in and start removing these, i will try
doing few after new year

Am sure Andy can chip in as well :)

> This is what I see:
> 
> arnd@wuerfel:~/arm-soc$ for i in dma_request_slave_channel_reason dma_request_slave_channel dma_request_slave_channel_compat dma_request_channel  ; do echo `git grep -wl $i drivers/  | grep -v drivers/dma | wc -l`\      $i ; done
> 14      dma_request_slave_channel_reason
> 27      dma_request_slave_channel
> 25      dma_request_slave_channel_compat
> 34      dma_request_channel
> 
> I would probably leave the users of dma_request_channel() while converting
> the others, as that is still used by all the platforms that don't use any DT
> support.
> 
> Changing dma_request_slave_channel_reason and dma_request_slave_channel is
> trivial, we can probably use coccinelle for that, as it does not require
> any platform changes. That brings us to the users of
> dma_request_slave_channel_compat, which currently includes these files:
> 
> $ git grep -wl dma_request_slave_channel_compat drivers/ata/pata_pxa.c
> drivers/crypto/atmel-aes.c
> drivers/crypto/atmel-sha.c
> drivers/crypto/atmel-tdes.c
> drivers/crypto/omap-aes.c
> drivers/crypto/omap-des.c
> drivers/crypto/omap-sham.c
> drivers/media/platform/omap3isp/isphist.c
> drivers/mmc/host/davinci_mmc.c
> drivers/mmc/host/omap.c
> drivers/mmc/host/omap_hsmmc.c
> drivers/mmc/host/pxamci.c
> drivers/mmc/host/s3cmci.c
> drivers/mmc/host/tmio_mmc_dma.c
> drivers/mtd/nand/pxa3xx_nand.c
> drivers/net/ethernet/smsc/smc91x.c
> drivers/net/irda/pxaficp_ir.c
> drivers/spi/spi-omap2-mcspi.c
> drivers/spi/spi-pxa2xx-dma.c
> drivers/spi/spi-rspi.c
> drivers/spi/spi-s3c64xx.c
> drivers/spi/spi-sh-msiof.c
> drivers/tty/serial/8250/8250_dma.c
> drivers/tty/serial/samsung.c
> drivers/tty/serial/sh-sci.c
> include/linux/dmaengine.h
> 
> In other words: arch/avr32 and arch/sh along with omap1, omap2, davinci, pxa, and s3c
> in terms of ARM platforms.
> 
> 	Arnd

-- 
~Vinod
