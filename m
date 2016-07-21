From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 15/15] mmc: sdhci-esdhc-imx: clear tuning bits during
 driver probe
Date: Thu, 21 Jul 2016 11:33:02 +0300
Message-ID: <579088BE.9090207@intel.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-16-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46361 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbcGUIhV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2016 04:37:21 -0400
In-Reply-To: <1468309584-3591-16-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 12/07/16 10:46, Dong Aisheng wrote:
> The tuning bits like FBCLK_SEL, SMP_CLK_SEL and DLY_CELL which affects
> timing may have already been set by ROM if booting from SD3.0 mode like
> SDR104. Let's clear it first during driver probe before doing the new
> card enumeration to avoid working on the wrong timing.
> 
> Note that tuning bits are dynamical settings which may need to be kept
> during MMC_PM_KEEP_POWER suspend, so we did not put them into hwinit
> function.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>


Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index e5b5d1c3eb01..2bb326bbc34a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1224,6 +1224,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  		host->mmc->caps |= MMC_CAP_1_8V_DDR;
>  		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>  			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> +
> +		/* clear tuning bits in case ROM has set it already */
> +		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
> +		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
> +		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  	}
>  
>  	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
> 

