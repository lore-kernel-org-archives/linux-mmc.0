From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 8/9] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Mon, 29 Aug 2016 16:17:53 +0300
Message-ID: <f63dd056-d279-7ca9-50d2-668223575161@intel.com>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
 <1472033024-14890-9-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1472033024-14890-9-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 24/08/16 13:03, Ritesh Harjani wrote:
> SDHC MSM controller need 2x clock for MCLK at GCC.
> Hence make required changes to have 2x clock for
> DDR timing modes.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 853639b..538594c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -667,21 +667,35 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> -	u32 msm_clock = 0;
> +	struct mmc_ios curr_ios = host->mmc->ios;
> +	u32 msm_clock, ddr_clock;
>  	int rc = 0;
>  
>  	if (!clock)
>  		goto out;
>  
> -	if (clock != msm_host->clk_rate) {
> -		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
> +	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
> +	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
> +		(curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
> +		(curr_ios.timing == MMC_TIMING_MMC_HS400)) {
> +		/*
> +		 * The SDHC requires internal clock frequency to be double the
> +		 * actual clock that will be set for DDR mode. The controller
> +		 * uses the faster clock(100/400MHz) for some of its parts and
> +		 * send the actual required clock (50/200MHz) to the card.
> +		 */
> +		ddr_clock = clock * 2;
> +		msm_clock = sdhci_msm_get_msm_clk_rate(host, ddr_clock);
> +	}
> +

Could be slightly simpler e.g.

	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
	    (curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
	    (curr_ios.timing == MMC_TIMING_MMC_HS400)) {
		/*
		 * The SDHC requires internal clock frequency to be double the
		 * actual clock that will be set for DDR mode. The controller
		 * uses the faster clock(100/400MHz) for some of its parts and
		 * send the actual required clock (50/200MHz) to the card.
		 */
		clock *= 2;
	}
	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);


> +	if (msm_clock != msm_host->clk_rate) {
>  		rc = clk_set_rate(msm_host->clk, msm_clock);
>  		if (rc) {
>  			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
>  				mmc_hostname(host->mmc), msm_clock, clock);
>  			goto out;
>  		}
> -		msm_host->clk_rate = clock;
> +		msm_host->clk_rate = msm_clock;
>  		pr_debug("%s: setting clock at rate %lu\n",
>  			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
>  	}
> 
