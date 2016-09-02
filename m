From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC] mmc: dw_mmc: skip the execute_tuning after checking timiing
Date: Fri, 2 Sep 2016 16:50:09 +0800
Message-ID: <04b5a158-fa50-50c7-639a-ab7050478976@rock-chips.com>
References: <1472622687-16389-1-git-send-email-jh80.chung@samsung.com>
 <CGME20160831071421epcas1p1efea97a79334edb2a4665e130e84f1f4@epcas1p1.samsung.com>
 <7be25c6e-ceed-bc70-55a0-540468577a64@rock-chips.com>
 <196d3b32-9367-de38-5ae6-96c6a56db6a5@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:43934 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbcIBIvQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 04:51:16 -0400
In-Reply-To: <196d3b32-9367-de38-5ae6-96c6a56db6a5@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, guodong.xu@linaro.org, kid.jin@hisilicon.com

Hi Jaehoon,

On 2016/8/31 18:48, Jaehoon Chung wrote:
> On 08/31/2016 04:13 PM, Shawn Lin wrote:
>> On 2016/8/31 13:51, Jaehoon Chung wrote:
>>> HS400 mode doesn't need to do execute_tuning, because it's already
>>> tuned in HS200 mode. And Tuning command is optional for UHS50 mode.
>>>
>>> In future, the general execute_tuning sequence can be included in this
>>> function.
>>
>> Maybe this isn't what we want for mmc.
>>
>> I see both of sd and sdio call mmc_execute_tuning by checking
>> the ios.timing, and explicitly we need to do tuning for
>> MMC_TIMING_UHS_SDR50 as the mmc core asks we to do that.
>>
>> Moreover, why mmc didn't do something like:
>>
>> if (card->host->ios.timing == MMC_TIMING_XXXXX || ....)
>>     mmc_execute_tuning()
>>
>> So we don't need every host driver to add these check and I do
>> see some host drivers check these timing for their execute_tuning
>> callback..
>>
>> What is your opinion? :)
>
> Yep, your comment makes sense..So i'm checking SD specification.
> I think it needs to know which UHS card is..(UHS50 or UHS104)..
> But current kernel can't distinguish these..
>
> According to spec, we can distinguish UHS50 and UHS104 with TRAN_SPEED field.
>
> "UHS50 Card set TRANS_SPEED to 0Bh (100Mbit/sec), for both SDR50 and DDR50 modes.
> UHS104 Card set TRAN_SPEED to 2Bh (200Mbit/sec)"
>
> I'm not sure it's helpful to me...but i will consider more...

Ah, are we on the same page? :)
I have some questions below.

>
> Thanks you for comment. :)
>
> Best Regards,
> Jaehoon Chung
>
>>
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 22dacae..6571924 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1568,10 +1568,25 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>      struct dw_mci_slot *slot = mmc_priv(mmc);
>>>      struct dw_mci *host = slot->host;
>>>      const struct dw_mci_drv_data *drv_data = host->drv_data;
>>> -    int err = -EINVAL;
>>> +    int err = 0;
>>> +
>>> +    switch (host->timing) {
>>> +    case MMC_TIMING_MMC_HS400:
>>> +        err = -EINVAL;

What makes you think the code could be there? :)
By looking the code, it's impossible, no?

>>> +        goto out;
>>> +    case MMC_TIMING_MMC_HS200:
>>> +    case MMC_TIMING_UHS_SDR104:
>>> +    case MMC_TIMING_UHS_DDR50:
>>> +        break;
>>> +    case MMC_TIMING_UHS_SDR50:
>>> +        /* Fall through */

dw_mmc even doesn't try to do tuning for SDR50?


>>> +    default:
>>> +        goto out;
>>> +    }
>>>

That confused me more or less. What makes us gain confidence
that we could return 0 even if no any tuning process was done
before using UHS-I.


>>>      if (drv_data && drv_data->execute_tuning)
>>>          err = drv_data->execute_tuning(slot, opcode);
>>> +out:
>>>      return err;
>>>  }
>>>
>>>
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

