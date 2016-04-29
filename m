From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 10/23] mmc: core: disable auto retune during card
 detection process
Date: Fri, 29 Apr 2016 09:54:13 +0300
Message-ID: <57230515.9030602@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
 <571A1D85.3020200@intel.com>
 <CAA+hA=R9JfV4ScuM=OZ3VHdSiQiMO9io8mQQDNXfkTwNv7RVvg@mail.gmail.com>
 <5721B602.6010306@intel.com>
 <20160428132249.GB27560@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:21072 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbcD2G6D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Apr 2016 02:58:03 -0400
In-Reply-To: <20160428132249.GB27560@shlinux2.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, haibo.chen@nxp.com

On 28/04/16 16:22, Dong Aisheng wrote:
> On Thu, Apr 28, 2016 at 10:04:34AM +0300, Adrian Hunter wrote:
>> On 24/04/16 13:47, Dong Aisheng wrote:
>>> On Fri, Apr 22, 2016 at 8:48 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 15/04/16 20:29, Dong Aisheng wrote:
>>>>> During card detection process, mmc core may sends commands
>>>>> to detect if card is still exist in mmc_rescan for removable
>>>>> card which may trigger mmc retuning process after a bit time
>>>>> of runtime pm suspend.
>>>>> Obviously this retuning process is meaningless for card remove
>>>>> case, so we disable mmc_retune in mmc_detect_change() for it.
>>>>> For card insert case, the mmc_retune will be enabled normally
>>>>> in its card initialization process later in mmc_execute_tuning().
>>>>> So disable it at first has no side effection.
>>>>
>>>> We don't assume that the card has been removed, which is why we send
>>>> commands to find out if it is still there.  If it is still there, this
>>>> change will have incorrectly disabled re-tuning.
>>>>
>>>
>>> Do you mean the 'fake' card remove interrupt like caused by glitch?
>>
>> Sure
>>
>>> Yes, if that the card is still exist and re-tuning is wrongly disabled.
>>>
>>> So we could re-enable re-tuning for this special case?
>>> Something like:
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 41b1e76..e1990a8 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -2607,6 +2607,8 @@ void mmc_rescan(struct work_struct *work)
>>>
>>>         /* if there still is a card present, stop here */
>>>         if (host->bus_ops != NULL) {
>>> +               if (tuning_is_enabled_before())
>>> +                       mmc_retune_enable(host);
>>>                 mmc_bus_put(host);
>>>                 goto out;
>>>         }
>>>
>>>
>>>> Do you have an actual problem with the way it works now?
>>>>
>>>
>>> No actual problems now.
>>
>> So let's not spend time on it.
>>
>>> I just observe a lot tuning commands keep sending although the card is already
>>> removed which seems a bit meaningless.
>>> And most tuning execution process is executed with sin_lock_irqsave, i'm not
>>> sure if the mass tuning commands may affect the system when CPU is busy.
>>> What do you think?
>>
>> sdhci spin lock is unlocked while waiting for tuning commands.
>>
> 
> It's 40 commands continuously and only cmd transfer time is unlocked.

Not for sdhci_execute_tuning() it's not.  Only one command is sent.
Currently we don't even send the CMD13 because we check card detect first.
I added prints for sdhci_execute_tuning and got this:

[  255.536326] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000080
[  255.743653] mmc1: starting CMD13 arg 59b40000 flags 00000195
[  255.750093] mmc1: sdhci_execute_tuning
[  255.754358] mmc1: sdhci_execute_tuning: send command
[  255.809638] sdhci: Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock
[  255.824810] mmc1: req failed (CMD13): -123, retrying...
[  255.832766] mmc1: req failed (CMD13): -123, retrying...
[  255.840722] mmc1: req failed (CMD13): -123, retrying...
[  255.848672] mmc1: req done (CMD13): -123: 00000000 00000000 00000000 00000000
[  255.856773] mmc1: card remove detected
[  255.861056] mmc1: card 59b4 removed
[  255.872872] mmc1: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 0 timing 0

> 
> Hmm.. I can't sure it's no affection.
> e.g we did have customers reporting cd plug in/out causing jitters
> when system is busy playing audio or video.
> Maybe we need to do those tests.
> 
> Anyway, what's your point to keep sending tuning commands after card
> is already removed?

Seems like a problem for your driver not the core.  Why not check card detect
after the first error in esdhc_executing_tuning().

> 
> Regards
> Dong Aisheng
> 
>>>
>>> Regards
>>> Dong Aisheng
>>>
>>>>>
>>>>> CC: stable <stable@vger.kernel.org>
>>>>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>>>>> ---
>>>>>  drivers/mmc/core/core.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 52bfaf0..76d0802 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -1888,6 +1888,7 @@ static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
>>>>>               pm_wakeup_event(mmc_dev(host), 5000);
>>>>>
>>>>>       host->detect_change = 1;
>>>>> +     mmc_retune_disable(host);
>>>>>       mmc_schedule_delayed_work(&host->detect, delay);
>>>>>  }
>>>>>
>>>>>
>>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

