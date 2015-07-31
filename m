From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v3 5/6] mmc: sdhci-esdhc-imx: config watermark level
 and burst length
Date: Fri, 31 Jul 2015 22:55:17 +0800
Message-ID: <20150731145516.GF27806@shlinux1.ap.freescale.net>
References: <1438160637-28061-1-git-send-email-haibo.chen@freescale.com>
 <1438160637-28061-6-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:7536
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751566AbbGaPEK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Jul 2015 11:04:10 -0400
Content-Disposition: inline
In-Reply-To: <1438160637-28061-6-git-send-email-haibo.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, ulf.hansson@linaro.org, johan.derycke@barco.com, fabio.estevam@freescale.com, b29396@freescale.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Wed, Jul 29, 2015 at 05:03:56PM +0800, Haibo Chen wrote:
> i.MX7D support eMMC HS400 mode, this mode can run in 8 bit,200MHZ
> DDR mode. So the I/O speed improve a lot compare to SD3.0
> 
> The default burst length is 8, if we don't change this value, in
> HS400 mode, when we do eMMC read operation, we can find that the
> clock signal will stop for a period of time. This means the speed
> of data moving on AHB bus is slower than I/O speed. So we should
> improve the speed of data moving on AHB bus.
> 
> For imx7d usdhc, this patch set the burst length as 16, and set
> watermark level as 64. The test result is the clock signal has
> no stop during the eMMC HS400 operation. For other imx usdhc, remain
> the default value: burst length as 8, watermark level as 16.
> 

Add please change patch title a bit since this patch change is actually
for mx7d:

mmc: sdhci-esdhc-imx: change watermark level and burst length for imx7d

Regards
Dong Aisheng

> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 158f93b..37d0095 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -239,6 +239,11 @@ static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
>  	return data->socdata == &usdhc_imx6q_data;
>  }
>  
> +static inline int is_imx7d_usdhc(struct pltfm_imx_data *data)
> +{
> +	return data->socdata == &usdhc_imx7d_data;
> +}
> +
>  static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
>  {
>  	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
> @@ -1145,7 +1150,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	 * to something insane.  Change it back here.
>  	 */
>  	if (esdhc_is_usdhc(imx_data)) {
> -		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
> +		if (is_imx7d_usdhc(imx_data))
> +			writel(0x10401040, host->ioaddr + ESDHC_WTMK_LVL);
> +		else
> +			writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
> +
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
>  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  
> -- 
> 1.9.1
> 
