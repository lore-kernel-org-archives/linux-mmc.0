From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCHv1 7/8] mmc: sdhci-msm: Make HS400 tuning follow as
 per recommeneded HW sequence
Date: Thu, 19 Jan 2017 12:15:56 +0200
Message-ID: <468b4540-d64d-8ce6-03a4-33304fdd5413@intel.com>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
 <1484031652-12059-8-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61136 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbdASKYV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 05:24:21 -0500
In-Reply-To: <1484031652-12059-8-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de

On 10/01/17 09:00, Ritesh Harjani wrote:
> During tuning execution for HS400 mode, HW sequence recommends
> to select MCLK_SEL/2(0x3) in VENDOR_SPEC & sdhc msm clock at GCC
> to be 400MHZ (nearest supported clk). Add this change in tuning
> sequence during HS400 tuning.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

You may need to re-base this if you make changes as per patch 6, but otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 84d29dd..fa9bce3 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -151,7 +151,8 @@ static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
>  	 */
>  	if (ios.timing == MMC_TIMING_UHS_DDR50 ||
>  	    ios.timing == MMC_TIMING_MMC_DDR52 ||
> -	    ios.timing == MMC_TIMING_MMC_HS400)
> +	    ios.timing == MMC_TIMING_MMC_HS400 ||
> +	    host->flags & SDHCI_HS400_TUNING)
>  		clock *= 2;
>  	return clock;
>  }
> @@ -611,7 +612,8 @@ void sdhci_msm_hc_select_mode(struct sdhci_host *host)
>  {
>  	struct mmc_ios ios = host->mmc->ios;
>  
> -	if (ios.timing == MMC_TIMING_MMC_HS400)
> +	if (ios.timing == MMC_TIMING_MMC_HS400 ||
> +	    host->flags & SDHCI_HS400_TUNING)
>  		msm_hc_select_hs400(host);
>  	else
>  		msm_hc_select_default(host);
> @@ -831,6 +833,16 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	    ios.timing == MMC_TIMING_UHS_SDR104))
>  		return 0;
>  
> +	/*
> +	 * For HS400 tuning in HS200 timing requires:
> +	 * - select MCLK/2 in VENDOR_SPEC
> +	 * - program MCLK to 400MHz (or nearest supported) in GCC
> +	 */
> +	if (host->flags & SDHCI_HS400_TUNING) {
> +		sdhci_msm_hc_select_mode(host);
> +		msm_set_clock_rate_for_bus_mode(host, ios.clock);
> +	}
> +
>  retry:
>  	/* First of all reset the tuning block */
>  	rc = msm_init_cm_dll(host);
> 

