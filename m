From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Thu, 02 Apr 2015 19:18:18 +0300
Message-ID: <551D6BCA.7040708@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>	<551BDAEA.20405@intel.com> <CAPDyKFrve0VmhvPk-=V64Cab8AcqvMkGxOM1Aju8gV+u3vFxyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:31234 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbbDBQSV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Apr 2015 12:18:21 -0400
In-Reply-To: <CAPDyKFrve0VmhvPk-=V64Cab8AcqvMkGxOM1Aju8gV+u3vFxyg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 2/04/2015 4:05 p.m., Ulf Hansson wrote:
> [...]
>
>>>
>>>>    - ability to enable / disable re-tuning
>>>
>>> Handled internally by the mmc core.
>>
>> The host controller driver enables re-tuning based on whether the host
>> controller requires it for that transfer mode. For example, only the SDHCI
>> host controller knows if tuning is required for SDR50 mode according to the
>> SDHCI capability register bit 45.
>
> That seems a bit silly.
>
> All hosts wants the re-tuning to be "enabled" if the current used
> speed mode requires it. It's not a host driver thing to deal with,
> just the core.

No it is up to the host controller. That is how it is in the
SD Host Controller Specification. Both whether to tune SDR50 and
whether to run a re-tuning timer.

Tuning is inherently a host controller problem. The card can always
receive correctly from the host, but the host has to adjust its
"sampling point" to receive from the card. Only the host knows its
capabilities in this regard.

>
> What's needed for the SDHCI case (in runtime PM suspend), is to be
> able to disable the re-tune timer and to flag that a re-tune is
> needed.

Yes that is how it works.

>         Both of these things can be dealt with from the
> mmc_retune_needed() API, since I believe there should never be a case
> when we want the re-tune timer to continue to run, when someone have
> set the need_retune flag.

The approach implemented is to update the timer when tuning takes place.
That allows mmc_retune_needed() simply to set a flag, so it can be called
from any context.

>
> [...]
>
>>>>    - ability to hold off re-tuning if the card is busy
>>>
>>> What do you mean by "card is busy"?
>>
>> I guess, more accurately, any time the card is in a state that is incapable
>> of supporting re-tuning. For example:
>>          - DAT0 busy
>>          - between dependent commands like erase start, end, etc
>>          - card is asleep
>> Also SDIO cards can have a custom sleep state where tuning won't work.
>>
>>> Is this requirement due to that the re-tune timer may complete at any
>>> point, which then flags that a re-tune is needed?
>>
>> Primarily. But control is also needed when handling recovery. Or in the SDIO
>> custom sleep case.
>>
>> There is also SDHCI re-tuning modes 2 and 3 (presently not supported) where
>> the host controller itself indicates that re-tuning is needed via the
>> present state and interrupt status registers.
>
> To me, I assume mmc_retune_needed() API should be enough to cover
> SDHCI mode 2 and 3, right?

Yes.

>
> Potentially mmc_retune_needed() may then be called from IRQ context so
> we just have to be sure the API also copes with that (thinking that
> cancelling the timer must not "sleep").

According to the SDHC spec, if the host controller will itself request
re-tuning, then no timer is to be used. So the having the mmc_retune_needed()
API simply set a flag, as it does now, makes sense.

>
> [...]
>
>>>
>>>>    - ability to run a re-tuning timer
>>>
>>> As we discussed earlier, it's not obvious when it make sense to run this timer.
>>>
>>> For the SDIO case, we should likely run it all the time, since we want
>>> to prevent I/O errors as long as possible.
>>>
>>> For MMC/SD, I would rather see that we perform re-tune as a part of an
>>> "idle operation" and not from a timer (yes I know about the SDHCI
>>> spec, but it doesn't make sense). We can do this because we are able
>>> to re-cover from I/O errors (re-trying when getting CRC errors for
>>> example).
>>
>> It makes sense to attempt to re-tune before CRC errors occur. If the
>> hardware vendor has gone to the trouble to determine when that might be,
>> then it makes sense to use that timeout. It is surely an approximation
>> (SDHCI only has values in powers-of-2 with units of seconds) but it seems
>> unreasonable to use a completely different value.
>
> I agree in cases where the hardware itself can measure heat and thus
> anticipate+signal when a re-tuning is needed. SDHCI mode 1 doesn't
> work like that, it's just a guess - as good as any. Therefore I would
> only use a timer in the SDIO case and rely on the recover sequence for
> the SD/MMC case.
>
> Now, I am not going to argue about this any more. Let's follow your
> suggestion and to make it possible to use a timer for _all_ cases.

Thank you! :-)

>
>>
>> Doing it in the idle operation would not work because we would then runtime
>> suspend and just have to do it again after resuming.
>
> That's correct, it will be completely useless for SDHCI. That's isn't
> the case for other hosts.
>
> Anyway, let's leave the "idle operation" scenarios out of this
> discussion. If considered, later it needs to be a configurable option.
>
> Kind regards
> Uffe
>
