From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: fix SDHCI_QUIRK_NO_HISPD_BIT handling
Date: Mon, 14 Aug 2017 14:34:26 +0300
Message-ID: <5ef4d0ff-7a97-3616-aeb1-e39ce096d038@intel.com>
References: <1502256755-37752-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52415 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752843AbdHNLkx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Aug 2017 07:40:53 -0400
In-Reply-To: <1502256755-37752-1-git-send-email-yangbo.lu@nxp.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 09/08/17 08:32, Yangbo Lu wrote:
> SD controller with SDHCI_QUIRK_NO_HISPD_BIT quirk probably
> use high speed enable bit for other purpose. So this bit
> shouldn't be changed for high speed enabling for this type of
> SD controller.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Apart from the duplicate parenthesis.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a1ad2dd..25393b9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1641,19 +1641,20 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
> -	if ((ios->timing == MMC_TIMING_SD_HS ||
> -	     ios->timing == MMC_TIMING_MMC_HS ||
> -	     ios->timing == MMC_TIMING_MMC_HS400 ||
> -	     ios->timing == MMC_TIMING_MMC_HS200 ||
> -	     ios->timing == MMC_TIMING_MMC_DDR52 ||
> -	     ios->timing == MMC_TIMING_UHS_SDR50 ||
> -	     ios->timing == MMC_TIMING_UHS_SDR104 ||
> -	     ios->timing == MMC_TIMING_UHS_DDR50 ||
> -	     ios->timing == MMC_TIMING_UHS_SDR25)
> -	    && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
> -		ctrl |= SDHCI_CTRL_HISPD;
> -	else
> -		ctrl &= ~SDHCI_CTRL_HISPD;
> +	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
> +		if ((ios->timing == MMC_TIMING_SD_HS ||

Duplicate parenthesis.

> +		     ios->timing == MMC_TIMING_MMC_HS ||
> +		     ios->timing == MMC_TIMING_MMC_HS400 ||
> +		     ios->timing == MMC_TIMING_MMC_HS200 ||
> +		     ios->timing == MMC_TIMING_MMC_DDR52 ||
> +		     ios->timing == MMC_TIMING_UHS_SDR50 ||
> +		     ios->timing == MMC_TIMING_UHS_SDR104 ||
> +		     ios->timing == MMC_TIMING_UHS_DDR50 ||
> +		     ios->timing == MMC_TIMING_UHS_SDR25))
> +			ctrl |= SDHCI_CTRL_HISPD;
> +		else
> +			ctrl &= ~SDHCI_CTRL_HISPD;
> +	}
>  
>  	if (host->version >= SDHCI_SPEC_300) {
>  		u16 clk, ctrl_2;
> 

