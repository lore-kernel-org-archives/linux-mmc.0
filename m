From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/3] dma: edma: add device_channel_caps() support
Date: Sun, 20 Jan 2013 05:03:21 -0800
Message-ID: <20130120130321.GE23398@intel.com>
References: <1357844826-30746-1-git-send-email-mporter@ti.com>
 <1357844826-30746-3-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12164 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab3ATN2I (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Jan 2013 08:28:08 -0500
Content-Disposition: inline
In-Reply-To: <1357844826-30746-3-git-send-email-mporter@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Dan Williams <djbw@fb.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

On Thu, Jan 10, 2013 at 02:07:05PM -0500, Matt Porter wrote:
> Implement device_channel_caps().
> 
> EDMA has a finite set of PaRAM slots available for linking
> a multi-segment SG transfer. In order to prevent any one
> channel from consuming all PaRAM slots to fulfill a large SG
> transfer, the driver reports a static per-channel max number
> of SG segments it will handle.
> 
> The maximum size of SG segment is limited by the slave config
> maxburst and addr_width for the channel in question. These values
> are used from the current channel config to calculate and return
> the max segment length cap.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  drivers/dma/edma.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 82c8672..fc4b9db 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -70,6 +70,7 @@ struct edma_chan {
>  	bool				alloced;
>  	int				slot[EDMA_MAX_SLOTS];
>  	struct dma_slave_config		cfg;
> +	struct dmaengine_chan_caps	caps;
>  };
>  
>  struct edma_cc {
> @@ -462,6 +463,28 @@ static void edma_issue_pending(struct dma_chan *chan)
>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>  }
>  
> +static struct dmaengine_chan_caps
> +*edma_get_channel_caps(struct dma_chan *chan, enum dma_transfer_direction dir)
> +{
> +	struct edma_chan *echan;
> +	enum dma_slave_buswidth width = 0;
> +	u32 burst = 0;
> +
> +	if (chan) {
I think this check is redundant.
> +		echan = to_edma_chan(chan);
> +		if (dir == DMA_MEM_TO_DEV) {
> +			width = echan->cfg.dst_addr_width;
> +			burst = echan->cfg.dst_maxburst;
Per you API example burst and width is not set yet, so this doesn't make sense
> +		} else if (dir == DMA_DEV_TO_MEM) {
> +			width = echan->cfg.src_addr_width;
> +			burst = echan->cfg.src_maxburst;
> +		}
> +		echan->caps.seg_len = (SZ_64K - 1) * width * burst;
Also the defination of API is max, above computation doesn't make sense to me!

--
~Vinod
