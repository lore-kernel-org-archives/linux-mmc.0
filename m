From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v4 8/9] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Tue, 30 Aug 2016 19:46:30 +0530
Message-ID: <ec736d43-6c2c-36af-d5fd-ec31d808f9ec@codeaurora.org>
References: <1472033024-14890-1-git-send-email-riteshh@codeaurora.org>
 <1472033024-14890-9-git-send-email-riteshh@codeaurora.org>
 <f63dd056-d279-7ca9-50d2-668223575161@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbcH3OQk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 10:16:40 -0400
In-Reply-To: <f63dd056-d279-7ca9-50d2-668223575161@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, bjorn.andersson@linaro.org

Hi Adrian,


On 8/29/2016 6:47 PM, Adrian Hunter wrote:
> On 24/08/16 13:03, Ritesh Harjani wrote:
>> SDHC MSM controller need 2x clock for MCLK at GCC.
>> Hence make required changes to have 2x clock for
>> DDR timing modes.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  drivers/mmc/host/sdhci-msm.c | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 853639b..538594c 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -667,21 +667,35 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> -	u32 msm_clock = 0;
>> +	struct mmc_ios curr_ios = host->mmc->ios;
>> +	u32 msm_clock, ddr_clock;
>>  	int rc = 0;
>>
>>  	if (!clock)
>>  		goto out;
>>
>> -	if (clock != msm_host->clk_rate) {
>> -		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
>> +	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
>> +	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
>> +		(curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
>> +		(curr_ios.timing == MMC_TIMING_MMC_HS400)) {
>> +		/*
>> +		 * The SDHC requires internal clock frequency to be double the
>> +		 * actual clock that will be set for DDR mode. The controller
>> +		 * uses the faster clock(100/400MHz) for some of its parts and
>> +		 * send the actual required clock (50/200MHz) to the card.
>> +		 */
>> +		ddr_clock = clock * 2;
>> +		msm_clock = sdhci_msm_get_msm_clk_rate(host, ddr_clock);
>> +	}
>> +
>
> Could be slightly simpler e.g.
>
> 	if ((curr_ios.timing == MMC_TIMING_UHS_DDR50) ||
> 	    (curr_ios.timing == MMC_TIMING_MMC_DDR52) ||
> 	    (curr_ios.timing == MMC_TIMING_MMC_HS400)) {
> 		/*
> 		 * The SDHC requires internal clock frequency to be double the
> 		 * actual clock that will be set for DDR mode. The controller
> 		 * uses the faster clock(100/400MHz) for some of its parts and
> 		 * send the actual required clock (50/200MHz) to the card.
> 		 */
> 		clock *= 2;
> 	}
> 	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
Sure. Done.

>
>
>> +	if (msm_clock != msm_host->clk_rate) {
>>  		rc = clk_set_rate(msm_host->clk, msm_clock);
>>  		if (rc) {
>>  			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
>>  				mmc_hostname(host->mmc), msm_clock, clock);
>>  			goto out;
>>  		}
>> -		msm_host->clk_rate = clock;
>> +		msm_host->clk_rate = msm_clock;
>>  		pr_debug("%s: setting clock at rate %lu\n",
>>  			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
>>  	}
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
