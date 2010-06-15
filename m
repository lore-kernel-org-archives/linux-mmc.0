From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT for Samsung
	SoC
Date: Tue, 15 Jun 2010 13:04:06 +0100
Message-ID: <20100615120406.GE7248@trinity.fluff.org>
References: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com> <1276601268-7226-4-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1276601268-7226-4-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Lee Hyuk <hyuk1.lee@samsung.com>, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 15, 2010 at 08:27:48PM +0900, Kukjin Kim wrote:
> From: Lee Hyuk <hyuk1.lee@samsung.com>
> 
> S5PV210 HSMMC host controller doesn't have the WP pin which should be
> connnected with SDMMC card WP pin. So if there are the cfg_wp and get_ro
> in pdata, configure the WP pin and replace get_ro function in sdhci with
> get_ro function in pdata.
> 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   12 ++++++++++++
>  drivers/mmc/host/sdhci.c     |    3 +++
>  drivers/mmc/host/sdhci.h     |    3 +++
>  3 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index af21792..857cbed 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -311,6 +311,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	if (pdata->cfg_gpio)
>  		pdata->cfg_gpio(pdev, pdata->max_width);
>  
> +	if (pdata->get_ro)
> +		sdhci_s3c_ops.get_ro = pdata->get_ro;
> +
>  	host->hw_name = "samsung-hsmmc";
>  	host->ops = &sdhci_s3c_ops;
>  	host->quirks = 0;
> @@ -335,6 +338,15 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
>  
> +	/* Controller's WP pin donsn't connected with SD card. So we allocate
> +	 * a GPIO for getting WP data form SD card  and use that data as
> +	 * the return value of the get_ro function */
> +	host->quirks |= SDHCI_QUIRK_NO_WP_BIT;

I really think this should be a custom-wp quirk, not a we-don-have-wp
quirk.

> +
> +	/* to configure gpio pin as a card write protection signal */
> +	if (pdata->cfg_wp)
> +		pdata->cfg_wp(pdev->id);
> +
>  	ret = sdhci_add_host(host);
>  	if (ret) {
>  		dev_err(dev, "sdhci_add_host() failed\n");
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..2f8dfbc 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1192,6 +1192,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  
>  	host = mmc_priv(mmc);
>  
> +	if ((host->quirks & SDHCI_QUIRK_NO_WP_BIT) && host->ops->get_ro)
> +		return host->ops->get_ro(mmc);
> +
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	if (host->flags & SDHCI_DEVICE_DEAD)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..f479e22 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -240,6 +240,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
>  /* Controller cannot support End Attribute in NOP ADMA descriptor */
>  #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
> +/* Controller has no write-protect pin connected with SD card */
> +#define SDHCI_QUIRK_NO_WP_BIT                          (1<<27)
>  
>  	int			irq;		/* Device IRQ */
>  	void __iomem *		ioaddr;		/* Mapped address */
> @@ -312,6 +314,7 @@ struct sdhci_ops {
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +	int		(*get_ro)(struct mmc_host *mmc);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
