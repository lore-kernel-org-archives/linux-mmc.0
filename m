From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 06/10] mmc: sdhci: Add get_clk_div callback support
Date: Fri, 12 Aug 2016 11:21:59 +0800
Message-ID: <bd503b78-0f56-3cc9-9b67-e0ff74db0558@rock-chips.com>
References: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
 <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
 <CGME20160811135325epcas1p41e0758a598b81e837653de7ef8ff56ec@epcas1p4.samsung.com>
 <1470923574-411-2-git-send-email-riteshh@codeaurora.org>
 <39e6afe2-8615-45ae-9ea5-feb6a6b58732@samsung.com>
 <cedd37cb-8ce8-30e4-6a28-5385358d88a2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <cedd37cb-8ce8-30e4-6a28-5385358d88a2@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

在 2016/8/12 10:19, Ritesh Harjani 写道:
> Hi Jaehoon/Adrian,
>
>
> On 8/12/2016 7:04 AM, Jaehoon Chung wrote:
>> Hi,
>>
>> On 08/11/2016 10:52 PM, Ritesh Harjani wrote:
>>> Few controllers (like MSM) may have to override div
>>> in certain cases. Hence provide a callback to get the
>>> div value for their driver.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 8 ++++++++
>>>  drivers/mmc/host/sdhci.h | 1 +
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index cd65d47..cc3d6f2 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1318,6 +1318,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host,
>>> unsigned int clock,
>>>  clock_set:
>>>      if (real_div)
>>>          *actual_clock = (host->max_clk * clk_mul) / real_div;
>>> +    /*
>>> +     * Few controllers may have to override div
>>> +     * here. Hence provide a callback to get the
>>> +     * div value for them.
>>> +     */
>>> +    if (host->ops->get_clk_div)
>>> +        div = host->ops->get_clk_div(host, div);
>>
>> This is for only getting your div value. Few controllers?
>> Rather, use the existent callback function..It's better than adding
>> new callback.
>
> As of today sdhci-of-arasan is the only user of this quirk
> -SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN. I was hoping that with this
> callback, we may get away with this quirk if sdhci-of-arasan can have
> get_clk_div callback implemented in it's driver?
>
> Since I was not sure on this, so I did not modify sdhci-of-arasan.
> Thoughts?

yup, I'm still using SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN in
sdhci-of-arasan now. If you are addressing this, please go ahead.

Per previous disscussion of sdhci, it is deprecated to add new quirks
or callback(?) into sdhci. It should be better to make it a library.
 From this view, you should overwrite the set_clock in your variant
driver.

I has a question here, (like MSM) may have to override div
in certain cases. What certain cases is? I just see you simply
return 0 there which means you want to bypass the clk?
If that is a trick of clk rate, we could use clk framework API
there to lower the input clk to make the calculation produce
zero div?


>
>>
>> In your controller, add the your set_clock() callback. not get_clk_div.
>> (Well, Adrian might have other opinion.)
> Alright, please let me know what would be the right approach.
>
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>
>>> +
>>>      clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>>>      clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>>>          << SDHCI_DIVIDER_HI_SHIFT;
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 0411c9f..4701001 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -562,6 +562,7 @@ struct sdhci_ops {
>>>                       struct mmc_card *card,
>>>                       unsigned int max_dtr, int host_drv,
>>>                       int card_drv, int *drv_type);
>>> +    int    (*get_clk_div)(struct sdhci_host *host, int div);
>>>  };
>>>
>>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin
