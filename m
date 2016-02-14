From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: remove unused EVENT_XFER_ERROR
Date: Mon, 15 Feb 2016 07:27:11 +0900
Message-ID: <56C0FF3F.4010706@samsung.com>
References: <1454469964-21365-1-git-send-email-shawn.lin@rock-chips.com>
 <56B2EBE7.3030008@samsung.com> <56BDC2A0.1000702@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <56BDC2A0.1000702@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 02/12/2016 08:31 PM, Shawn Lin wrote:
> On 2016/2/4 14:12, Jaehoon Chung wrote:
>> Hi, Shawn.
>>
>> On 02/03/2016 12:26 PM, Shawn Lin wrote:
>>> EVENT_XFER_ERROR isn't been used now, so we can
>>> remove it.
>>
>> If you are ok, after changing the commit message, I will apply this.
>> Thanks!
> 
> Should I respin v2 to amend the commit msg? :-)

Not important..but i want to use this. :)
"we can remove it" -> "It can be removed." 

Best Regards,
Jaehoon Chung

> 
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>>   include/linux/mmc/dw_mmc.h | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>>> index 89df7ab..b29e06e 100644
>>> --- a/include/linux/mmc/dw_mmc.h
>>> +++ b/include/linux/mmc/dw_mmc.h
>>> @@ -36,7 +36,6 @@ enum {
>>>       EVENT_XFER_COMPLETE,
>>>       EVENT_DATA_COMPLETE,
>>>       EVENT_DATA_ERROR,
>>> -    EVENT_XFER_ERROR
>>>   };
>>>
>>>   struct mmc_data;
>>>
>>
>>
>>
>>
> 
> 
