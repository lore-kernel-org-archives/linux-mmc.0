From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/2] mmc: core: fall back host->f_init if failing to
 init mmc card after resume
Date: Wed, 03 Aug 2016 15:54:39 +0900
Message-ID: <1e664e27-09c9-dc14-b978-2483c1fa1da4@samsung.com>
References: <1468979860-28712-1-git-send-email-shawn.lin@rock-chips.com>
 <1468979860-28712-2-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160802093847epcas1p2c8cb3881913a608122bb77dd9d973e63@epcas1p2.samsung.com>
 <98cd6af4-3296-9020-aeae-802f797f0631@rock-chips.com>
 <57A07A44.9000400@samsung.com>
 <73b58bd5-a5a2-a436-58a9-30fa8db3225f@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59350 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbcHCGym convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Aug 2016 02:54:42 -0400
In-reply-to: <73b58bd5-a5a2-a436-58a9-30fa8db3225f@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 08/03/2016 10:35 AM, Shawn Lin wrote:
> Hi Jaehoon,
> 
> 在 2016/8/2 18:47, Jaehoon Chung 写道:
>> Hi Shawn,
>>
>> On 08/02/2016 06:07 PM, Shawn Lin wrote:
>>> Hi Ulf,
>>>
>>> 在 2016/7/20 9:57, Shawn Lin 写道:
>>>> We observed the failure of initializing card after resume
>>>> accidentally. It's hard to reproduce but we did get report from
>>>> the suspend/resume test of our RK3399 mp test farm . Unfortunately,
>>>> we still fail to figure out what was going wrong at that time.
>>>> Also we can't achieve it by retrying the host->f_init without falling
>>>> back it. But this patch will solve the problem as we could add some log
>>>> there and see that we resume the mmc card successfully after falling
>>>> back the host->f_init. There is no obvious side effect found, so it seems
>>>> this patch will improve the stability.
>>>>
>>>> [   93.405085] mmc1: unexpected status 0x800900 after switch
>>>> [   93.408474] mmc1: switch to bus width 1 failed
>>>> [   93.408482] mmc1: mmc_select_hs200 failed, error -110
>>>> [   93.408492] mmc1: error -110 during resume (card was removed?)
>>>> [   93.408705] PM: resume of devices complete after 213.453 msecs
>>>>
>>
>> Status 0x800900 is COM_CRC_ERROR..it seems that CRC check fails.
>> But i don't know what is related with "fall back host->f_init".
> 
> Yup, actually it also looks strange to me that we should downgrade
> the host->f_init when resuming. CRC error shouldn't occour as 400K
> could work at booting time, also we could see the HS400 work normally
> later which make me believe that it shouldn't belong to signal problem,
> but we need to figure out why the controller think it should be a CRC
> error.
> 
> The best way is to make it easy to be reproduced that we could check the
> pcb signal there, and I still try it then. Or there is a HW/Chip
> condition that make my emmc PHY work improperly accidentally. Anyway
> more proof should be provided before I'am able to land patch to
> fix/avoid the root cause. I'm doing it..
> 
>>
>> I don't have a knowledge of rockchip...
>> but in my experience, there are some cases, not mmc core problem..
>>
>> 1. Exynos is using the gpio as clk/cmd/data line..and gpio has the driver strength value.
>> If driver strength is changed after resuming, it's possible to occur the error.
> 
> Yes, the related settings or configuration for PHY didn't change.
> 
>>
>> 2. And glitch for I/O line..this loop has the delay..Just delay?
> 
> We have retryied 400K if failing to resume and will not break out if
> still finding failure, but it doesn't help.
> 
> 
>>
>> So you can check the other problem... :)
>>
>> At Booting time, f_init can use 400K..but after resuming..f_init need to use 100K..hmm..strange..
>>
> 
> Agreed..
> 
> So let's come back to the topic -- Should we support downgrading f_init
> after failing to resume just as what we do at the booting time? It's
> possible that the enviroment changes like(noise, temperature, static)
> will lead to the failure after resuming. Shouldn't the mechanism be more
> robust to deal with these unexpected cases?  :)

I think you also felt  that this patch is workaround. 
Because it's not clearly why occurred the CRC error and resuming fails.
(CRC error should be disappeared when clock is used to the lower value..)

And I'm not sure that 100K is enough..If 100k also didn't work fine at resuming time, how we do?
This issue is interesting..because it's possible to occur in real case...I have also seen the similar issue.
But my solution also was workaround.  :(

If it's more clearly than now, i can agree your patch..but now..i don't know what is correct. 
I will listen Ulf and other guys's opinions..also yours. 

Best Regards,
Jaehoon Chung

> 
> 
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Any comments for this patch? :)
>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - remove mmc_power_off
>>>> - take f_min into consideration
>>>>
>>>>  drivers/mmc/core/mmc.c | 19 +++++++++++++++++--
>>>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 403b97b..a2891c1 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1945,6 +1945,7 @@ static int mmc_suspend(struct mmc_host *host)
>>>>  static int _mmc_resume(struct mmc_host *host)
>>>>  {
>>>>      int err = 0;
>>>> +    int i;
>>>>
>>>>      BUG_ON(!host);
>>>>      BUG_ON(!host->card);
>>>> @@ -1954,8 +1955,22 @@ static int _mmc_resume(struct mmc_host *host)
>>>>      if (!mmc_card_suspended(host->card))
>>>>          goto out;
>>>>
>>>> -    mmc_power_up(host, host->card->ocr);
>>>> -    err = mmc_init_card(host, host->card->ocr, host->card);
>>>> +    /*
>>>> +     * Let's try to fallback the host->f_init
>>>> +     * if failing to init mmc card after resume.
>>>> +     */
>>>> +    for (i = 0; i < ARRAY_SIZE(freqs); i++) {
>>>> +        if (host->f_init < max(freqs[i], host->f_min))
>>>> +            continue;
>>>> +        else
>>>> +            host->f_init = max(freqs[i], host->f_min);
>>>> +
>>>> +        mmc_power_up(host, host->card->ocr);
>>>> +        err = mmc_init_card(host, host->card->ocr, host->card);
>>>> +        if (!err)
>>>> +            break;
>>>> +    }
>>>> +
>>>>      mmc_card_clr_suspended(host->card);
>>>>
>>>>  out:
>>>>
>>>
>>>
>>
>>
>>
>>
> 
> 

