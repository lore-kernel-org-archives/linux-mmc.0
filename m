From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC 3/3] mmc: tmio: discard obsolete SDIO irqs before enabling
 irqs
Date: Tue, 10 Jan 2017 09:09:19 +0100
Message-ID: <20170110080919.GE25239@verge.net.au>
References: <20170105114326.12426-1-wsa+renesas@sang-engineering.com>
 <20170105114326.12426-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105114326.12426-4-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 05, 2017 at 12:43:26PM +0100, Wolfram Sang wrote:
> Before enabling SDIO irqs, clear the status bit, so we discard old and
> stale interrupts. Needed to get two wireless cards working.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index d6033620a45c12..ebe3e12f0083dd 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -134,12 +134,21 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	struct tmio_mmc_host *host = mmc_priv(mmc);
>  
>  	if (enable && !host->sdio_irq_enabled) {
> +		u16 sdio_status;
> +
>  		/* Keep device active while SDIO irq is enabled */
>  		pm_runtime_get_sync(mmc_dev(mmc));
> -		host->sdio_irq_enabled = true;
>  
> +		host->sdio_irq_enabled = true;
>  		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
>  					~TMIO_SDIO_STAT_IOIRQ;
> +
> +		/* Clear obsolete interrupts before enabling */
> +		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS) & ~TMIO_SDIO_MASK_ALL;
> +		if (host->pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
> +			sdio_status |= 6;

Perhaps a #define would be an improvement over "6".

> +		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
> +
>  		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>  	} else if (!enable && host->sdio_irq_enabled) {
>  		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
> -- 
> 2.11.0
> 
