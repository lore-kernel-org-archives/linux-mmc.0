From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2] mmc: core: Detect card removal on I/O error
Date: Fri, 3 Feb 2012 09:46:20 +0100
Message-ID: <4F2B9EDC.6050800@stericsson.com>
References: <1328104100-1880-1-git-send-email-ulf.hansson@stericsson.com>	<CAKYAXd9KtQe3HWg1M3B4CPFzJiuC-Vwpx3wOgG4_zMUA7V=6GA@mail.gmail.com>	<4F29FA3E.3080703@samsung.com>	<CAKYAXd-n7sXAOqAZcuNYaEWFDyxwx2s0v3O+vHfsdrrHmxSqJA@mail.gmail.com>	<4F2A07EA.5020207@samsung.com> <CAKYAXd85ZR+069Q2vXx=qpZ+K+zk+kmi_y=SD9iu6T_-684ENQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:41294 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755069Ab2BCIqu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2012 03:46:50 -0500
In-Reply-To: <CAKYAXd85ZR+069Q2vXx=qpZ+K+zk+kmi_y=SD9iu6T_-684ENQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Namjae Jeon wrote:
> 2012/2/2 Jaehoon Chung <jh80.chung@samsung.com>:
>> On 02/02/2012 12:36 PM, Namjae Jeon wrote:
>>
>>> 2012/2/2 Jaehoon Chung <jh80.chung@samsung.com>:
>>>> On 02/02/2012 09:34 AM, Namjae Jeon wrote:
>>>>
>>>>> 2012/2/1 Ulf Hansson <ulf.hansson@stericsson.com>:
>>>>>> To prevent I/O as soon as possible at card removal, a new
>>>>>> detect work is re-scheduled without a delay to let a rescan
>>>>>> remove the card device as soon a possible.
>>>>>>
>>>>>> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
>>>>>> "slowly" removed cards that a scheduled detect work did not
>>>>>> detect as removed. To prevent further I/O requests for these
>>>>>> lingering removed cards, check if card has been removed and then
>>>>>> schedule a detect work to properly remove it.
>>>>>>
>>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>>        - Updated according to review comments.
>>>>>>        - Merging two patches for this feature into one.
>>>>>>
>>>>>> ---
>>>>>>  drivers/mmc/core/core.c  |   19 +++++++++++++++++--
>>>>>>  include/linux/mmc/host.h |    1 +
>>>>>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>> index bec0bf2..26d3a66 100644
>>>>>> --- a/drivers/mmc/core/core.c
>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>> @@ -2077,18 +2077,33 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>>>>>>  int mmc_detect_card_removed(struct mmc_host *host)
>>>>>>  {
>>>>>>        struct mmc_card *card = host->card;
>>>>>> +       int ret;
>>>>>>
>>>>>>        WARN_ON(!host->claimed);
>>>>>>        /*
>>>>>>         * The card will be considered unchanged unless we have been asked to
>>>>>>         * detect a change or host requires polling to provide card detection.
>>>>>>         */
>>>>>> -       if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
>>>>>> +       if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
>>>>>> +           && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
>>>>>>                return mmc_card_removed(card);
>>>>>>
>>>>>>        host->detect_change = 0;
>>>>>>
>>>>>> -       return _mmc_detect_card_removed(host);
>>>>>> +       ret = mmc_card_removed(card);
>>>>> Hi. Ulf.
>>>>> 1. Is there no case that card is null ?
>>>>> 2. and Eventually mmc_card_removed is once called in any case. can we
>>>>> change it like this ?
>>>>>
>>>>> if (card)
>>>>>    ret = mmc_card_removed(card);
>>>>>
>>>>>    if(!host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
>>>>>            && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
>>>>>                   return ret;
>>>> Hi Mr.Jeon
>>>> If card is NULL, maybe this code didn't run.
>>>> Only called this function is called in block.c (for my understanding)
>>>> before called mmc_detect_card_removed(card->host), check "if (mmc_card_removed(card)".
>>>> I think that need not to check.
>>> Hi. Chung.
>>> I found directly using this function in other file except block.c
>>> ./core/sdio.c:  err = _mmc_detect_card_removed(host);
>>> ./core/core.c:  return _mmc_detect_card_removed(host);
>>> ./core/sd.c:    err = _mmc_detect_card_removed(host);
>>> ./core/mmc.c:   err = _mmc_detect_card_removed(host);
>> Sorry..this patch is code in mmc_detect_card_removed(), isn't?
>> what is your comment related with _mmc_detect_card_removed()?
> I am confused. sorry, you're right.
> And Do you agree like below changing patch ?

Good comment. I will update the patch according to your suggestion and 
send a v3 patch.

>>> But I know to already check null of card(BUG_ON(!host->card)) before
>>> using _mmc_detect_card_removed.
>>> So don't need to check card is null now.
>>> I think that it is better if patch is modified like the below.
>>> -------------------------------------------------------------------------------------
>>> ret = mmc_card_removed(card);
>>>
>>>   if(!host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
>>>           && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
>>>                  return ret;
>>> -----------------------------------------------------------------------------------------
>>> Thanks.
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>>>> +       if (!ret) {
>>>>>> +               ret = _mmc_detect_card_removed(host);
>>>>>> +               if (ret) {
>>>>>> +                       /*
>>>>>> +                        * Schedule a detect work as soon as possible to let a
>>>>>> +                        * rescan handle the card removal.
>>>>>> +                        */
>>>>>> +                       cancel_delayed_work(&host->detect);
>>>>>> +                       mmc_detect_change(host, 0);
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       return ret;
>>>>>>  }
>>>>>>  EXPORT_SYMBOL(mmc_detect_card_removed);
>>>>>>
>>>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>>>> index dd13e05..368a2b9 100644
>>>>>> --- a/include/linux/mmc/host.h
>>>>>> +++ b/include/linux/mmc/host.h
>>>>>> @@ -257,6 +257,7 @@ struct mmc_host {
>>>>>>  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can support */
>>>>>>  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
>>>>>>                                 MMC_CAP2_HS200_1_2V_SDR)
>>>>>> +#define MMC_CAP2_DETECT_ON_ERR (1 << 7)        /* On I/O err check card removal */
>>>>>>
>>>>>>        mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>>>>>        unsigned int        power_notify_type;
>>>>>> --
>>>>>> 1.7.5.4
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Br
Ulf Hansson
