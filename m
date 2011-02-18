From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] mxcmmc: use dmaengine API
Date: Fri, 18 Feb 2011 14:37:02 +0100
Message-ID: <201102181437.02943.arnd@arndb.de>
References: <20110218092109.GG24426@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52144 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab1BRNhT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 08:37:19 -0500
In-Reply-To: <20110218092109.GG24426@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Friday 18 February 2011, Sascha Hauer wrote:
> This switches the mxcmmc driver to use the dmaengine API. Unlike
> the old one this one is always present in the tree, even if no DMA
> is implemented, hence we can remove all the #ifdefs in from the driver.
> The driver automatically switches to PIO mode if no DMA support or no
> suitable channel is available.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

The patch looks good to me, but shouldn't you also add a Kconfig
dependency or select on CONFIG_DMA_ENGINE? I don't see where that
gets set.

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Arnd recognized that it's not a good idea that the driver has to
> know about the dmaengine implementation (the struct imx_dma_data field).
> I have a patch in my queue fixing this, but as this has to be
> synchronized with the platform code, I'd like to address this in a later
> patch.

Sounds good, since this patch is definitely a step forward.

	Arnd
