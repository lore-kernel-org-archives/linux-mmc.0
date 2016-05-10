From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 11/23] mmc: sdhci-esdhci-imx: remove
 SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
Date: Tue, 10 May 2016 12:30:02 +0300
Message-ID: <5731AA1A.9000504@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-12-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2131 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbcEJJd5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2016 05:33:57 -0400
In-Reply-To: <1460741387-23815-12-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com, dongas86@gmail.com

On 15/04/16 20:29, Dong Aisheng wrote:
> The driver has already implemented the private .set_timeout()
> callback for common SDHCI code to do correct timeout value setting,
> it does not need call sdhci_calc_timeout(), so this quirk actually
> is not working. Remove it now.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Pedantically, the subject needs:

	sdhci-esdhci-imx -> sdhci-esdhc-imx

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 2d300d8..03980db 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1147,8 +1147,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>  	if (IS_ERR(imx_data->pins_default))
>  		dev_warn(mmc_dev(host->mmc), "could not get default state\n");
>  
> -	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> -
>  	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
>  		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
>  		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
> 

