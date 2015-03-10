From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Tue, 10 Mar 2015 16:20:32 +0200
Message-ID: <54FEFDB0.5050104@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>	<54FD5BDD.9060004@intel.com> <CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19679 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbbCJOWd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 10:22:33 -0400
In-Reply-To: <CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Neil Brown <neilb@suse.de>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 10/03/15 15:55, Ulf Hansson wrote:
> [...]
> 
>>>> @@ -2834,11 +2763,8 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>>>>  {
>>>>         unsigned long flags;
>>>>
>>>> -       /* Disable tuning since we are suspending */
>>>> -       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>>>> -               del_timer_sync(&host->tuning_timer);
>>>> -               host->flags &= ~SDHCI_NEEDS_RETUNING;
>>>> -       }
>>>> +       mmc_retune_timer_stop(host->mmc);
>>>
>>> I think this could give a deadlock.
>>>
>>> What if the retuning is just about to start and thus sdhci's
>>> ->execute_tuning() callback has been invoked, which is waiting for the
>>> pm_runtime_get_sync() to return.
>>
>> The re-tune timer is mmc_retune_timer() and it does not take any locks
>> so it can't deadlock.
>>
> 
> You missed my point. The problem is related to runtime PM.
> 
> Here the sequence I think will cause the deadlock.
> mmc_retune_timer_stop()
>   ->del_timer_sync()
> ...
> Wait for timer-handler to finish.
> 
> If the timer-handler is running, it has invoked the ->execute_tuning()

No, the timer handler does not invoke anything. It just sets a flag.

> callback and is thus waiting for a pm_runtime_get_sync() to return.
> 
> Now, waiting for a pm_runtime_get_sync() to return from a runtime PM
> suspend callback will deadlock!
> 
>>>
>>>> +       mmc_retune_needed(host->mmc);
>>>
>>> This seems racy.
>>>
>>> What if a new request has already been started from the mmc core
>>> (waiting for sdhci's ->request() callback to return). That would mean
>>> the mmc core won't detect that a retune was needed.
>>
>> That is a good point. The host controller must not runtime suspend after
>> re-tuning until retuning is released. I can think of a couple of options:
>>         - move the retuning call into the ->request function
>>         - add extra host ops for the host to runtime resume/suspend
>>
> 
> I am not sure which approach I prefer yet. Need some more time to think.
> 
> For your information, Neil Brown is having a similar issue which he is
> trying to address [1].

It is a bit different. Re-tuning is about doing something before a
request, rather than before a suspend.

> I think we need an generic approach to deal with the runtime PM
> synchronization issue described above. More precisely in those
> scenarios when mmc hosts needs to notify the mmc core to take some
> specific actions, from a mmc host's runtime PM callback.

For the re-tune case I did not want to assume what the host driver
needed to do, so I added ->hold_tuning() and ->release_tuning()
host operations.

Please see V3 of the patches I sent earlier today.

Thanks very much for looking at the patches by the way! :-)

