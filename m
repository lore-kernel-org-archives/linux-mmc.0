From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Thu, 2 Apr 2015 12:30:49 +0200
Message-ID: <551D1A59.5060803@broadcom.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>	<551BDAEA.20405@intel.com>	<551C0A4C.9020602@broadcom.com> <CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:1826 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbDBKaz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Apr 2015 06:30:55 -0400
In-Reply-To: <CAPDyKFp=DBj1==KVBxbZqE9Zo9F7QAxENcU_dqXUb5pvyNrv5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>

On 04/02/15 10:43, Ulf Hansson wrote:
> [...]
>>>>>     - ability to hold off re-tuning if the card is busy
>>>>
>>>>
>>>> What do you mean by "card is busy"?
>>>
>>>
>>> I guess, more accurately, any time the card is in a state that is
>>> incapable
>>> of supporting re-tuning. For example:
>>>          - DAT0 busy
>>
>>
>> This state is not specific to re-tuning. An SDIO device can keep DAT0 busy
>> at which the host controller can not start another request.
>
> Not entirely true. Some commands are allowed during this period, for
> example CMD13 (which doesn't exist for SDIO)

Yeah. I was wondering whether to mention that.

> Anyway, I get the point. Thanks!
>
>>
>>>          - between dependent commands like erase start, end, etc
>>>          - card is asleep
>>> Also SDIO cards can have a custom sleep state where tuning won't work.
>>
>>
>> Our SDIO wifi device has such a state and it can only come out of it upon
>> CMD52 write or CMD14 (ExitSleep).
>
> So how will the mmc core know about these states? I guess we will
> require SDIO func drivers to deal with enable/disable or hold/release
> of re-tuning then?

This is actually why in the past we tried to only kick off retuning 
before a request that requires use of data line(s) so mmc core (or 
sdhci) would not do re-tuning when SDIO func used CMD52 to wakeup the 
device. I never tried CMD14 approach and not even sure from which spec 
it comes (maybe eMMC).

> I don't like this, but if there is no other way... Also, we must be
> very careful on which API we exports for SDIO func drivers to use. The
> can easily be misinterpreted.
>
> [...]
>
> Kind regards
> Uffe

Regards,
Arend
