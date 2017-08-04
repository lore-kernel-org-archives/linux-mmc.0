From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2] mmc: core: not need to check timeout for SDHC
Date: Fri, 4 Aug 2017 16:18:20 +0800
Message-ID: <725ab878-389a-cd0d-4d47-cd58df47a237@rock-chips.com>
References: <1501812493-223948-1-git-send-email-shawn.lin@rock-chips.com>
 <f9ee7630-5288-f8b2-d249-197b6c1e07b7@intel.com>
 <3bca2dda-cbde-a688-e7f6-15f5b587b073@rock-chips.com>
 <60c5bad2-2419-17bc-8fd9-cdf3f89256bb@rock-chips.com>
 <01618858-0a58-c005-269a-5762f0d47e13@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:48095 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdHDISg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2017 04:18:36 -0400
In-Reply-To: <01618858-0a58-c005-269a-5762f0d47e13@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org

On 2017/8/4 15:47, Adrian Hunter wrote:
> On 04/08/17 10:24, Shawn Lin wrote:
>>
>> On 2017/8/4 15:22, Shawn Lin wrote:
>>> On 2017/8/4 14:38, Adrian Hunter wrote:
>>>> On 04/08/17 05:08, Shawn Lin wrote:
>>>>> Per the SD physical layer simplified specification V4.10,
>>>>> section 4.6.2, CSD version 1.0 SD card should use taac, nsac
>>>>> and r2w_factor for calculating the data access time. But the
>>>>> taac and nsac for SDHC(CSD version 2.0) are always fixed and
>>>>> the software should use the recommended value for timeout. When
>>>>> parsing the CSD, we sanely set them to zero for SDHC(CSD version
>>>>> 2.0), all the calculation for timeout_ns and timeout_clk is zero
>>>>> as well. So what we actually want to limit here is either SDHC
>>>>> case or unreasonable timeout reported by the cards. In principle
>>>>> we should at least be able to remove the bogus check for the
>>>>> mmc_card_blockaddr.
>>>>>
>>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>>
>>>>> ---
>>>>>
>>>>> Changes in v2:
>>>>> - rephrase the changelog and only remove mmc_card_blockaddr.
>>>>>
>>>>>    drivers/mmc/core/core.c | 12 ++++--------
>>>>>    1 file changed, 4 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 6177eb0..edc2e75 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -761,15 +761,11 @@ void mmc_set_data_timeout(struct mmc_data *data,
>>>>> const struct mmc_card *card)
>>>>>                limit_us = 100000;
>>>>>            /*
>>>>> -         * SDHC cards always use these fixed values.
>>>>> +         * Assign limit value if invalid. Note that for the SDHC case,
>>>>> +         * we set taac and nasc to zero when parsing CSD, so it's safe
>>>>> +         * to fall through here.
>>>>>             */
>>>>> -        if (timeout_us > limit_us || mmc_card_blockaddr(card)) {
>>>>> -            data->timeout_ns = limit_us * 1000;
>>>>> -            data->timeout_clks = 0;
>>>>> -        }
>>>>> -
>>>>> -        /* assign limit value if invalid */
>>>>> -        if (timeout_us == 0)
>>>>> +        if (timeout_us == 0 || timeout_us > limit_us)
>>>>>                data->timeout_ns = limit_us * 1000;
>>>>
>>>> Shouldn't we still be ensuring 'data->timeout_clks = 0' for the 'timeout_us
>>>>> limit_us' case
>>>
>>> I have a question that why we expose data->timeout_clks for host
>>> drivers?
>>>
>>> I quick look at how the host drivers use it and find it almost does
>>> the same thing as the core layer if card->host->ios.clock is present.
>>> So shouldn't we *always* set data->timeout_clks to zero and fold the
>>> extra cycle(actually it's NSAC) into data->timeout_ns so that the host
>>> drivers only need to care about data->timeout_clks?
>>>
>>
>> Sorry. s/care about data->timeout_clks/care about data->timeout_ns?
> 
> Pedantically, the calculation should, in fact, be using the actual clock
> frequency not the target frequency card->host->ios.clock.

yes. I assumed generally the actual clock shouldn't be less too much
than target frequency, otherwise timeout_us may actually be much larger
than limit_us if the actual clock is lower enough, even if the core
think it shouldn't be that case estimated by target clock. But it seems 
pointless to argue this here since that's too pedantical as you said.

Thanks for sharing your thought.

> 
> 
> 

