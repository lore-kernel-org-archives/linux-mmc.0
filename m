From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 11/15] mmc: sdhci: Change to new way of doing re-tuning
Date: Tue, 10 Mar 2015 14:55:22 +0100
Message-ID: <CAPDyKFr9bpE3FXu0339q4ndOm_KSNpATBODecTWkkrLifvSing@mail.gmail.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
	<1422522030-17793-12-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFpTuttvhP91qNF_g_2sWV3NZmYMCnqFVGYEnb1L8kXVeg@mail.gmail.com>
	<54FD5BDD.9060004@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:33641 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbbCJNzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2015 09:55:23 -0400
Received: by qcvx3 with SMTP id x3so1951818qcv.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2015 06:55:23 -0700 (PDT)
In-Reply-To: <54FD5BDD.9060004@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Neil Brown <neilb@suse.de>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

[...]

>>> @@ -2834,11 +2763,8 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
>>>  {
>>>         unsigned long flags;
>>>
>>> -       /* Disable tuning since we are suspending */
>>> -       if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>>> -               del_timer_sync(&host->tuning_timer);
>>> -               host->flags &= ~SDHCI_NEEDS_RETUNING;
>>> -       }
>>> +       mmc_retune_timer_stop(host->mmc);
>>
>> I think this could give a deadlock.
>>
>> What if the retuning is just about to start and thus sdhci's
>> ->execute_tuning() callback has been invoked, which is waiting for the
>> pm_runtime_get_sync() to return.
>
> The re-tune timer is mmc_retune_timer() and it does not take any locks
> so it can't deadlock.
>

You missed my point. The problem is related to runtime PM.

Here the sequence I think will cause the deadlock.
mmc_retune_timer_stop()
  ->del_timer_sync()
...
Wait for timer-handler to finish.

If the timer-handler is running, it has invoked the ->execute_tuning()
callback and is thus waiting for a pm_runtime_get_sync() to return.

Now, waiting for a pm_runtime_get_sync() to return from a runtime PM
suspend callback will deadlock!

>>
>>> +       mmc_retune_needed(host->mmc);
>>
>> This seems racy.
>>
>> What if a new request has already been started from the mmc core
>> (waiting for sdhci's ->request() callback to return). That would mean
>> the mmc core won't detect that a retune was needed.
>
> That is a good point. The host controller must not runtime suspend after
> re-tuning until retuning is released. I can think of a couple of options:
>         - move the retuning call into the ->request function
>         - add extra host ops for the host to runtime resume/suspend
>

I am not sure which approach I prefer yet. Need some more time to think.

For your information, Neil Brown is having a similar issue which he is
trying to address [1].

I think we need an generic approach to deal with the runtime PM
synchronization issue described above. More precisely in those
scenarios when mmc hosts needs to notify the mmc core to take some
specific actions, from a mmc host's runtime PM callback.

Kind regards
Uffe

[1]
https://lkml.org/lkml/2015/2/23/721
