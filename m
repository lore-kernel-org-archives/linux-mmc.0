From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Tue, 14 Apr 2015 16:38:03 +0300
Message-ID: <552D183B.5080409@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>	<551BDAEA.20405@intel.com>	<551C0A4C.9020602@broadcom.com>	<CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>	<551D1A59.5060803@broadcom.com>	<CAPDyKFqdwQVEoKWH-Et32PZxVrcOabt7rek=Xq01yLmebgXuOA@mail.gmail.com>	<551D3391.8040508@intel.com>	<CAPDyKFrFoiKFC+i_TF_NR9Mg6b9JxzqRHyyN72z331s+0Gge2A@mail.gmail.com>	<551D35C6.7070605@broadcom.com>	<551D396F.1020301@intel.com>	<CAPDyKFpyu5fYw4e_ptP-WYfsQWmJairu4CnVk7abOvE5pZJU8g@mail.gmail.com>	<5524DBD1.8020606@intel.com> <CAPDyKFr+Q=tjL5NqDHr566cj7n4xNAt6Z3kEnyUFBfFtO-4Hvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21333 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752877AbbDNNk2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Apr 2015 09:40:28 -0400
In-Reply-To: <CAPDyKFr+Q=tjL5NqDHr566cj7n4xNAt6Z3kEnyUFBfFtO-4Hvg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arend van Spriel <arend@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Neil Brown <neil@brown.name>

On 13/04/15 15:07, Ulf Hansson wrote:
> On 8 April 2015 at 09:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 02/04/15 17:00, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>>>>>>>> Also SDIO cards can have a custom sleep state where tuning won't work.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Our SDIO wifi device has such a state and it can only come out of it
>>>>>>>>>>> upon
>>>>>>>>>>> CMD52 write or CMD14 (ExitSleep).
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> So how will the mmc core know about these states? I guess we will
>>>>>>>>>> require SDIO func drivers to deal with enable/disable or hold/release
>>>>>>>>>> of re-tuning then?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This is actually why in the past we tried to only kick off retuning
>>>>>>>>> before a
>>>>>>>>> request that requires use of data line(s) so mmc core (or sdhci) would not
>>>>>>>>> do re-tuning when SDIO func used CMD52 to wakeup the device. I never tried
>>>>>>>>> CMD14 approach and not even sure from which spec it comes (maybe eMMC).
>>>>>>>>
>>>>>>>> That's an interesting idea. It would eliminate the need for SDIO func
>>>>>>>> drivers to care about holding/releasing re-tuning.
>>>>>>>>
>>>>>>>> Would be nice to hear about Adrian's thoughts around this as well.
>>>>>>>
>>>>>>> I don't see how it would work because re-tuning is needed after the host
>>>>>>> controller runtime resumes. i.e. once the SDIO wifi card stops being active
>>>>>>> the host controller will runtime suspend.
>>>>>>
>>>>>> Why do we always need to re-tune from this phase?
>>>>>>
>>>>>> What Arend points out is that we could "delay" the re-tune until we
>>>>>> know there is a DATA request. Wouldn't that work for SDHCI as well?
>>>>>
>>>>> You beat me to it, but that is indeed what I meant.
>>>>
>>>> The CMD line needs tuning too, so delaying tuning on every command will
>>>> cause errors. It is better to hold tuning for the specific command used to
>>>> wake-up.
>>>
>>> Hmm.
>>>
>>> This touches the discussion where Neil Brown also was involved, around
>>> how to handle "idle operations" for SDIO.
>>>
>>> How does SDIO func drivers detects "request inactivity", which
>>> triggers them to send its device to "sleep mode"? That answer should
>>> be runtime PM.
>>
>> Using runtime pm for custom sleep states would seem to conflict with its use
>> by the power domain. For example ACPI will enumerate embedded SDIO function
>> devices and link them to the ACPI power domain. Then ACPI will choose the
>> lowest power state for runtime suspend.
>>
>> It isn't obvious how a driver that doesn't know its power domain should
>> handle runtime pm, other than assuming it means power off.
> 
> I am not sure what you mean by "power off" in this context. Is that

I guess "power off" is the wrong term. They might have to assume they have
lost device context.

You should ask the power management mailing list what assumptions a device
driver can make about the use of runtime pm. If you do, please cc me.

> the power of the actual SDIO card? I don't think so, but I may be
> wrong.

I was talking about SDIO function devices.

> 
> To enumerate a SDIO card the mmc core first needs to apply power to
> it. At this point the PM domain isn't yet attached to the SDIO func
> device (the device doesn't even exist yet) and thus it can't be used
> to provide power the card. Right?

In the ACPI case the SDIO function device ACPI nodes are children of the
host controller ACPI node. One possibility is to have the host controller
driver power on its children.

> 
>>
>>>
>>> So, from mmc core perspective we should be able to get notifications
>>> through runtime PM callbacks (from mmc or sdio bus) to understand
>>> whether we need to hold of re-tune.
>>
>> That doesn't match the requirement. Re-tuning needs to be held for the
>> wake-up command, not while asleep.
>>
> 
> Why should we ever want to re-tune if the card is in a sleep state?
> Isn't it better to postpone that until it wakes up?

That is what I was saying i.e. hold re-tuning for the wake-up command.
So if re-tuning is needed it is done after the wake-up command.


