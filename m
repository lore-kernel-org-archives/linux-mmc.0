From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Do not set MMC_CAP_1_8V_DDR in
 the 'no-1-8-v' case
Date: Fri, 12 Jun 2015 11:22:24 +0800
Message-ID: <20150612032223.GC16730@shlinux1.ap.freescale.net>
References: <1434060503-10260-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bbn0103.outbound.protection.outlook.com ([157.56.111.103]:50208
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750980AbbFLDlD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Jun 2015 23:41:03 -0400
Content-Disposition: inline
In-Reply-To: <1434060503-10260-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: ulf.hansson@linaro.org, aisheng.dong@freescale.com, kevin.lemoi@savant.com, otavio@ossystems.com.br, kernel@pengutronix.de, linux@arm.linux.org.uk, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, stable@vger.kernel.org

Hi Fabio,

On Thu, Jun 11, 2015 at 07:08:23PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit e2997c944dbdff3f ("mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR
> for mx6") the driver sets the MMC_CAP_1_8V_DDR flag unconditionally on
> mx6, but we should not do this when the 'no-1-8-v' property is passed via 
> device tree.
> 
> This causes the following errors when accessing eMMC on a mx6sl board:
> 
> mmc0: MAN_BKOPS_EN bit is not set
> mmc0: power class selection to bus width 8 ddr 4 failed
> mmc0: error -110 whilst initialising MMC card
> 
> So only set the MMC_CAP_1_8V_DDR flag when the 'no-1-8-v' property is
> absent.
> 
> With this fix in place it is possible to successfully mount the rootfs
> from the emmc on a mx6sl board which has 'no-1-8-v' property passed in the
> device tree.
> 
> Fixes: e2997c944dbdff3f ("mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6")
> Cc: stable@vger.kernel.org
> Reported-by: Kevin Lemoi <kevin.lemoi@savant.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I think this patch will break the eMMC DDR 3.3v mode support.

Looking at EXT_CSD_CARD_TYPE_DDR_1_8V definition,
#define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz */
                                             /* DDR mode @1.8V or 3V I/O */
it means the card can  run at DDR mode on either 3V or 1.8V IO.

This patch disable the DDR capability unconditionally if no 1.8v IO support.

But there's indeed some confusion in mmc core that comments of MMC_CAP_1_8V_DDR
only indicates 1.8V DDR mode support which probably could be improved.
#define MMC_CAP_1_8V_DDR        (1 << 11)       /* can support */
                                                /* DDR mode at 1.8V */

I guess why you issue passed with this change is because the DDR
mode is disabled.
Probably you need figure out why 3.3V DDR mode can't work for the board
in the issue, usually it's caused by timing, io pad setting and etc.

Regards
Dong Aisheng

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index faf0cb9..b562faf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1005,7 +1005,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (esdhc_is_usdhc(imx_data)) {
>  		writel(0x08100810, host->ioaddr + ESDHC_WTMK_LVL);
>  		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> -		host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  
>  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> @@ -1094,6 +1093,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	/* sdr50 and sdr104 needs work on 1.8v signal voltage */
>  	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
>  	    !IS_ERR(imx_data->pins_default)) {
> +		host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>  						ESDHC_PINCTRL_STATE_100MHZ);
>  		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
> -- 
> 1.9.1
> 
