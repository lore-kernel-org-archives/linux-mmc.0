From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: core: Prevent I/O as soon as possible at card
 removal
Date: Wed, 01 Feb 2012 12:02:10 +0900
Message-ID: <4F28AB32.5050608@samsung.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
 <1326991191-12472-2-git-send-email-ulf.hansson@stericsson.com>
 <4F19562F.6010907@intel.com> <4F27E46A.6040504@stericsson.com>
 <4F27F2FF.4080408@intel.com> <4F28076B.8090607@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65397 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab2BADCW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 22:02:22 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LYP00DJB1REXSK0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2012 12:02:20 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LYP0076N1RV6ZH0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2012 12:02:20 +0900 (KST)
In-reply-to: <4F28076B.8090607@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf.
On 02/01/2012 12:23 AM, Ulf Hansson wrote:

> Adrian Hunter wrote:
>> On 31/01/12 14:54, Ulf Hansson wrote:
>>> Adrian Hunter wrote:
>>>> On 19/01/12 18:39, Ulf Hansson wrote:
>>>>> Once the card has been detected to be removed by the
>>>>> mmc_detect_card_removed function, schedule a new detect work
>>>>> immediately and without a delay to let a rescan remove the
>>>>> card device as soon a possible. This will sooner prevent
>>>>> further I/O requests.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>>>> ---
>>>>>  drivers/mmc/core/core.c |   16 ++++++++++++++--
>>>>>  1 files changed, 14 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index bec0bf2..265dfd8 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -2077,6 +2077,7 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>>>>>  int mmc_detect_card_removed(struct mmc_host *host)
>>>>>  {
>>>>>      struct mmc_card *card = host->card;
>>>>> +    int ret;
>>>>>  
>>>>>      WARN_ON(!host->claimed);
>>>>>      /*
>>>>> @@ -2086,9 +2087,20 @@ int mmc_detect_card_removed(struct mmc_host *host)
>>>>>      if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
>>>>>          return mmc_card_removed(card);
>>>>>  
>>>>> -    host->detect_change = 0;
>>>> That line should not be removed.  It is not related to your change.
>>> I think it is. Since my patch is trying to make it possible to "prevent I/O as soon as possible..."
>>
>> No, the value of detect_change does not affect the outcome
>> if MMC_CAP2_DETECT_ON_ERR is set i.e.:
>>
>>     if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
>>         && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
>>
>> is always false if (host->caps2 & MMC_CAP2_DETECT_ON_ERR) is true
> 
> You are right! But MMC_CAP2_DETECT_ON_ERR is introduced in the second patch, so we should not consider that in this patch I think!?
> 
>>
>>> Clearing the detect_change flag here will prevent the I/O layer from doing further tests to see if the card is removed by using "mmc_detect_card_removed -> _mmc_detect_card_removed" due to the upper if sentence.
>>>
>>> I think this flag should only be cleared from the mmc_rescan function.
>>>
>>>>> +    ret = mmc_card_removed(card);
>>>> Calling mmc_card_removed() is not needed here since
>>>> _mmc_detect_card_removed() does it anyway.
>>>>
>>>>> +    if (!ret) {
>>>>> +        ret = _mmc_detect_card_removed(host);
>>>>> +        if (ret) {
>>>>> +            /*
>>>>> +             * Schedule a detect work as soon as possible to let a
>>>>> +             * rescan handle the card removal.
>>>>> +             */
>>>>> +            cancel_delayed_work(&host->detect);
>>>> Why cancel the detect work?
>>> To "prevent I/O as soon as possible...".
>>>
>>> The detect work could have been scheduled to be run at several ms later. There is no need to wait for it since we already now that card will be removed when the rescan function will execute.

if (cancel_delayed_work(&host->detect))
	mmc_detect_change(host, 0);
isn't?

>>>
>>>>> +            mmc_detect_change(host, 0);
>>>>> +        }
>>>>> +    }
>>>>>  
>>>>> -    return _mmc_detect_card_removed(host);
>>>>> +    return ret;
>>>>>  }
>>>>>  EXPORT_SYMBOL(mmc_detect_card_removed);
>>>>>  
>>>>
>>> Br
>>> Ulf Hansson
>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


