From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 08/12] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Mon, 10 Oct 2016 13:26:46 +0300
Message-ID: <b088db75-2b51-5038-038b-f7110f762f73@intel.com>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-9-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475678440-3525-9-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 05/10/16 17:40, Ritesh Harjani wrote:
> SDHC MSM controller need 2x clock for MCLK at GCC.
> Hence make required changes to have 2x clock for
> DDR timing modes.
> 
> Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/mmc/host/sdhci-msm.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9d18cf0..eb1a9e3 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -669,6 +669,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_ios curr_ios = host->mmc->ios;
>  	u32 msm_clock;
>  	int rc;
>  
> @@ -676,15 +677,29 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  		goto out;
>  
>  	spin_unlock_irq(&host->lock);
> -	if ((clock != msm_host->clk_rate) && msm_host->clk_table) {
> -		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
> +	if (((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
> +		(curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
> +		(curr_ios.timing == MMC_TIMING_MMC_HS400)) &&
> +		msm_host->clk_table) {
> +		/*
> +		 * The SDHC requires internal clock frequency to be double the
> +		 * actual clock that will be set for DDR mode. The controller
> +		 * uses the faster clock(100/400MHz) for some of its parts and
> +		 * send the actual required clock (50/200MHz) to the card.
> +		 */
> +		clock *= 2;
> +	}
> +	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
> +
> +	if ((msm_clock != msm_host->clk_rate) && msm_host->clk_table) {
>  		rc = clk_set_rate(msm_host->clk, msm_clock);
>  		if (rc) {
> -			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
> -				mmc_hostname(host->mmc), msm_clock, clock);
> +			pr_err("%s: failed to set clock at rate %u at timing %d\n",
> +				mmc_hostname(host->mmc), msm_clock,
> +				curr_ios.timing);
>  			goto out;
>  		}
> -		msm_host->clk_rate = clock;
> +		msm_host->clk_rate = msm_clock;
>  		pr_debug("%s: setting clock at rate %lu\n",
>  			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
>  	}
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
