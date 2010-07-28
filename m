From: Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v5 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for
 Samsung	SoC
Date: Wed, 28 Jul 2010 18:20:37 +0100
Message-ID: <4C5066E5.50505@simtec.co.uk>
References: <1280294587-17961-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1280294587-17961-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

On 28/07/10 06:23, Kukjin Kim wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
> 
> If host controller doesn't have WP pin which should be connnected with SDMMC
> card WP pin, can implement get_ro function with using the allocated gpio.
> In order to use this quirk wp_gpio in the platform data must be set.
> 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> Changes since v4:
> - Address comments from Marek.
> 
> Hi Andrew,
> If there are no problems, could you please apply this patch?
>rn gpio_get_value(ourhost->pdata->wp_gpio);
> +}
> +
> +/**
> + * sdhci_s3c_cfg_wp - configure GPIO for WP pin
> + * @gpio_num: GPIO number which connected with WP line from SD/MMC slot
> + *
> + * Configure GPIO for using WP line
> +*/
> +static void sdhci_s3c_cfg_wp(unsigned int gpio_num)
> +{
> +	s3c_gpio_cfgpin(gpio_num, S3C_GPIO_INPUT);

gpio_direction_input()

> +	s3c_gpio_setpull(gpio_num, S3C_GPIO_PULL_UP);

would prefer not to be using this here, should go into the
board file, otherwise we can't pass non-soc gpios into this
code.


> +/**
>   * sdhci_s3c_get_min_clock - callback to get minimal supported clock value
>   * @host: The SDHCI host being queried
>   *
> @@ -408,6 +435,15 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
>  
> +	/* Controller's WP pin doesn't connected with SD card and there is an
> +	 * allocated GPIO for getting WP data form SD card, use this quirk and
> +	 * send the GPIO number in pdata->wp_gpio. */
> +	if (pdata->has_wp_gpio && gpio_is_valid(pdata->wp_gpio)) {
> +		sdhci_s3c_ops.get_ro = sdhci_s3c_get_ro;
> +		host->quirks |= SDHCI_QUIRK_NO_WP_BIT;
> +		sdhci_s3c_cfg_wp(pdata->wp_gpio);
> +	}
> +
>  	ret = sdhci_add_host(host);
>  	if (ret) {
>  		dev_err(dev, "sdhci_add_host() failed\n");
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f9ca4c6..7fba401 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1198,6 +1198,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>  
>  	host = mmc_priv(mmc);
>  
> +	if ((host->quirks & SDHCI_QUIRK_NO_WP_BIT) && host->ops->get_ro)
> +		return host->ops->get_ro(mmc);
> +

I really think we shouldn't be using quirks here, just checking the
existence of the host->ops->get_ro field.
