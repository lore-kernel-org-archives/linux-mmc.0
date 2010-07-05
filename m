From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v2 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk
Date: Mon, 05 Jul 2010 09:14:06 +0200
Message-ID: <006301cb1c11$aa7d47f0$ff77d7d0$%szyprowski@samsung.com>
References: <1278118844-21770-1-git-send-email-kgene.kim@samsung.com>
 <1278118844-21770-4-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:21013 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0GEHPT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2010 03:15:19 -0400
In-reply-to: <1278118844-21770-4-git-send-email-kgene.kim@samsung.com>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Hyuk Lee' <hyuk1.lee@samsung.com>, ben-linux@fluff.org

Hello,

On Saturday, July 03, 2010 3:01 AM Kukjin Kim wrote:

> From: Hyuk Lee <hyuk1.lee@samsung.com>
> 
> If host controller doesn't have WP pin which should be connnected with
> SDMMC
> card WP pin, can implement get_ro function with using the allocated gpio.
> In order to use this quirk wp_gpio in the platform data must be set.
> 
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c |   44
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c     |    3 ++
>  drivers/mmc/host/sdhci.h     |    3 ++
>  3 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index af21792..ed9376d 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -18,11 +18,13 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
> 
>  #include <linux/mmc/host.h>
> 
>  #include <plat/sdhci.h>
>  #include <plat/regs-sdhci.h>
> +#include <plat/gpio-cfg.h>
> 
>  #include "sdhci.h"
> 
> @@ -209,6 +211,36 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	}
>  }
> 
> +/**
> + * sdhci_s3c_get_ro - callback for get_ro
> + * @host: The SDHCI host being changed
> + *
> + * If the WP pin is connected with GPIO, can get the value which indicates
> + * the card is locked or not.
> +*/
> +static int sdhci_s3c_get_ro(struct mmc_host *mmc)
> +{
> +	struct sdhci_s3c *sc;
> +	struct sdhci_host *host;
> +
> +	host = mmc_priv(mmc);
> +	sc = sdhci_priv(host);
> +
> +	return gpio_get_value(sc->pdata->wp_gpio);
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
> +	s3c_gpio_setpull(gpio_num, S3C_GPIO_PULL_UP);
> +}
> +
>  static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.get_timeout_clock	= sdhci_s3c_get_timeout_clk,
> @@ -311,6 +343,9 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	if (pdata->cfg_gpio)
>  		pdata->cfg_gpio(pdev, pdata->max_width);
> 
> +	if (pdata->wp_gpio)
> +		sdhci_s3c_ops.get_ro = sdhci_s3c_get_ro;
> +
>  	host->hw_name = "samsung-hsmmc";
>  	host->ops = &sdhci_s3c_ops;
>  	host->quirks = 0;
> @@ -335,6 +370,15 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
>  	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
>  			 SDHCI_QUIRK_32BIT_DMA_SIZE);
> 
> +	/* Controller's WP pin donsn't connected with SD card. So we allocate
> +	 * a GPIO for getting WP data from SD card and use that data as
> +	 * the return value of the get_ro function */
> +	host->quirks |= SDHCI_QUIRK_NO_WP_BIT;
> +
> +	/* to configure gpio pin as a card write protection signal */
> +	if (pdata->wp_gpio)
> +		sdhci_s3c_cfg_wp(pdata->wp_gpio);
> +

Assuming that pdata->wp_gpio == 0 means that the board has no additional wp
feature is wrong from the 'good and clean' API point of view. For example
GPIO_A0(0) pin for S5PV210 is gpio number 0. This would mean that it cannot
be used for this feature at all. 

I was told to use gpio_is_valid() macro and use -1 as 'invalid gpio' pin
number for implementing similar checks.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



