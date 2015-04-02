From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Thu, 2 Apr 2015 16:00:52 +0200
Message-ID: <CAPDyKFpyu5fYw4e_ptP-WYfsQWmJairu4CnVk7abOvE5pZJU8g@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:32933 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbDBOAw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Apr 2015 10:00:52 -0400
Received: by qcrf4 with SMTP id f4so55081697qcr.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Apr 2015 07:00:52 -0700 (PDT)
In-Reply-To: <551D396F.1020301@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arend van Spriel <arend@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Neil Brown <neil@brown.name>

[...]

>>>>>>>>> Also SDIO cards can have a custom sleep state where tuning won't work.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Our SDIO wifi device has such a state and it can only come out of it
>>>>>>>> upon
>>>>>>>> CMD52 write or CMD14 (ExitSleep).
>>>>>>>
>>>>>>>
>>>>>>> So how will the mmc core know about these states? I guess we will
>>>>>>> require SDIO func drivers to deal with enable/disable or hold/release
>>>>>>> of re-tuning then?
>>>>>>
>>>>>>
>>>>>> This is actually why in the past we tried to only kick off retuning
>>>>>> before a
>>>>>> request that requires use of data line(s) so mmc core (or sdhci) would not
>>>>>> do re-tuning when SDIO func used CMD52 to wakeup the device. I never tried
>>>>>> CMD14 approach and not even sure from which spec it comes (maybe eMMC).
>>>>>
>>>>> That's an interesting idea. It would eliminate the need for SDIO func
>>>>> drivers to care about holding/releasing re-tuning.
>>>>>
>>>>> Would be nice to hear about Adrian's thoughts around this as well.
>>>>
>>>> I don't see how it would work because re-tuning is needed after the host
>>>> controller runtime resumes. i.e. once the SDIO wifi card stops being active
>>>> the host controller will runtime suspend.
>>>
>>> Why do we always need to re-tune from this phase?
>>>
>>> What Arend points out is that we could "delay" the re-tune until we
>>> know there is a DATA request. Wouldn't that work for SDHCI as well?
>>
>> You beat me to it, but that is indeed what I meant.
>
> The CMD line needs tuning too, so delaying tuning on every command will
> cause errors. It is better to hold tuning for the specific command used to
> wake-up.

Hmm.

This touches the discussion where Neil Brown also was involved, around
how to handle "idle operations" for SDIO.

How does SDIO func drivers detects "request inactivity", which
triggers them to send its device to "sleep mode"? That answer should
be runtime PM.

So, from mmc core perspective we should be able to get notifications
through runtime PM callbacks (from mmc or sdio bus) to understand
whether we need to hold of re-tune.

I know, it's a bit of a vague idea so I will give it some more
thinking during the Easter holidays.

Kind regards
Uffe
