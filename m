From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Force a "detect" to handle non-properly removed
 cards
Date: Mon, 09 Jan 2012 14:07:21 +0200
Message-ID: <4F0AD879.10801@intel.com>
References: <1325586798-16276-1-git-send-email-ulf.hansson@stericsson.com> <4F04C412.1030604@intel.com> <4F0AC942.4060404@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27509 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab2AIMHW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jan 2012 07:07:22 -0500
In-Reply-To: <4F0AC942.4060404@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 09/01/12 13:02, Ulf Hansson wrote:
> Adrian Hunter wrote:
>> On 3/01/2012 12:33 p.m., Ulf Hansson wrote:
>>> Removing a card "slowly" can trigger a GPIO irq to be raised far
>>> before the card is actually removed. This means the scheduled
>>> detect work will not find out that the card were removed and thus
>>> the card and the block device will not be unregistered.
>>
>> One way around that problem is to error out requests after the GPIO
>> indicates the card is "removed".  sdhci effectively does that but with
>> a "present" bit.  Perhaps even simpler - set the card-removed flag.
> 
> I get the idea, but that will only partly solve this issue.
> 
> My concern is more about what we actually can trust; either the GPIO irq
> which likely is giving more than one irq when inserting/removing a card
> since the slot is probably not glitch free, or that a "rescan" runs to make
> sure a CMD13 is accepted from the previously inserted card.

Yes, I guess you would need to debounce the GPIO if you wanted to rely on it.

> 
> Moreover, the issue this patch tries to solve can not be solved without
> doing a "rescan" which must be triggered from the the block layer some how.
> I thought this new function that you previously added
> "mmc_detect_card_remove" was the proper place to do this.
> 
>>
>>> Let the mmc_detect_card_removed function trigger a new detect
>>> work immediately when it discovers that a card has been removed.
>>
>> This is changing some long-standing functionality i.e. the card is not
>> removed
>> without a card detect event.  It is difficult to know whether that will be
>> very
>> bad for poor quality cards,
> 
> Doing a mmc_detect (rescan) will in the end just issue a CMD13 to the card
> to make sure it is still present, that is already done from the block layer
> after each read/write request. So I can not see that "poor quality cards"
> will have any further problem with this patch, but I might miss something!?

The block driver has never caused a card to be removed before.  That is new
and it is designed to preserve existing behaviour i.e. do not remove a card
without a card detect event.

You are assuming:
	1. that a poor quality card will not return errors for a few
	commands and then resume operation
	2. that removing a card on error is desirable

Both those assumptions may be true, but there is no evidence that they are.


> 
>>
>>> This will solve the described issue above. Moreover we make sure
>>> the detect work is executed as soon as possible, since there is
>>> no reason for waiting for a "delayed" detect to happen.
>>>
>>> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
>>> ---
>>>   drivers/mmc/core/core.c  |   24 +++++++++++++-----------
>>>   include/linux/mmc/host.h |    1 -
>>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 4770807..7bc02f4 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1462,7 +1462,6 @@ void mmc_detect_change(struct mmc_host *host,
>>> unsigned long delay)
>>>       WARN_ON(host->removed);
>>>       spin_unlock_irqrestore(&host->lock, flags);
>>>   #endif
>>> -    host->detect_change = 1;
>>>       mmc_schedule_delayed_work(&host->detect, delay);
>>>   }
>>>
>>> @@ -2077,18 +2076,23 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>>>   int mmc_detect_card_removed(struct mmc_host *host)
>>>   {
>>>       struct mmc_card *card = host->card;
>>> +    int ret = 1;
>>>
>>>       WARN_ON(!host->claimed);
>>> -    /*
>>> -     * The card will be considered unchanged unless we have been asked to
>>> -     * detect a change or host requires polling to provide card detection.
>>> -     */
>>> -    if (card&&  !host->detect_change&&  !(host->caps&  MMC_CAP_NEEDS_POLL))
>>> -        return mmc_card_removed(card);
>>>
>>> -    host->detect_change = 0;
>>> +    if (card&&  !mmc_card_removed(card)) {
>>> +        if (_mmc_detect_card_removed(host)) {
>>> +            /*
>>> +             * Make sure a detect work is always executed and also
>>> +             * do it as soon as possible.
>>> +             */
>>> +            cancel_delayed_work(&host->detect);
>>> +            mmc_detect_change(host, 0);
>>> +        }
>>> +        ret = mmc_card_removed(card);
>>> +    }
>>>
>>> -    return _mmc_detect_card_removed(host);
>>> +    return ret;
>>>   }
>>>   EXPORT_SYMBOL(mmc_detect_card_removed);
>>>
>>> @@ -2112,8 +2116,6 @@ void mmc_rescan(struct work_struct *work)
>>>       &&  !(host->caps&  MMC_CAP_NONREMOVABLE))
>>>           host->bus_ops->detect(host);
>>>
>>> -    host->detect_change = 0;
>>> -
>>>       /*
>>>        * Let mmc_bus_put() free the bus/bus_ops if we've found that
>>>        * the card is no longer present.
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index 031d865..09fa5e6 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -305,7 +305,6 @@ struct mmc_host {
>>>       int            claim_cnt;    /* "claim" nesting count */
>>>
>>>       struct delayed_work    detect;
>>> -    int            detect_change;    /* card detect flag */
>>>       struct mmc_hotplug    hotplug;
>>>
>>>       const struct mmc_bus_ops *bus_ops;    /* current bus driver */
>>
>>
> 
> Br
> Ulf Hansson
> 

