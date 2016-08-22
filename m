From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v3 7/9] mmc: sdhci-msm: Implement set_clock callback for
 sdhci-msm
Date: Mon, 22 Aug 2016 18:26:17 +0530
Message-ID: <0dc5e388-dbc3-6179-6b27-c35afffd6bb8@codeaurora.org>
References: <1471581384-18961-1-git-send-email-riteshh@codeaurora.org>
 <1471581384-18961-8-git-send-email-riteshh@codeaurora.org>
 <4e1be7e8-ad6e-b52f-d5ad-258a6d4ed41d@intel.com>
 <614e25fb-34ad-285d-2abc-0748c89a9c0a@codeaurora.org>
 <47795735-66ae-5382-77fa-7906833aada0@intel.com>
 <abd3da08-f74b-8a19-89c9-6fed4a99c9c9@codeaurora.org>
 <9200ab14-ffdc-8a50-51e2-0572dcea6b95@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <9200ab14-ffdc-8a50-51e2-0572dcea6b95@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, bjorn.andersson@linaro.org, shawn.lin@rock-chips.com, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,


On 8/22/2016 2:59 PM, Adrian Hunter wrote:
> On 22/08/16 12:07, Ritesh Harjani wrote:
>> Hi Adrian,
>>
>>
>> On 8/22/2016 11:50 AM, Adrian Hunter wrote:
>>> On 19/08/16 16:31, Ritesh Harjani wrote:
>>>> Hi,
>>>>
>>>>
>>>> On 8/19/2016 6:34 PM, Adrian Hunter wrote:
>>>>> On 19/08/16 07:36, Ritesh Harjani wrote:
>>>>>> sdhci-msm controller may have different clk-rates for each
>>>>>> bus speed mode. Thus implement set_clock callback for
>>>>>> sdhci-msm driver.
>>>>>>
>>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>>>> ---
>>>>>>  drivers/mmc/host/sdhci-msm.c | 103
>>>>>> ++++++++++++++++++++++++++++++++++++++++++-
>>>>>>  1 file changed, 102 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>>>>>> index 7c032c3..c0ad9c2 100644
>>>>>> --- a/drivers/mmc/host/sdhci-msm.c
>>>>>> +++ b/drivers/mmc/host/sdhci-msm.c
>>>>>> @@ -89,6 +89,7 @@ struct sdhci_msm_host {
>>>>>>      struct mmc_host *mmc;
>>>>>>      bool use_14lpp_dll_reset;
>>>>>>      struct sdhci_msm_pltfm_data *pdata;
>>>>>> +    u32 clk_rate;
>>>>>>  };
>>>>>>
>>>>>>  /* Platform specific tuning */
>>>>>> @@ -582,6 +583,106 @@ static unsigned int sdhci_msm_get_min_clock(struct
>>>>>> sdhci_host *host)
>>>>>>      return msm_host->pdata->clk_table[0];
>>>>>>  }
>>>>>>
>>>>>> +static unsigned int sdhci_msm_get_msm_clk_rate(struct sdhci_host *host,
>>>>>> +                    u32 req_clk)
>>>>>> +{
>>>>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +    struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>>>>> +    int count = msm_host->pdata->clk_table_sz;
>>>>>> +    unsigned int sel_clk = -1;
>>>>>> +    int cnt;
>>>>>> +
>>>>>> +    if (req_clk < sdhci_msm_get_min_clock(host)) {
>>>>>> +        sel_clk = sdhci_msm_get_min_clock(host);
>>>>>> +        return sel_clk;
>>>>>> +    }
>>>>>> +
>>>>>> +    for (cnt = 0; cnt < count; cnt++) {
>>>>>> +        if (msm_host->pdata->clk_table[cnt] > req_clk) {
>>>>>> +            break;
>>>>>> +        } else if (msm_host->pdata->clk_table[cnt] == req_clk) {
>>>>>> +            sel_clk = msm_host->pdata->clk_table[cnt];
>>>>>> +            break;
>>>>>> +        } else {
>>>>>> +            sel_clk = msm_host->pdata->clk_table[cnt];
>>>>>> +        }
>>>>>> +    }
>>>>>
>>>>> 'else' is not needed after 'break' but can't this be simpler e.g.
>>>>>
>>>>> static unsigned int sdhci_msm_get_msm_clk_rate(struct sdhci_msm_host
>>>>> *msm_host, u32 req_clk)
>>>>> {
>>>>>     int count = msm_host->pdata->clk_table_sz;
>>>>>     unsigned int sel_clk = -1;
>>>>>
>>>>>     while (count--) {
>>>>>         sel_clk = msm_host->pdata->clk_table[count];
>>>>>         if (req_clk >= sel_clk)
>>>>>             return sel_clk;
>>>>>     }
>>>>>
>>>>>     return sel_clk;
>>>>> }
>>>>
>>>> Ok, sure I will check and get back on this.
>>>>
>>>>
>>>>>
>>>>>
>>>>>> +    return sel_clk;
>>>>>> +}
>>>>>
>>>>> Blank line needed
>>>> Ok done.
>>>>
>>>>>
>>>>>> +/**
>>>>>> + * __sdhci_msm_set_clock - sdhci_msm clock control.
>>>>>> + *
>>>>>> + * Description:
>>>>>> + * Implement MSM version of sdhci_set_clock.
>>>>>> + * This is required since MSM controller does not
>>>>>> + * use internal divider and instead directly control
>>>>>> + * the GCC clock as per HW recommendation.
>>>>>> + **/
>>>>>> +void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>>> +{
>>>>>> +    u16 clk;
>>>>>> +    unsigned long timeout;
>>>>>> +
>>>>>> +    host->mmc->actual_clock = 0;
>>>>>> +
>>>>>> +    sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>>>>>> +
>>>>>> +    if (clock == 0)
>>>>>> +        return;
>>>>>
>>>>> Should set host->mmc->actual_clock to the actual rate somewhere.
>>>> Since MSM controller does not uses divider then there is no need of having
>>>> actual clock since it should be same as host->clock.
>>>
>>> Ok, so sdhci_msm_get_msm_clk_rate() is not the actual clock rate?
>> So I was assuming we need host->mmc->actual_clock rate if host->clock is not
>> the actual rate.
>> Ok, so I will update actual_clock to host->clock itself.
>>
>> pls, let me know if any concerns.
>
> I am confused.  Isn't clk_get_rate(msm_host->clk) the actual clock rate?

Actually, msm controller have few quirks around clocks itself and
I was thinking of not using actual_clock to avoid adding any extra 
quirks for msm.

If you see if actual_clock is 0 and if 
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set, timeout_clk take host->clock 
for timeout calculation.

That's one reason I did not want to update the host->actual_clock. 
(otherwise timeout calc will go wrong for DDR modes for msm, where clock 
from GCC is made double of host->clock and internally divided by 
controller on it's own. In this case actual_clock would be shown as 2x 
of host->clock).
Do you think that keeping actual_clock to 0 should be fine in this case?


I have not yet worked over timeout calculation patches yet, since it is 
of lower priority in my list. After few other areas (mostly HS400), I 
will take over clock timeout fixes to be up-streamed.

>
>>>
>>>>
>>>> That's why I had kept it 0 intentionally. But I will add a comment
>>>> here then.
>>>>
>>>>>
>>>>>> +
>>>>>> +    /*
>>>>>> +     * MSM controller do not use clock divider.
>>>>>> +     * Thus read SDHCI_CLOCK_CONTROL and only enable
>>>>>> +     * clock with no divider value programmed.
>>>>>> +     */
>>>>>> +    clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>>>>> +
>>>>>> +    clk |= SDHCI_CLOCK_INT_EN;
>>>>>> +    sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>>>>> +
>>>>>> +    /* Wait max 20 ms */
>>>>>> +    timeout = 20;
>>>>>> +    while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>>>>>> +        & SDHCI_CLOCK_INT_STABLE)) {
>>>>>> +        if (timeout == 0) {
>>>>>> +            pr_err("%s: Internal clock never stabilised.\n",
>>>>>> +                   mmc_hostname(host->mmc));
>>>>>> +            return;
>>>>>> +        }
>>>>>> +        timeout--;
>>>>>> +        mdelay(1);
>>>>>> +    }
>>>>>> +
>>>>>> +    clk |= SDHCI_CLOCK_CARD_EN;
>>>>>> +    sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>>>>> +}
>>>>>> +
>>>>>> +static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int
>>>>>> clock)
>>>>>> +{
>>>>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>> +    struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>>>>> +    u32 msm_clock = 0;
>>>>>> +    int rc = 0;
>>>>>> +
>>>>>> +    if (!clock)
>>>>>> +        goto out;
>>>>>> +
>>>>>> +    if (clock != msm_host->clk_rate) {
>>>>>> +        msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
>>>>>> +        rc = clk_set_rate(msm_host->clk, msm_clock);
>>>>>> +        if (rc) {
>>>>>> +            pr_err("%s: failed to set clock at rate %u, requested clock
>>>>>> rate %u\n",
>>>>>> +                mmc_hostname(host->mmc), msm_clock, clock);
>>>>>> +            goto out;
>>>>>> +        }
>>>>>> +        msm_host->clk_rate = clock;
>>>>>> +        pr_debug("%s: setting clock at rate %lu\n",
>>>>>> +            mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
>>>>>> +    }
>>>>>> +out:
>>>>>> +    __sdhci_msm_set_clock(host, clock);
>>>>>> +}
>>>>>> +
>>>>>>  static const struct of_device_id sdhci_msm_dt_match[] = {
>>>>>>      { .compatible = "qcom,sdhci-msm-v4" },
>>>>>>      {},
>>>>>> @@ -592,7 +693,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>>>>>>  static const struct sdhci_ops sdhci_msm_ops = {
>>>>>>      .platform_execute_tuning = sdhci_msm_execute_tuning,
>>>>>>      .reset = sdhci_reset,
>>>>>> -    .set_clock = sdhci_set_clock,
>>>>>> +    .set_clock = sdhci_msm_set_clock,
>>>>>>      .get_min_clock = sdhci_msm_get_min_clock,
>>>>>>      .get_max_clock = sdhci_msm_get_max_clock,
>>>>>>      .set_bus_width = sdhci_set_bus_width,
>>>>>>
>>>>>
>>>>
>>>
>>
>
