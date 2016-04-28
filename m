From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 10/23] mmc: core: disable auto retune during card
 detection process
Date: Thu, 28 Apr 2016 10:04:34 +0300
Message-ID: <5721B602.6010306@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
 <571A1D85.3020200@intel.com>
 <CAA+hA=R9JfV4ScuM=OZ3VHdSiQiMO9io8mQQDNXfkTwNv7RVvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1398 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbcD1HIZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2016 03:08:25 -0400
In-Reply-To: <CAA+hA=R9JfV4ScuM=OZ3VHdSiQiMO9io8mQQDNXfkTwNv7RVvg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On 24/04/16 13:47, Dong Aisheng wrote:
> On Fri, Apr 22, 2016 at 8:48 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 15/04/16 20:29, Dong Aisheng wrote:
>>> During card detection process, mmc core may sends commands
>>> to detect if card is still exist in mmc_rescan for removable
>>> card which may trigger mmc retuning process after a bit time
>>> of runtime pm suspend.
>>> Obviously this retuning process is meaningless for card remove
>>> case, so we disable mmc_retune in mmc_detect_change() for it.
>>> For card insert case, the mmc_retune will be enabled normally
>>> in its card initialization process later in mmc_execute_tuning().
>>> So disable it at first has no side effection.
>>
>> We don't assume that the card has been removed, which is why we send
>> commands to find out if it is still there.  If it is still there, this
>> change will have incorrectly disabled re-tuning.
>>
> 
> Do you mean the 'fake' card remove interrupt like caused by glitch?

Sure

> Yes, if that the card is still exist and re-tuning is wrongly disabled.
> 
> So we could re-enable re-tuning for this special case?
> Something like:
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 41b1e76..e1990a8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2607,6 +2607,8 @@ void mmc_rescan(struct work_struct *work)
> 
>         /* if there still is a card present, stop here */
>         if (host->bus_ops != NULL) {
> +               if (tuning_is_enabled_before())
> +                       mmc_retune_enable(host);
>                 mmc_bus_put(host);
>                 goto out;
>         }
> 
> 
>> Do you have an actual problem with the way it works now?
>>
> 
> No actual problems now.

So let's not spend time on it.

> I just observe a lot tuning commands keep sending although the card is already
> removed which seems a bit meaningless.
> And most tuning execution process is executed with sin_lock_irqsave, i'm not
> sure if the mass tuning commands may affect the system when CPU is busy.
> What do you think?

sdhci spin lock is unlocked while waiting for tuning commands.

> 
> Regards
> Dong Aisheng
> 
>>>
>>> CC: stable <stable@vger.kernel.org>
>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>> ---
>>>  drivers/mmc/core/core.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 52bfaf0..76d0802 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1888,6 +1888,7 @@ static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>>>               pm_wakeup_event(mmc_dev(host), 5000);
>>>
>>>       host->detect_change = 1;
>>> +     mmc_retune_disable(host);
>>>       mmc_schedule_delayed_work(&host->detect, delay);
>>>  }
>>>
>>>
>>
> 

