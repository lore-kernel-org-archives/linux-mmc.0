From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 4/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Tue, 19 Jan 2016 10:32:45 +0900
Message-ID: <569D923D.60306@samsung.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39238 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbcASBcz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 20:32:55 -0500
In-reply-to: <1453042744-16196-5-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 01/17/2016 11:59 PM, Stefan Wahren wrote:
> Scott Branden from Broadcom said that the BCM2835 eMMC IP core is
> very similar to IPROC and share most of the quirks. So use this driver
> instead of separate one.
> 
> The sdhci-iproc contains a better workaround for the clock domain
> crossing problem which doesn't need any delays. This results in a
> better write performance.
> 
> Btw we get the rid of the SDHCI_CAPABILITIES hack in the sdhci_readl
> function.
> 
> Suggested-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/mmc/host/Kconfig       |    6 +++---
>  drivers/mmc/host/sdhci-iproc.c |   20 ++++++++++++++++++--
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1526b8a..60de1e4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -318,15 +318,15 @@ config MMC_SDHCI_F_SDH30
>  	  If unsure, say N.
>  
>  config MMC_SDHCI_IPROC
> -	tristate "SDHCI platform support for the iProc SD/MMC Controller"
> -	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
> +	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
>  	depends on MMC_SDHCI_PLTFM
>  	default ARCH_BCM_IPROC
>  	select MMC_SDHCI_IO_ACCESSORS
>  	help
>  	  This selects the iProc SD/MMC controller.
>  
> -	  If you have an IPROC platform with SD or MMC devices,
> +	  If you have a BCM2835 or IPROC platform with SD or MMC devices,
>  	  say Y or M here.
>  
>  	  If unsure, say N.
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 55bc348..88399eb 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -167,7 +167,20 @@ static const struct sdhci_iproc_data iproc_data = {
>  	.caps1 = 0x00000064,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
> +	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
> +		| SDHCI_QUIRK_MISSING_CAPS,
> +	.ops = &sdhci_iproc_ops,
> +};
> +
> +static const struct sdhci_iproc_data bcm2835_data = {
> +	.pdata = &sdhci_bcm2835_pltfm_data,
> +	.caps = SDHCI_CAN_VDD_330,
> +	.caps1 = 0x00000000,
> +};
> +
>  static const struct of_device_id sdhci_iproc_of_match[] = {
> +	{ .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
>  	{ .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_data },
>  	{ }
>  };
> @@ -180,6 +193,7 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct sdhci_iproc_host *iproc_host;
>  	struct sdhci_pltfm_host *pltfm_host;
> +	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  
>  	match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
> @@ -199,8 +213,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  	mmc_of_parse(host->mmc);
>  	sdhci_get_of_property(pdev);
>  
> -	/* Enable EMMC 1/8V DDR capable */
> -	host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +	if (of_device_is_compatible(np, "brcm,sdhci-iproc-cygnus")) {
> +		/* Enable EMMC 1/8V DDR capable */
> +		host->mmc->caps |= MMC_CAP_1_8V_DDR;
> +	}

Why don't you use the property in device tree?
It can be parsed MMC_CAP_1_8V_DDR as property of "mmc-ddr-1_8v".

Best Regards,
Jaehoon Chung

>  
>  	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(pltfm_host->clk)) {
> 

