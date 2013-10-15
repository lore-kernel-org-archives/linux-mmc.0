From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/5] mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
Date: Tue, 15 Oct 2013 08:49:11 +0200
Message-ID: <1381819751.4243.5.camel@weser.hi.pengutronix.de>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
	 <1381739024-24924-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42043 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab3JOGxN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 02:53:13 -0400
In-Reply-To: <1381739024-24924-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org

Am Montag, den 14.10.2013, 16:23 +0800 schrieb Shawn Guo:
> Add flag ESDHC_FLAG_ENGCM07207 for enabling the workaround for errata
> ENGcm07207 and set the flag for i.MX25 and i.MX35 ESDHC.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index e046917..a5d7d15 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -89,6 +89,11 @@
>   * exeception. Bit1 of Vendor Spec registor is used to fix it.
>   */
>  #define ESDHC_FLAG_MULTIBLK_NO_INT	BIT(1)
> +/*
> + * The flag enables the workaround for ESDHC errata ENGcm07207 which
> + * presents on i.MX25 and i.MX35.

s/presents/is present/

> + */
> +#define ESDHC_FLAG_ENGCM07207		BIT(2)
>  
>  enum imx_esdhc_type {
>  	IMX25_ESDHC,
> @@ -865,6 +870,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (is_imx25_esdhc(imx_data))
>  		imx_data->flags |= ESDHC_FLAG_NO_DMAS_BITS;
>  
> +	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
> +		imx_data->flags |= ESDHC_FLAG_ENGCM07207;
> +
>  	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
>  	if (IS_ERR(imx_data->clk_ipg)) {
>  		err = PTR_ERR(imx_data->clk_ipg);
> @@ -905,7 +913,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  
>  	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  
> -	if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
> +	if (imx_data->flags & ESDHC_FLAG_ENGCM07207)
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
>  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
>  			| SDHCI_QUIRK_BROKEN_ADMA;

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

