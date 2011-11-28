From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2] mmc: Kill block requests if card is removed
Date: Mon, 28 Nov 2011 15:02:56 +0200
Message-ID: <4ED38680.40102@intel.com>
References: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org> <4ECE5A3D.6060004@intel.com> <4ECF6D73.7080302@codeaurora.org> <4ECF7BDA.8020801@intel.com> <4ED328FA.7050301@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4ED328FA.7050301@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, per.lkml@gmail.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On 28/11/11 08:23, Sujit Reddy Thumma wrote:
> Hi Adrian,
> 
> On 11/25/2011 4:58 PM, Adrian Hunter wrote:
>> On 25/11/11 12:26, Sujit Reddy Thumma wrote:
>>> Hi Adrian,
>>>
>>> On 11/24/2011 8:22 PM, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here is a way to allow mmc block to determine immediately
>>>> if a card has been removed while preserving the present rules
>>>> and keeping card detection in the bus_ops.
>>>>
>>>> Untested I'm afraid.
>>>>
>>>> Regards
>>>> Adrian
>>>>
>>>>
>>>>
>>>>   From 2c6c9535b94c07fa3d12af26e9b6de500cb29970 Mon Sep 17 00:00:00 2001
>>>> From: Adrian Hunter<adrian.hunter@intel.com>
>>>> Date: Thu, 24 Nov 2011 16:32:34 +0200
>>>> Subject: [PATCH] mmc: allow upper layers to determine immediately if a
>>>> card has been removed
>>>>
>>>> Add a function mmc_card_removed() which upper layers can use
>>>> to determine immediately if a card has been removed.  This
>>>> function should be called after an I/O request fails so that
>>>> all queued I/O requests can be errored out immediately
>>>> instead of waiting for the card device to be removed.
>>>>
>>>> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
>>>> ---
>>>>    drivers/mmc/core/core.c  |   32 ++++++++++++++++++++++++++++++++
>>>>    drivers/mmc/core/core.h  |    3 +++
>>>>    drivers/mmc/core/mmc.c   |   12 +++++++++++-
>>>>    drivers/mmc/core/sd.c    |   12 +++++++++++-
>>>>    drivers/mmc/core/sdio.c  |   11 ++++++++++-
>>>>    include/linux/mmc/card.h |    1 +
>>>>    include/linux/mmc/core.h |    2 ++
>>>>    7 files changed, 70 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 271efea..c317564 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -2049,6 +2049,38 @@ static int mmc_rescan_try_freq(struct mmc_host
>>>> *host, unsigned freq)
>>>>        return -EIO;
>>>>    }
>>>>
>>>> +int _mmc_card_removed(struct mmc_host *host, int detect_change)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (!(host->caps&   MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
>>>> +        return 0;
>>>> +
>>>> +    if (!host->card || (host->card->state&   MMC_CARD_REMOVED))
>>>> +        return 1;
>>>> +
>>>> +    /*
>>>> +     * The card will be considered alive unless we have been asked to detect
>>>> +     * a change or host requires polling to provide card detection.
>>>> +     */
>>>> +    if (!detect_change&&   !(host->caps&   MMC_CAP_NEEDS_POLL))
>>>> +        return 0;
>>>> +
>>>> +    ret = host->bus_ops->alive(host);
>>>> +    if (ret)
>>>> +        host->card->state |= MMC_CARD_REMOVED;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>
>>> The patch itself looks good to me, but can't we decide this in the block
>>> layer itself when we issue get_card_status() when the ongoing request fails?
>>>
>>> ----------------------------------------------
>>>          for (retry = 2; retry>= 0; retry--) {
>>>                  err = get_card_status(card,&status, 0);
>>>                  if (!err)
>>>                          break;
>>>
>>>                  prev_cmd_status_valid = false;
>>>                  pr_err("%s: error %d sending status command, %sing\n",
>>>                         req->rq_disk->disk_name, err, retry ? "retry" :
>>> "abort");
>>>          }
>>>
>>>
>>>       /* We couldn't get a response from the card.  Give up. */
>>> -    if (err)
>>> +    if (err) {
>>> +        /*
>>> +         * If the card didn't respond to status command,
>>> +         * it is likely that card is gone. Flag it as removed,
>>> +         * mmc_detect_change() cleans the rest.
>>> +         */
>>> +        mmc_card_set_removed(card);
>>>           return ERR_ABORT;
>>> +    }
>>> ------------------------------------------------
>>>
>>> The V2 patch I have posted takes care of this. Please let me know if it not
>>> good to decide in the block layer itself. Essentially, both the
>>> implementations are sending CMD13 to know the status of the card.
>>
>> I think it is better to have the decision over whether or not the card
>> has been removed in only one place.  Also, never flagging
>> MMC_CAP_NONREMOVABLE cards as removed nor if the HC driver has not called
>> mmc_detect_change.
> 
> Agreed. This is much cleaner implementation. Thanks.
> 
>>
>> But the block change is essentially the same:
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c80bb6d..32590c3 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -632,6 +632,8 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card,
>> struct request *req,
>>       u32 status, stop_status = 0;
>>       int err, retry;
>>
>> +    if (mmc_card_removed(card))
>> +        return ERR_ABORT;
>>       /*
>>        * Try to get card status which indicates both the card state
>>        * and why there was no response.  If the first attempt fails,
>> @@ -648,8 +650,10 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card,
>> struct request *req,
>>       }
>>
>>       /* We couldn't get a response from the card.  Give up. */
>> -    if (err)
>> +    if (err) {
>> +        mmc_detect_card_removed(card->host);
>>           return ERR_ABORT;
>> +    }
>>
>>       /* Flag ECC errors */
>>       if ((status&  R1_CARD_ECC_FAILED) ||
>>
>> I attached a revised version of the patch adding -ENOMEDIUM
>> errors from __mmc_start_request as you and Per discussed.
> 
> Thanks. I had a look at it and I have some comments:
> 
> +int mmc_detect_card_removed(struct mmc_host *host)
> +{
> +       WARN_ON(!host->claimed);
> +
> +       return _mmc_detect_card_removed(host, work_pending(&host->detect.work));
> 
> The work_pending bit would be set only when the HC driver has detected a change in the slot and called mmc_detect_change() to queue the detect work after a delay. In my case this delay is zero. So as soon as the card is removed following happen:
> 
> ->mmc_detect_change
> -->mmc_schedule_delayed_work
> --->work_pending bit is set
> ---->since the delay is zero, work is queued asap
> ----->just before work->func is called, work_pending bit is cleared
> ------>work->func() i.e., mmc_rescan is started
> ------->mmc_rescan waiting for claim host.
> 
> So there can be a case where work_pending bit is set as well as cleared even before block layer get a chance to call mmc_detect_card_removed(), hence the block layer would always see that card is alive even if the card is removed until mmc_rescan is completed.

Yes, the work_pending bit cannot be used.

> 
> +       /*
> +        * The card will be considered alive unless we have been asked to detect
> +        * a change or host requires polling to provide card detection.
> +        */
> +       if (!detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
> +               return 0;
> +
> 
> Since, the main purpose of _mmc_detect_card_removed() is to detect whether the card is removed or not I feel "detect_change" is redundant. Let me know if you see any other problem without this.
> 
> 

I would like to preserve the same rules that are used now.
i.e. the card will not get removed unless there has been
a card-detect event.

So I have replaced the work_pending bit with a flag.  See
V3 posted separately.
