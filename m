From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCHv1 3/8] mmc: sdhci-msm: Factor out sdhci_msm_hs400
Date: Thu, 19 Jan 2017 12:04:55 +0200
Message-ID: <357a8e09-fb5f-ebb0-97d2-d9c7d9b6c763@intel.com>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
 <1484031652-12059-4-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6494 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbdASKWY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 05:22:24 -0500
In-Reply-To: <1484031652-12059-4-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de

On 10/01/17 09:00, Ritesh Harjani wrote:
> Factor out sdhci_msm_hs400 used for DLL calibration in HS400
> modes. This function will be needed for enhanced_strobe as well.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3fc496e..5a37c29 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -884,6 +884,28 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	return rc;
>  }
>  
> +/*
> + * sdhci_msm_hs400 - Calibrate the DLL for HS400 bus speed mode operation.
> + * DLL operation is only needed for clock > 100MHz. For clock <= 100MHz
> + * fixed feedback clock is used.
> + */
> +static void sdhci_msm_hs400(struct sdhci_host *host, struct mmc_ios *ios)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (host->clock > CORE_FREQ_100MHZ &&
> +	    msm_host->tuning_done && !msm_host->calibration_done) {
> +		ret = sdhci_msm_hs400_dll_calibration(host);
> +		if (!ret)
> +			msm_host->calibration_done = true;
> +		else
> +			pr_err("%s: Failed to calibrate DLL for hs400 mode (%d)\n",
> +			       mmc_hostname(host->mmc), ret);
> +	}
> +}
> +
>  static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  					unsigned int uhs)
>  {
> @@ -952,12 +974,10 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  
>  	spin_unlock_irq(&host->lock);
> -	/* CDCLP533 HW calibration is only required for HS400 mode*/
> -	if (host->clock > CORE_FREQ_100MHZ &&
> -	    msm_host->tuning_done && !msm_host->calibration_done &&
> -	    mmc->ios.timing == MMC_TIMING_MMC_HS400)
> -		if (!sdhci_msm_hs400_dll_calibration(host))
> -			msm_host->calibration_done = true;
> +
> +	if (mmc->ios.timing == MMC_TIMING_MMC_HS400)
> +		sdhci_msm_hs400(host, &mmc->ios);
> +
>  	spin_lock_irq(&host->lock);
>  }
>  
> 

