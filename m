From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 09/14] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Tue, 8 Nov 2016 14:20:45 +0200
Message-ID: <1a3a30ee-a0f0-25a0-1e3a-9097ee3012df@intel.com>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-10-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:43648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933001AbcKHMZy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 8 Nov 2016 07:25:54 -0500
In-Reply-To: <1478517877-23733-10-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org

On 07/11/16 13:24, Ritesh Harjani wrote:
> SDHC MSM controller need 2x clock for MCLK at GCC.
> Hence make required changes to have 2x clock for
> DDR timing modes.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index ff0915b..220567c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -633,6 +633,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_ios curr_ios = host->mmc->ios;
>  	int rc;
>  
>  	if (!clock) {
> @@ -641,11 +642,23 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  
>  	spin_unlock_irq(&host->lock);
> +	/*
> +	 * The SDHC requires internal clock frequency to be double the
> +	 * actual clock that will be set for DDR mode. The controller
> +	 * uses the faster clock(100/400MHz) for some of its parts and
> +	 * send the actual required clock (50/200MHz) to the card.
> +	 */
> +	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
> +	    (curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
> +	    (curr_ios.timing == MMC_TIMING_MMC_HS400))
> +		clock *= 2;
> +
>  	if (clock != msm_host->clk_rate) {
>  		rc = clk_set_rate(msm_host->clk, clock);
>  		if (rc) {
> -			pr_err("%s: Failed to set clock at rate %u\n",
> -			       mmc_hostname(host->mmc), clock);
> +			pr_err("%s: Failed to set clock at rate %u at timing %d\n",
> +			       mmc_hostname(host->mmc), clock,
> +			       curr_ios.timing);
>  			spin_lock_irq(&host->lock);
>  			goto out;
>  		}
> 

