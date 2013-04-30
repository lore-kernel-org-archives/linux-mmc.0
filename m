From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 5/6] mci: at91: convert to dma_request_slave_channel_compat()
Date: Tue, 30 Apr 2013 10:06:07 +0200
Message-ID: <517F7B6F.4070907@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com> <1366362683-14496-6-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366362683-14496-6-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 04/19/2013 11:11 AM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org :
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Use generic DMA DT helper. Platforms booting with or without DT populated are
> both supported.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Hi Chris,

As you were not in copy of the patch, I send you a little reminder for
it. It is part of a series by Ludovic and is adding the generic slave
DMA request channel function, as we now have the support for DMA bindings.

Here is the only patch of the series that should go through your tree.
Other maintainers and ourselves have taken the other patches (no strong
synchronization needed between them).

Here is the Linux arm kernel patchwork reference:
https://patchwork.kernel.org/patch/2463641/

But for sure, Ludovic or myself can send it again to you if you need.

Thanks, best regards,

> ---
>  drivers/mmc/host/atmel-mci.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 10f8b73..ffbd0d3 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2224,10 +2224,15 @@ static void __exit atmci_cleanup_slot(struct atmel_mci_slot *slot,
>  	mmc_free_host(slot->mmc);
>  }
>  
> -static bool atmci_filter(struct dma_chan *chan, void *slave)
> +static bool atmci_filter(struct dma_chan *chan, void *pdata)
>  {
> -	struct mci_dma_data	*sl = slave;
> +	struct mci_platform_data *sl_pdata = pdata;
> +	struct mci_dma_data *sl;
>  
> +	if (!sl_pdata)
> +		return false;
> +
> +	sl = sl_pdata->dma_slave;
>  	if (sl && find_slave_dev(sl) == chan->device->dev) {
>  		chan->private = slave_data_ptr(sl);
>  		return true;
> @@ -2239,24 +2244,18 @@ static bool atmci_filter(struct dma_chan *chan, void *slave)
>  static bool atmci_configure_dma(struct atmel_mci *host)
>  {
>  	struct mci_platform_data	*pdata;
> +	dma_cap_mask_t mask;
>  
>  	if (host == NULL)
>  		return false;
>  
>  	pdata = host->pdev->dev.platform_data;
>  
> -	if (!pdata)
> -		return false;
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
>  
> -	if (pdata->dma_slave && find_slave_dev(pdata->dma_slave)) {
> -		dma_cap_mask_t mask;
> -
> -		/* Try to grab a DMA channel */
> -		dma_cap_zero(mask);
> -		dma_cap_set(DMA_SLAVE, mask);
> -		host->dma.chan =
> -			dma_request_channel(mask, atmci_filter, pdata->dma_slave);
> -	}
> +	host->dma.chan = dma_request_slave_channel_compat(mask, atmci_filter, pdata,
> +							  &host->pdev->dev, "rxtx");
>  	if (!host->dma.chan) {
>  		dev_warn(&host->pdev->dev, "no DMA channel available\n");
>  		return false;
> 


-- 
Nicolas Ferre
