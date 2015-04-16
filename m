From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Thu, 16 Apr 2015 13:28:44 +0200
Message-ID: <CAPDyKFrcMRrLm5t8vtkcYsqzNM3AZ21A-fmSG5SiVYpVkMNyeA@mail.gmail.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>
	<551BDAEA.20405@intel.com>
	<551C0A4C.9020602@broadcom.com>
	<CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>
	<551D1A59.5060803@broadcom.com>
	<CAPDyKFqdwQVEoKWH-Et32PZxVrcOabt7rek=Xq01yLmebgXuOA@mail.gmail.com>
	<551D3391.8040508@intel.com>
	<CAPDyKFrFoiKFC+i_TF_NR9Mg6b9JxzqRHyyN72z331s+0Gge2A@mail.gmail.com>
	<551D35C6.7070605@broadcom.com>
	<551D396F.1020301@intel.com>
	<CAPDyKFpyu5fYw4e_ptP-WYfsQWmJairu4CnVk7abOvE5pZJU8g@mail.gmail.com>
	<5524DBD1.8020606@intel.com>
	<CAPDyKFr+Q=tjL5NqDHr566cj7n4xNAt6Z3kEnyUFBfFtO-4Hvg@mail.gmail.com>
	<552D183B.5080409@intel.com>
	<CAPDyKFqaj9cy5h6mz90D7P49KG2dPTKV2vDAA_NuhiGPCaCNag@mail.gmail.com>
	<552F79E0.2070706@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36067 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbbDPL2p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 07:28:45 -0400
Received: by qku63 with SMTP id 63so130275229qku.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 04:28:45 -0700 (PDT)
In-Reply-To: <552F79E0.2070706@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arend van Spriel <arend@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Neil Brown <neil@brown.name>

On 16 April 2015 at 10:59, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 16/04/15 10:24, Ulf Hansson wrote:
>> [...]
>>
>>>>>
>>>>> Using runtime pm for custom sleep states would seem to conflict with its use
>>>>> by the power domain. For example ACPI will enumerate embedded SDIO function
>>>>> devices and link them to the ACPI power domain. Then ACPI will choose the
>>>>> lowest power state for runtime suspend.
>>>>>
>>>>> It isn't obvious how a driver that doesn't know its power domain should
>>>>> handle runtime pm, other than assuming it means power off.
>>>>
>>>> I am not sure what you mean by "power off" in this context. Is that
>>>
>>> I guess "power off" is the wrong term. They might have to assume they have
>>> lost device context.
>>>
>>> You should ask the power management mailing list what assumptions a device
>>> driver can make about the use of runtime pm. If you do, please cc me.
>>>
>>>> the power of the actual SDIO card? I don't think so, but I may be
>>>> wrong.
>>>
>>> I was talking about SDIO function devices.
>>
>> OK!
>>
>>>
>>>>
>>>> To enumerate a SDIO card the mmc core first needs to apply power to
>>>> it. At this point the PM domain isn't yet attached to the SDIO func
>>>> device (the device doesn't even exist yet) and thus it can't be used
>>>> to provide power the card. Right?
>>>
>>> In the ACPI case the SDIO function device ACPI nodes are children of the
>>> host controller ACPI node. One possibility is to have the host controller
>>> driver power on its children.
>>>
>>>>
>>>>>
>>>>>>
>>>>>> So, from mmc core perspective we should be able to get notifications
>>>>>> through runtime PM callbacks (from mmc or sdio bus) to understand
>>>>>> whether we need to hold of re-tune.
>>>>>
>>>>> That doesn't match the requirement. Re-tuning needs to be held for the
>>>>> wake-up command, not while asleep.
>>>>>
>>>>
>>>> Why should we ever want to re-tune if the card is in a sleep state?
>>>> Isn't it better to postpone that until it wakes up?
>>>
>>> That is what I was saying i.e. hold re-tuning for the wake-up command.
>>> So if re-tuning is needed it is done after the wake-up command.
>>>
>>
>> Okay. So that means we might be able to use runtime PM from the SDIO
>> func driver to notify the mmc core through the mmc or sdio bus's
>> runtime PM callback to understand whether we should hold/allow
>> re-tune.
>
> I don't see how that would work. Only the SDIO function driver knows that
> tuning can't be done before it's wake-up command. So you still need an API.

Let me elaborate on what I have in mind.

The SDIO function driver do pm_runtime_put*() when it's ready to allow
its device to go into sleep state.

At some point later, the sleep state is about to be entered. If there
are any specific operations the SDIO func driver needs to do to put
its device into sleep state, that should be managed through the SDIO
func driver's runtime PM ->suspend() callback (potentially a PM domain
may be involved as well).

When the mmc/sdio bus' runtime PM ->suspend() callback will be
triggered, it indicates to the mmc core to hold retune. So, when the
sleep state of the SDIO func device has been reached, re-tune is being
held by the mmc core.

At some point later, an SDIO irq is triggered.

The SDIO func driver's irq handler will be triggered and should make
sure the needed wakeup SDIO command to be sent.

When the SDIO wakeup command has been sent, the SDIO func driver will
invoke pm_runtime_get() to fully wakeup its func device from the sleep
state.

The mmc/sdio bus' runtime PM ->resume() callback will thus be invoked
as a part of the wakeup sequence of the SDIO func device, but _after_
the actual SDIO wakeup command has been sent. The mmc/sdio bus'
runtime PM ->resume() callback shall then release retune.

Finally the SDIO func driver starts handling the request.

>
>>
>> That do requires some additional re-work, both from mmc core point of
>> view and from SDIO func drivers point of view. I will have a look in
>> more detail to see if this really is viable.
>>
>> The goal from my side is to prevent us from exporting unnecessary APIs
>> and thus mmc_retune_hold() and mmc_retune_release() could also be
>> internal functions of the mmc core.
>
> That is fine if you have an alternative, but we can't wait forever.
>

True.

So, I will continue to investigate the runtime PM proposal and I
appreciate to get your and other opinions.

While I do that, let's continue to move forward with the approach you
have taken in @subject patchset.

Kind regards
Uffe
