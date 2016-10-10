From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 07/12] mmc: sdhci-msm: Implement set_clock callback for
 sdhci-msm
Date: Mon, 10 Oct 2016 16:47:56 +0530
Message-ID: <a3bad2ce-be3f-aab9-ace7-2874e25ffa3a@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-8-git-send-email-riteshh@codeaurora.org>
 <20faeedb-ae65-fab7-f52f-aaec2aebe755@intel.com>
 <d35224cf-52e0-5ccc-9596-1c338df41c36@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d35224cf-52e0-5ccc-9596-1c338df41c36-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,


On 10/10/2016 3:53 PM, Adrian Hunter wrote:
> On 10/10/16 13:16, Adrian Hunter wrote:
>> On 05/10/16 17:40, Ritesh Harjani wrote:
>>> sdhci-msm controller may have different clk-rates for each
>>> bus speed mode. Thus implement set_clock callback for
>>> sdhci-msm driver.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>> ---
>>>  drivers/mmc/host/sdhci-msm.c | 110 ++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 109 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>> index 542ddad..9d18cf0 100644
>>> --- a/drivers/mmc/host/sdhci-msm.c
>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>> @@ -84,6 +84,7 @@ struct sdhci_msm_host {
>>>  	struct clk *bus_clk;	/* SDHC bus voter clock */
>>>  	u32 *clk_table;
>>>  	int clk_table_sz;
>>> +	u32 clk_rate;
>>>  	struct mmc_host *mmc;
>>>  	bool use_14lpp_dll_reset;
>>>  };
>>> @@ -588,6 +589,113 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
>>>  	}
>>>  }
>>>
>>> +static unsigned int sdhci_msm_get_msm_clk_rate(struct sdhci_host *host,
>>> +					u32 req_clk)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>> +	int count;
>>> +	unsigned int sel_clk = -1;
>>> +
>>> +	if (!msm_host->clk_table)
>>> +		return clk_round_rate(msm_host->clk, ULONG_MAX);
>>> +
>>> +	count = msm_host->clk_table_sz;
>>> +
>>> +	while (count--) {
>>> +		sel_clk = msm_host->clk_table[count];
>>> +		if (req_clk >= sel_clk)
>>> +			return sel_clk;
>>> +	}
>>> +
>>> +	return sel_clk;
>>> +}
>>> +
>>> +/**
>>> + * __sdhci_msm_set_clock - sdhci_msm clock control.
>>> + *
>>> + * Description:
>>> + * Implement MSM version of sdhci_set_clock.
>>> + * This is required since MSM controller does not
>>> + * use internal divider and instead directly control
>>> + * the GCC clock as per HW recommendation.
>>> + **/
>>> +void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>> +{
>>> +	u16 clk;
>>> +	unsigned long timeout;
>>> +
>>> +	/*
>>> +	 * Keep actual_clock as zero -
>>> +	 * - since there is no divider used so no need of having actual_clock.
>>> +	 * - MSM controller uses SDCLK for data timeout calculation. If
>>> +	 *   actual_clock is zero, host->clock is taken for calculation.
>>> +	 */
>>> +	host->mmc->actual_clock = 0;
>>> +
>>> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>>> +
>>> +	if (clock == 0)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * MSM controller do not use clock divider.
>>> +	 * Thus read SDHCI_CLOCK_CONTROL and only enable
>>> +	 * clock with no divider value programmed.
>>> +	 */
>>> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>> +
>>> +	clk |= SDHCI_CLOCK_INT_EN;
>>> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>> +
>>> +	/* Wait max 20 ms */
>>> +	timeout = 20;
>>> +	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>>> +		& SDHCI_CLOCK_INT_STABLE)) {
>>> +		if (timeout == 0) {
>>> +			pr_err("%s: Internal clock never stabilised.\n",
>>> +			       mmc_hostname(host->mmc));
>>> +			return;
>>> +		}
>>> +		timeout--;
>>> +		mdelay(1);
>>> +	}
>>> +
>>> +	clk |= SDHCI_CLOCK_CARD_EN;
>>> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>> +}
>>> +
>>> +static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>> +	u32 msm_clock;
>>> +	int rc;
>>> +
>>> +	if (!clock)
>>
>> Wouldn't you still need to set msm_host->clk_rate = clock in this case
Yes. Will do that.

>>
>>> +		goto out;
>>> +
>>> +	spin_unlock_irq(&host->lock);
>>> +	if ((clock != msm_host->clk_rate) && msm_host->clk_table) {
>>> +		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
>>> +		rc = clk_set_rate(msm_host->clk, msm_clock);
>>> +		if (rc) {
>>> +			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
>>> +				mmc_hostname(host->mmc), msm_clock, clock);
>>> +			goto out;
>
> 'goto out' leaves spinlock unlocked
Thanks for catching it.

>
>>> +		}
>>> +		msm_host->clk_rate = clock;
>>> +		pr_debug("%s: setting clock at rate %lu\n",
>>> +			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
>>> +	}
>>> +
>>> +	spin_lock_irq(&host->lock);
>>> +out:
>>> +	if (!msm_host->clk_table)
>>> +		return sdhci_set_clock(host, clock);
>>
>> Could put the above 2 lines at the start and then no need to check
>> msm_host->clk_table again.
I wanted to make this change, but then may be because of later patches 
which modifies sdhci_msm_set_clock for UHS modes, I did not move this to 
top.
I reviewed that part again, I will make the necessary changes.
Thanks.


>>
>>> +	__sdhci_msm_set_clock(host, clock);
>>> +}
>>> +
>>>  static const struct of_device_id sdhci_msm_dt_match[] = {
>>>  	{ .compatible = "qcom,sdhci-msm-v4" },
>>>  	{},
>>> @@ -598,7 +706,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>>>  static const struct sdhci_ops sdhci_msm_ops = {
>>>  	.platform_execute_tuning = sdhci_msm_execute_tuning,
>>>  	.reset = sdhci_reset,
>>> -	.set_clock = sdhci_set_clock,
>>> +	.set_clock = sdhci_msm_set_clock,
>>>  	.get_min_clock = sdhci_msm_get_min_clock,
>>>  	.get_max_clock = sdhci_msm_get_max_clock,
>>>  	.set_bus_width = sdhci_set_bus_width,
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
