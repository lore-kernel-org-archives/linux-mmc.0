From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio: fix PM in DMA mode
Date: Tue, 10 May 2011 21:20:37 -0400
Message-ID: <m3fwom6niy.fsf@pullcord.laptop.org>
References: <Pine.LNX.4.64.1104291909290.17813@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104291909290.17813@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 29 Apr 2011 19:11:00 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Fri, Apr 29 2011, Guennadi Liakhovetski wrote:
> DMA mode has to be re-enabled during a resume.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mmc/host/tmio_mmc_dma.c |   21 ++++++++++++---------
>  drivers/mmc/host/tmio_mmc_pio.c |    1 +
>  2 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index d3de74a..25f1ad6 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -256,7 +256,10 @@ static bool tmio_mmc_filter(struct dma_chan *chan, void *arg)
>  void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata)
>  {
>  	/* We can only either use DMA for both Tx and Rx or not use it at all */
> -	if (pdata->dma) {
> +	if (!pdata->dma)
> +		return;
> +
> +	if (!host->chan_tx && !host->chan_rx) {
>  		dma_cap_mask_t mask;
>  
>  		dma_cap_zero(mask);
> @@ -284,18 +287,18 @@ void tmio_mmc_request_dma(struct tmio_mmc_host *host, struct tmio_mmc_data *pdat
>  
>  		tasklet_init(&host->dma_complete, tmio_mmc_tasklet_fn, (unsigned long)host);
>  		tasklet_init(&host->dma_issue, tmio_mmc_issue_tasklet_fn, (unsigned long)host);
> +	}
>  
> -		tmio_mmc_enable_dma(host, true);
> +	tmio_mmc_enable_dma(host, true);
> +
> +	return;
>  
> -		return;
>  ebouncebuf:
> -		dma_release_channel(host->chan_rx);
> -		host->chan_rx = NULL;
> +	dma_release_channel(host->chan_rx);
> +	host->chan_rx = NULL;
>  ereqrx:
> -		dma_release_channel(host->chan_tx);
> -		host->chan_tx = NULL;
> -		return;
> -	}
> +	dma_release_channel(host->chan_tx);
> +	host->chan_tx = NULL;
>  }
>  
>  void tmio_mmc_release_dma(struct tmio_mmc_host *host)
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 26598f1..27fc11c 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -995,6 +995,7 @@ int tmio_mmc_host_resume(struct device *dev)
>  		pm_runtime_get_sync(dev);
>  
>  	tmio_mmc_reset(mmc_priv(mmc));
> +	tmio_mmc_request_dma(host, host->pdata);
>  
>  	return mmc_resume_host(mmc);
>  }

This patch doesn't apply against current mmc-next.

Please could you send a full patchset against mmc-next for tmio for .40?

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
