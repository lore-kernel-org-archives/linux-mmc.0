From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] atmel-mci: change use of dma slave interface
Date: Tue, 29 Sep 2009 12:29:28 -0700
Message-ID: <20090929122928.f5fea29b.akpm@linux-foundation.org>
References: <1253204967-30010-1-git-send-email-nicolas.ferre@atmel.com>
	<1253204967-30010-2-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57903 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753731AbZI2T3d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2009 15:29:33 -0400
In-Reply-To: <1253204967-30010-2-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com, kernel@avr32linux.org, nicolas.ferre@atmel.com

On Thu, 17 Sep 2009 18:29:26 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Allow the use of another DMA controller driver in atmel-mci sd/mmc driver. This
> adds a generic dma_slave pointer to the mci platform structure where we can
> store DMA controller information. In atmel-mci we use information provided by
> this structure to initialize the driver (with new helper functions that are
> architecture dependant).
> This also adds at32/avr32 chip modifications to cope with this new access
> method.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/avr32/mach-at32ap/at32ap700x.c |    6 ++-
>  drivers/mmc/host/atmel-mci.c        |   82 ++++++++++++++++++++++++++---------
>  include/linux/atmel-mci.h           |    3 +-
>  3 files changed, 68 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> index eb9d4dc..d1fe145 100644
> --- a/arch/avr32/mach-at32ap/at32ap700x.c
> +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> @@ -1320,7 +1320,7 @@ struct platform_device *__init
>  at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>  {
>  	struct platform_device		*pdev;
> -	struct dw_dma_slave		*dws = &data->dma_slave;
> +	struct dw_dma_slave		*dws;
>  	u32				pioa_mask;
>  	u32				piob_mask;
>  
> @@ -1339,6 +1339,8 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>  				ARRAY_SIZE(atmel_mci0_resource)))
>  		goto fail;
>  
> +	dws = kzalloc(sizeof(struct dw_dma_slave), GFP_KERNEL);

I don't see anywhere where this gets freed again?

>  	dws->dma_dev = &dw_dmac0_device.dev;
>  	dws->reg_width = DW_DMA_SLAVE_WIDTH_32BIT;
>  	dws->cfg_hi = (DWC_CFGH_SRC_PER(0)
> @@ -1346,6 +1348,8 @@ at32_add_device_mci(unsigned int id, struct mci_platform_data *data)
>  	dws->cfg_lo &= ~(DWC_CFGL_HS_DST_POL
>  				| DWC_CFGL_HS_SRC_POL);
>  
> +	data->dma_slave = dws;
> +
>  	if (platform_device_add_data(pdev, data,
>  				sizeof(struct mci_platform_data)))
>  		goto fail;
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 065fa81..1689396 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1575,16 +1575,71 @@ static void __exit atmci_cleanup_slot(struct atmel_mci_slot *slot,
>  }
>  
>  #ifdef CONFIG_MMC_ATMELMCI_DMA
> -static bool filter(struct dma_chan *chan, void *slave)
> +static struct device *find_slave_dev(void *slave)
> +{
> +	if (!slave)
> +		return NULL;
> +
> +	if (cpu_is_at32ap7000())
> +		return ((struct dw_dma_slave *)slave)->dma_dev;
> +	else
> +		return ((struct at_dma_slave *)slave)->dma_dev;
> +}

Quite a few unsafeish typecasts here.

>  struct mci_platform_data {
> -	struct dw_dma_slave	dma_slave;
> +	void			*dma_slave;
>  	struct mci_slot_pdata	slot[ATMEL_MCI_MAX_NR_SLOTS];
>  };

I think the code would come out better if this has type dw_dma_slave*.

You'll still need typecasts to support the dma_request_channel()
callback, but the code will be safer and cleaner, I expect.

