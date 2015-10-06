From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt
 platform
Date: Tue, 06 Oct 2015 15:15:42 -0700
Message-ID: <2333b5f060a8e45bd8adcdab55365fab@agner.ch>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
 <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:41015 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbbJFWQn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 18:16:43 -0400
In-Reply-To: <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: linux-mmc@vger.kernel.org, fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@karo-electronics.de, ipaton0@gmail.com, linux-mmc-owner@vger.kernel.org

Hi Dong,

Just hit that issue in 4.1, could we add that patch also to stable?

--
Stefan

On 2015-07-22 05:53, Dong Aisheng wrote:
> Current card detect probe process is that when driver finds a valid
> ESDHC_CD_GPIO, it will clear the quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION
> which is set by default for all esdhc/usdhc controllers.
> Then host driver will know there's a valid card detect function.
> 
> Commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
> breaks GPIO CD function for dt platform that it will return directly
> when find ESDHC_CD_GPIO for dt platform which result in the later wrongly
> to keep SDHCI_QUIRK_BROKEN_CARD_DETECTION for all dt platforms.
> Then MMC_CAP_NEEDS_POLL will be used instead even there's a valid
> GPIO card detect.
> 
> This patch adds back this function and follows the original approach to
> clear the quirk if find an valid CD GPIO for dt platforms.
> 
> Fixes: 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
> Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> index faf0cb9..4815391 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -881,6 +881,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  			 struct esdhc_platform_data *boarddata)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	int ret;
>  
>  	if (!np)
>  		return -ENODEV;
> @@ -917,7 +918,14 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  	mmc_of_parse_voltage(np, &host->ocr_mask);
>  
>  	/* call to generic mmc_of_parse to support additional capabilities */
> -	return mmc_of_parse(host->mmc);
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret)
> +		return ret;
> +
> +	if (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
> +		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +	return 0;
>  }
>  #else
>  static inline int

