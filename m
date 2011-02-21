From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] mxcmmc: use dmaengine API
Date: Mon, 21 Feb 2011 15:07:50 +0100
Message-ID: <20110221140750.GN24426@pengutronix.de>
References: <20110218092109.GG24426@pengutronix.de>
 <201102181437.02943.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53479 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1BUOHy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 09:07:54 -0500
Content-Disposition: inline
In-Reply-To: <201102181437.02943.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Fri, Feb 18, 2011 at 02:37:02PM +0100, Arnd Bergmann wrote:
> On Friday 18 February 2011, Sascha Hauer wrote:
> > This switches the mxcmmc driver to use the dmaengine API. Unlike
> > the old one this one is always present in the tree, even if no DMA
> > is implemented, hence we can remove all the #ifdefs in from the driver.
> > The driver automatically switches to PIO mode if no DMA support or no
> > suitable channel is available.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The patch looks good to me, but shouldn't you also add a Kconfig
> dependency or select on CONFIG_DMA_ENGINE? I don't see where that
> gets set.

I was about to answer with a patch adding a select on CONFIG_DMA_ENGINE
but just realized this isn't necessary. Without dmaengine support
dma_request_channel becomes a static inline returning NULL. The mxcmmc
driver falls back to PIO then and still works.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
