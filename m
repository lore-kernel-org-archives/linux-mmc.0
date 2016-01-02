From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 08/24] mmc: sdhci: avoid unnecessary mapping/unmapping
 of align buffer
Date: Sat, 2 Jan 2016 12:29:19 +0000
Message-ID: <20160102122919.GX8644@n2100.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <E1aAypq-00016e-Lv@rmk-PC.arm.linux.org.uk>
 <56828E46.5090600@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:35785 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbcABM32 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jan 2016 07:29:28 -0500
Content-Disposition: inline
In-Reply-To: <56828E46.5090600@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

On Tue, Dec 29, 2015 at 03:44:38PM +0200, Adrian Hunter wrote:
> On 21/12/15 13:41, Russell King wrote:
> > Unnecessarily mapping and unmapping the align buffer for SD cards is
> > expensive: performance measurements on iMX6 show that this gives a hit
> > of 10% on hdparm buffered disk reads.
> > 
> > MMC/SD card IO comes from the mm/vfs which gives us page based IO, so
> > for this case, the align buffer is not going to be used.  However, we
> > still map and unmap this buffer.
> > 
> > Eliminate this by switching the align buffer to be a DMA coherent
> > buffer, which needs no DMA maintenance to access the buffer.
> 
> Did you consider putting the align buffer in the same allocation
> as the adma_table?

It's not clear whether host->adma_table_sz would be appropriately
aligned.

> > @@ -3003,6 +2972,10 @@ int sdhci_add_host(struct sdhci_host *host)
> >  						      host->adma_table_sz,
> >  						      &host->adma_addr,
> >  						      GFP_KERNEL);
> > +		host->align_buffer = dma_alloc_coherent(mmc_dev(mmc),
> > +							host->align_buffer_sz,
> > +							&host->align_addr,
> > +							GFP_KERNEL);
> >  		host->align_buffer = kmalloc(host->align_buffer_sz, GFP_KERNEL);
> 
> kmalloc line is still there

Good catch, thanks.

> > +
> > +		/* dma_alloc_coherent returns page aligned and sized buffers */
> > +		BUG_ON(host->align_addr & host->align_mask);
> 
> It would be nicer not to have any BUG_ON()

This is a situation that should _never_ occur (if it does, then the
dma_alloc_coherent() implementation is violating the API requirements,
which are to return a page-sized page-aligned buffer.)  I guess it
could be a WARN_ON(), but if it fails we're likely to cause data
corruption.  So, a WARN_ON() and failing the probe seems more
appropriate - but then that means yet more messy cleanup in an already
messy part of the driver.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
