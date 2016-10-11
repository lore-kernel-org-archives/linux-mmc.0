From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: put together into one condition checking
Date: Tue, 11 Oct 2016 12:28:35 +0300
Message-ID: <d06587f1-096f-1aaf-6a31-56eb9f2688aa@intel.com>
References: <1475816923-24532-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28152 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751970AbcJKJdX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Oct 2016 05:33:23 -0400
In-Reply-To: <1475816923-24532-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

On 07/10/16 08:08, Jaehoon Chung wrote:
> value of ios->timing is not related with SDCHI v3.0.
> If Controller version is v3.0, SDHCI_QUIRK_NO_HISPD_BIT is meaningless.
> To prevent the setting wrong bit moves into one codntion checking.

codntion -> condition

> (e.g sdhci-s3c doesn't use SDHCI_CTRL_HISPD bit, instead using this bit as
>  other purpose.)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4805566..f854c66 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1619,7 +1619,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>  
>  	if ((ios->timing == MMC_TIMING_SD_HS ||
> -	     ios->timing == MMC_TIMING_MMC_HS)
> +	     ios->timing == MMC_TIMING_MMC_HS ||
> +	     ios->timing == MMC_TIMING_MMC_HS400 ||
> +	     ios->timing == MMC_TIMING_MMC_HS200 ||
> +	     ios->timing == MMC_TIMING_MMC_DDR52 ||
> +	     ios->timing == MMC_TIMING_UHS_SDR50 ||
> +	     ios->timing == MMC_TIMING_UHS_SDR104 ||
> +	     ios->timing == MMC_TIMING_UHS_DDR50 ||
> +	     ios->timing == MMC_TIMING_UHS_SDR25)
>  	    && !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
>  		ctrl |= SDHCI_CTRL_HISPD;
>  	else
> @@ -1628,16 +1635,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (host->version >= SDHCI_SPEC_300) {
>  		u16 clk, ctrl_2;
>  
> -		/* In case of UHS-I modes, set High Speed Enable */
> -		if ((ios->timing == MMC_TIMING_MMC_HS400) ||
> -		    (ios->timing == MMC_TIMING_MMC_HS200) ||
> -		    (ios->timing == MMC_TIMING_MMC_DDR52) ||
> -		    (ios->timing == MMC_TIMING_UHS_SDR50) ||
> -		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
> -		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
> -		    (ios->timing == MMC_TIMING_UHS_SDR25))
> -			ctrl |= SDHCI_CTRL_HISPD;
> -
>  		if (!host->preset_enabled) {
>  			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>  			/*
> 

