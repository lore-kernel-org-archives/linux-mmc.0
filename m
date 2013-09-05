From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC PATCH] mmc: Enable wakeup_sources for mmc core
Date: Thu, 5 Sep 2013 14:54:14 -0700
Message-ID: <CAME+o4m8GM40wUHmiw5-2xWtSn2VmUTVv9kbc-SdqP12a9wLHQ@mail.gmail.com>
References: <1371146190-16786-1-git-send-email-zoran.markovic@linaro.org>
	<CAPDyKFpEa2hMPZmvpg1SOqK2d-NZrenwumSU4B4pmqqsWh+e0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43572 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3IEVyO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2013 17:54:14 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so2667103obp.36
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 14:54:14 -0700 (PDT)
In-Reply-To: <CAPDyKFpEa2hMPZmvpg1SOqK2d-NZrenwumSU4B4pmqqsWh+e0g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Ulf,
Thanks for reviewing this, it was very helpful!

> 1. mmc_detect_change does obviously not have to be run the same number
> of times as the mmc_rescan function. In other words, the calls to
> __pm_stay_awake is not paired with __pm_relay, I suppose this does not
> matter?
It shouldn't, since a single __pm_relax() would cancel all previous
calls to __pm_stay_awake() on the same wakeup source. What is
important is that mmc_rescan() is scheduled after __pm_stay_awake() to
make sure wakeup source is released.

> 2. mmc_detect_change can for example be called while the device
> suspend sequence is progressing. At this point the rescan work is
> disabled, thus __pm_relax will not be called, until the next rescan
> work as executed which is after the complete resume cycle
> (mmc_pm_notify:PM_POST_SUSPEND). Is that an issue?
If started, mmc_detect_change() should run uninterrupted to call
__pm_stay_awake(), which should abort any previous suspend requests.
The abort sequence should restart the rescan work, so __pm_relax()
eventually gets called.

>>         /* If there is a non-removable card registered, only scan once */
>> -       if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered)
>> +       if ((host->caps & MMC_CAP_NONREMOVABLE) && host->rescan_entered) {
>> +               __pm_relax(host->ws);
>
> By calling __pm_relax here, this indicates to me that is seems like
> you might have prevented, even for a very small timeslot, with a
> MMC_CAP_NONREMOVABLE card/host from the system to suspend.
>
> For sure, you must not prevent the suspend even for small timeslots,
> when MMC_CAP_NONREMOVABLE is set.
I agree. It appears that the corresponding __pm_stay_awake() is
indiscriminately called on system resume regardless of card type, so
this needs to be fixed.

>>         mmc_release_host(host);
>>
>>   out:
>> -       if (host->caps & MMC_CAP_NEEDS_POLL)
>> +       if (extend_wakeup)
>> +               /* extra 1/2 second should be enough, hopefully */
>> +               __pm_wakeup_event(host->ws, MSEC_PER_SEC/2);
>> +       else
>> +               __pm_relax(host->ws);
>> +
>> +       if (host->caps & MMC_CAP_NEEDS_POLL) {
>> +               __pm_stay_awake(host->ws);
>
> This does not make sense.
>
> So when using polling mode to detect card insert/remove, you will
> prevent suspend forever? Maybe I missed a point somewhere?
>
>>                 mmc_schedule_delayed_work(&host->detect, HZ);
>> +       }
>>  }
You are right, and I find it interesting that the same wake_lock()
call exists in the Android kernel. Would someone from the Android team
be able to comment?

>>         /* clear pm flags now and let card drivers set them as needed */
>> @@ -2628,7 +2645,8 @@ int mmc_suspend_host(struct mmc_host *host)
>>  {
>
> This function has become deprecated. You need to rebase this patch and
> please do not add some new code in here.
>
If suspend is now initiated from the bus level, will there be a
host-level suspend/resume function at all? I need to know where this
code should move in the next revision of patch...

Regards, Zoran
