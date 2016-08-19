From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v3 8/9] mmc: sdhci-msm: Add clock changes for DDR mode.
Date: Fri, 19 Aug 2016 18:56:31 +0530
Message-ID: <23f3d9df-671b-ae81-d340-3cc858a94782@codeaurora.org>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
 <1471581384-18961-9-git-send-email-riteshh@codeaurora.org>
 <dd0f734c-6179-5083-5e81-a8a49d7afa4e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51944 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbcHSN0l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2016 09:26:41 -0400
In-Reply-To: <dd0f734c-6179-5083-5e81-a8a49d7afa4e@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org

Hi Adrian,

Thanks for the review.

On 8/19/2016 6:34 PM, Adrian Hunter wrote:
> On 19/08/16 07:36, Ritesh Harjani wrote:
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
>> index c0ad9c2..f0e6293 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -661,21 +661,35 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> -	u32 msm_clock = 0;
>> +	struct mmc_ios curr_ios = host->mmc->ios;
>> +	u32 msm_clock = clock, ddr_clock = 0;
>
> Don't need to initialize msm_clock or ddr_clock
Sure. Will do that.


>
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
