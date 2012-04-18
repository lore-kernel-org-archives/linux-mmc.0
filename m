From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] dmaengine: amba-pl08x: ensure physical channels
	are properly held
Date: Wed, 18 Apr 2012 11:19:38 +0100
Message-ID: <20120418101938.GM25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <E1SKRqh-0004b8-RH@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47764 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab2DRKT5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 06:19:57 -0400
Content-Disposition: inline
In-Reply-To: <E1SKRqh-0004b8-RH@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Oops, this patch wasn't supposed to be part of this set...

On Wed, Apr 18, 2012 at 11:10:55AM +0100, Russell King wrote:
> Ensure that physical channels are held while there are descriptors for
> them to process.  This is needed when we split the pending queue into
> separate pending and issued queues.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/dma/amba-pl08x.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index c301a8e..2e74cca 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -855,6 +855,8 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
>  	struct pl08x_phy_chan *ch;
>  	int ret;
>  
> +	plchan->phychan_hold++;
> +
>  	/* Check if we already have a channel */
>  	if (plchan->phychan) {
>  		ch = plchan->phychan;
> @@ -863,6 +865,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
>  
>  	ch = pl08x_get_phy_channel(pl08x, plchan);
>  	if (!ch) {
> +		plchan->phychan_hold--;
>  		/* No physical channel available, cope with it */
>  		dev_dbg(&pl08x->adev->dev, "no physical channel available for xfer on %s\n", plchan->name);
>  		return -EBUSY;
> @@ -876,6 +879,7 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
>  	if (plchan->slave && pl08x->pd->get_signal) {
>  		ret = pl08x->pd->get_signal(plchan);
>  		if (ret < 0) {
> +			plchan->phychan_hold--;
>  			dev_dbg(&pl08x->adev->dev,
>  				"unable to use physical channel %d for transfer on %s due to platform restrictions\n",
>  				ch->id, plchan->name);
> @@ -899,8 +903,6 @@ static int prep_phy_channel(struct pl08x_dma_chan *plchan,
>  	else if (txd->direction == DMA_DEV_TO_MEM)
>  		txd->ccfg |= ch->signal << PL080_CONFIG_SRC_SEL_SHIFT;
>  
> -	plchan->phychan_hold++;
> -
>  	return 0;
>  }
>  
> @@ -938,8 +940,6 @@ static dma_cookie_t pl08x_tx_submit(struct dma_async_tx_descriptor *tx)
>  		/* Do this memcpy whenever there is a channel ready */
>  		plchan->state = PL08X_CHAN_WAITING;
>  		plchan->waiting = txd;
> -	} else {
> -		plchan->phychan_hold--;
>  	}
>  
>  	spin_unlock_irqrestore(&plchan->lock, flags);
> @@ -1428,6 +1428,7 @@ static int pl08x_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
>  			 * Mark physical channel as free and free any slave
>  			 * signal
>  			 */
> +			plchan->phychan_hold = 0;
>  			release_phy_channel(plchan);
>  		}
>  		/* Dequeue jobs and free LLIs */
> @@ -1529,6 +1530,7 @@ static void pl08x_tasklet(unsigned long data)
>  	if (txd) {
>  		/* Update last completed */
>  		dma_cookie_complete(&txd->tx);
> +		plchan->phychan_hold--;
>  	}
>  
>  	/* If a new descriptor is queued, set it up plchan->at is NULL here */
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
