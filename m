From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH 06/10] mmc: sdhci: Add SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK
 quirk2 support
Date: Thu, 11 Aug 2016 12:33:22 +0530
Message-ID: <b88fa80f-0ac9-452e-aa71-d5e09039debd@codeaurora.org>
References: <1470841319-6091-1-git-send-email-riteshh@codeaurora.org>
 <1470841319-6091-7-git-send-email-riteshh@codeaurora.org>
 <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

Thanks for the feedback.
In case if you have any comments on other patches of this patch series, 
it will be good to address all of them in next spin.


On 8/11/2016 7:37 AM, Shawn Lin wrote:
> On 2016/8/10 23:01, Ritesh Harjani wrote:
>> From: Sahitya Tummala <stummala@codeaurora.org>
>>
>> MSM controller uses the base clock and does not use any divider.
>> The driver will use SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK
>> and controls the base clock (MCLK) directly.
>
> I think the direction for sdhci now is to overwrite
> sdhci_calc_clk in your variant driver..
Alright, will try and see if I can have similar to sdhci_set_clock 
itself in sdhci-msm driver.

>
> quirk is unacceptable now.
Alright, I will try to take care of this.

>
>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 4 ++++
>>  drivers/mmc/host/sdhci.h | 6 ++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index cd65d47..a5c9dcb 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1318,6 +1318,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host,
>> unsigned int clock,
>>  clock_set:
>>      if (real_div)
>>          *actual_clock = (host->max_clk * clk_mul) / real_div;
>> +
>> +    if (host->quirks2 & SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK)
>> +        div = 0;
>> +
>>      clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>>      clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>>          << SDHCI_DIVIDER_HI_SHIFT;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0411c9f..566c0fe 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -422,6 +422,12 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK2_ACMD23_BROKEN            (1<<14)
>>  /* Broken Clock divider zero in controller */
>>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN        (1<<15)
>> +/*
>> + * If the base clock can be scalable, then there should be no further
>> + * clock dividing as the input clock itself will be scaled down to
>> + * required frequency.
>> + */
>> +#define SDHCI_QUIRK2_ALWAYS_USE_BASE_CLOCK        (1<<16)
>>
>>      int irq;        /* Device IRQ */
>>      void __iomem *ioaddr;    /* Mapped address */
>>
>
>
