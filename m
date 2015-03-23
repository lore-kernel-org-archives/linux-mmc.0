From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Mon, 23 Mar 2015 16:26:07 +0200
Message-ID: <5510227F.70605@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>	<54FD5BDD.9060004@intel.com>	<CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>	<54FEFDB0.5050104@intel.com> <CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15039 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbbCWO2K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Mar 2015 10:28:10 -0400
In-Reply-To: <CAPDyKFpvCz9kTaX=632hWGsWfLKC2aFJomFc1xECnNvQpNVU2A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Neil Brown <neilb@suse.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 23/03/15 14:54, Ulf Hansson wrote:
> On 10 March 2015 at 15:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 10/03/15 15:55, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>> @@ -2834,11 +2763,8 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>>>>>>  {
>>>>>>         unsigned long flags;
>>>>>>
>>>>>> -       /* Disable tuning since we are suspending */
>>>>>> -       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>>>>>> -               del_timer_sync(&host->tuning_timer);
>>>>>> -               host->flags &= ~SDHCI_NEEDS_RETUNING;
>>>>>> -       }
>>>>>> +       mmc_retune_timer_stop(host->mmc);
>>>>>
>>>>> I think this could give a deadlock.
>>>>>
>>>>> What if the retuning is just about to start and thus sdhci's
>>>>> ->execute_tuning() callback has been invoked, which is waiting for the
>>>>> pm_runtime_get_sync() to return.
>>>>
>>>> The re-tune timer is mmc_retune_timer() and it does not take any locks
>>>> so it can't deadlock.
>>>>
>>>
>>> You missed my point. The problem is related to runtime PM.
>>>
>>> Here the sequence I think will cause the deadlock.
>>> mmc_retune_timer_stop()
>>>   ->del_timer_sync()
>>> ...
>>> Wait for timer-handler to finish.
>>>
>>> If the timer-handler is running, it has invoked the ->execute_tuning()
>>
>> No, the timer handler does not invoke anything. It just sets a flag.
> 
> Ah, yes. I say that now.
> 
>>
>>> callback and is thus waiting for a pm_runtime_get_sync() to return.
>>>
>>> Now, waiting for a pm_runtime_get_sync() to return from a runtime PM
>>> suspend callback will deadlock!
>>>
>>>>>
>>>>>> +       mmc_retune_needed(host->mmc);
>>>>>
>>>>> This seems racy.
>>>>>
>>>>> What if a new request has already been started from the mmc core
>>>>> (waiting for sdhci's ->request() callback to return). That would mean
>>>>> the mmc core won't detect that a retune was needed.
>>>>
>>>> That is a good point. The host controller must not runtime suspend after
>>>> re-tuning until retuning is released. I can think of a couple of options:
>>>>         - move the retuning call into the ->request function
>>>>         - add extra host ops for the host to runtime resume/suspend
>>>>
>>>
>>> I am not sure which approach I prefer yet. Need some more time to think.
>>>
>>> For your information, Neil Brown is having a similar issue which he is
>>> trying to address [1].
>>
>> It is a bit different. Re-tuning is about doing something before a
>> request, rather than before a suspend.
> 
> That's true, but we are still have the same locking issues to consider
> for runtime PM.

I have no locking issues, so I am not sure what you mean here.

> 
>>
>>> I think we need an generic approach to deal with the runtime PM
>>> synchronization issue described above. More precisely in those
>>> scenarios when mmc hosts needs to notify the mmc core to take some
>>> specific actions, from a mmc host's runtime PM callback.
>>
>> For the re-tune case I did not want to assume what the host driver
>> needed to do, so I added ->hold_tuning() and ->release_tuning()
>> host operations.
> 
> I have thought a bit more on how I would like this to be implemented.
> It's a bit closer to what Neil's suggests in his approach [1].

I am not sure it is valuable to mix up the two issues.

For Neil's problem I would do something quiet different:

1. The host driver already knows the bus width so can easily "get/put"
runtime pm to prevent suspend when the bus width does not permit it.

2. The need to do things when the card is idle comes up a lot (e.g. bkops,
sleep notification, cache flush etc etc). In Neil's case he wants to switch
to 1-bit mode, but that just seems another of these "idle" operations. So I
would investigate the requirements of supporting idle operations in general.


> 
> First, I would like only one API provided from the mmc core. This API
> shall be invoked from the host driver's runtime PM suspend callback.
> 
> Something along the lines, "mmc_host_runtime_suspend()". This function
> will return -EBUSY if the host isn't allowed to be runtime PM
> suspended.
> 
> To make sure this function don't deadlock, it must not do any requests
> towards the host (since that would trigger a pm_runtime_get_sync() of
> the host's device).
> 
> Also, it need to claim the mmc host in a non-blocking manner
> (mmc_claim_host() needs to be extended to support that) since that
> prevents deadlocking and also tells us whether there are new requests
> prepared by the mmc core. If that's the case, there are no need to
> complete the runtime PM suspend operation, but instead immediately
> return -EBUSY.
> 
> In your case mmc_host_runtime_suspend(), also needs to assign a flag
> indicating that a re-tune is needed at next request. That flag shall
> be set when the host is claimed to prevent the host_ops->request()
> callback to be invoked, which removes the race condition.
> 
> Kind regards
> Uffe
> 
> 

