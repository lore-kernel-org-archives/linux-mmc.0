From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: RE: [PATCH v2] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO
 host controller
Date: Sat, 3 May 2014 11:08:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1405031046560.23253@axis700.grange>
References: <Pine.LNX.4.64.1404261404030.21367@axis700.grange>
 <a3075651ae064d2fb70073eb3472ede4@HKXPR06MB168.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:55793 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaECJJA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 May 2014 05:09:00 -0400
In-Reply-To: <a3075651ae064d2fb70073eb3472ede4@HKXPR06MB168.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>

Hi Phil,

Thanks for the comments.

On Mon, 28 Apr 2014, Phil Edworthy wrote:

> Hi Guennadi,
> 
> On 26 April 2014 13:06, Guennadi wrote:
> > Subject: [PATCH v2] mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO
> > host controller
> > 
> > This patch adds a driver for the Renesas usdhi6rol0 SD/SDIO host controller
> > in both PIO and DMA modes.
> 
> ...
> > +static void usdhi6_dma_stop_unmap(struct usdhi6_host *host)
> > +{
> > +	struct mmc_data *data = host->mrq->data;
> > +
> > +	if (!host->dma_active)
> > +		return;
> > +
> > +	usdhi6_write(host, USDHI6_CC_EXT_MODE, 0);
> > +	host->dma_active = false;
> > +
> > +	if (data->flags & MMC_DATA_READ)
> > +		/* TODO: do we have to synchronise? */
> > +		dma_unmap_sg(host->chan_rx->device->dev, data->sg,
> > +			     data->sg_len, DMA_FROM_DEVICE);
> Yes, you have to sync, so you can remove this TODO comment.

Why do you think so? If we really do, we'd have to add it. And I did think 
synchronisation was needed, that's why I posted this patch series:

http://thread.gmane.org/gmane.linux.kernel.mmc/24969

but it never got applied, even though it got 2 acks. And actually now I 
think that synchronisation isn't needed. I think dma_map_sg() / 
dma_unmap_sg() do that for us already. E.g.

dma_map_sg_attrs()
arm_dma_map_page()
__dma_page_cpu_to_dev()
dmac_map_area()
cpu_cache.dma_map_area()
v7_dma_inv_range()
v7_dma_clean_range()

Similar for unmapping. So, I think it would be best to remove the comment 
without adding synchronisation.

Let me do this: I'll prepare a separate patch for adding dma syncs, but I 
won't submit it for now, or I can just provide it for reference.

> ...
> > +static int usdhi6_probe(struct platform_device *pdev)
> > +{
> ...
> > +	host		= mmc_priv(mmc);
> > +	host->mmc	= mmc;
> > +	host->wait	= USDHI6_WAIT_FOR_REQUEST;
> > +	host->timeout	= msecs_to_jiffies(1000);

> In all places you use host->timeout, the code uses host->timeout * 4. 
> Wouldn't it better to just set it here to 4 seconds?

ok, I'll do that for v3.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
