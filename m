From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next v2 3/4] mmc: renesas-sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Wed, 21 Jun 2017 11:10:59 +0200
Message-ID: <20170621091058.GB27507@verge.net.au>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-4-git-send-email-horms+renesas@verge.net.au>
 <20170617150055.eeholgustydof3w5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36595 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdFUJLU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2017 05:11:20 -0400
Content-Disposition: inline
In-Reply-To: <20170617150055.eeholgustydof3w5@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Sat, Jun 17, 2017 at 05:00:56PM +0200, Wolfram Sang wrote:
> On Fri, Jun 16, 2017 at 11:58:53AM +0200, Simon Horman wrote:
> > Add a new variant of the SDHI driver to support R-Car Gen3 with DMA via
> > on-chip bus mastering.  Since the DMAC is in a part of the SDHI module it
> > is not suitable to be used via DMA Engine.
> > 
> > Clearing of DM_CM_INFO1 after DMA thanks to Dirk Behme
> > 
> > Cc: Dirk Behme <dirk.behme@de.bosch.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> 
> Your Sob is missing!

Yikes!

> 
> > + * - Since this SDHI DMAC register set has actual 32-bit and "bus_shift" is 2,
> > + *   this driver cannot use original sd_ctrl_{write,read}32 functions.
> 
> Easier to understand, I'd think, would be:
> 
> Since the SDHI DMAC register set has not 16 but 32-bit width, we need a
> custom accessor.

Thanks, updated.

> 
> > +	ret = dma_map_sg(&host->pdev->dev, sg, host->sg_len, dir);
> > +	if (ret < 0) {
> > +		dev_err(&host->pdev->dev, "%s: dma_map_sg failed\n", __func__);
> 
> __func__?

I have removed that message, it looks like an artifact of the development
process.

> 
> > +	/* start the DMAC */
> 
> Not very useful comment in my book, but no strong opinion.
> 
> > +	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_CTRL,
> > +					    DTRAN_CTRL_DM_START);
> > +}
> > +	dma_unmap_sg(&host->pdev->dev, host->sg_ptr, host->sg_len, dir);
> > +
> > +	spin_unlock_irq(&host->lock);
> > +
> > +	spin_lock_irq(&host->lock);
> 
> Just keep the lock?

Yes, indeed.

> 
> Rest looks good so far...
> 


