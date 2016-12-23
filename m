From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH 3/4] mmc: mmc: enable ios.enhanced_strobe before
 mmc_set_timing
Date: Fri, 23 Dec 2016 14:48:57 +0530
Message-ID: <2bb5dca4-faad-fc93-1dfb-18d1e1e72961@codeaurora.org>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
 <1482213199-29152-4-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1482213199-29152-4-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

Do you think, below change should be fine?
I am still checking on what we discussed on Patch2.

why I am asking is because - for HS400 in SDHC-MSM, we do the DLL 
re-calibration as per the HW sequence. So it is done in both the cases, 
for HS400 mode without and with enhanced strobe mode.

This can be done as part of set_ios when mmc_set_timing is called in 
sdhci-msm driver.

I am still trying to check more on what would be more generic and 
appropriate way inside sdhci-msm, for that I would like to know if 
ios.enhanced_strobe = true before calling mmc_set_timing should be 
acceptable or not ?


Regards
Ritesh

On 12/20/2016 11:23 AM, Ritesh Harjani wrote:
> Some controllers may need to configure few registers based on enhanced
> strobe mode while configuring to HS400 timing, thus make
> ios.enhanced_strobe to true before mmc_set_timing in mmc_select_hs400es.
>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/core/mmc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index eb69497..052368e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1327,12 +1327,18 @@ static int mmc_select_hs400es(struct mmc_card *card)
>  		goto out_err;
>  	}
>
> +	/*
> +	 * Enable enhanced_strobe in ios, as some controllers
> +	 * may need to configure few registers based on enhanced
> +	 * strobe while changing HS400 timing.
> +	 */
> +	host->ios.enhanced_strobe = true;
> +
>  	/* Set host controller to HS400 timing and frequency */
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>  	mmc_set_bus_speed(card);
>
>  	/* Controller enable enhanced strobe function */
> -	host->ios.enhanced_strobe = true;
>  	if (host->ops->hs400_enhanced_strobe)
>  		host->ops->hs400_enhanced_strobe(host, &host->ios);
>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
