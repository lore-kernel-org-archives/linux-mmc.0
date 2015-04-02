From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Thu, 2 Apr 2015 15:05:39 +0200
Message-ID: <CAPDyKFrve0VmhvPk-=V64Cab8AcqvMkGxOM1Aju8gV+u3vFxyg@mail.gmail.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com>
	<551BDAEA.20405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33796 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbbDBNFk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Apr 2015 09:05:40 -0400
Received: by qgep97 with SMTP id p97so68573980qge.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Apr 2015 06:05:39 -0700 (PDT)
In-Reply-To: <551BDAEA.20405@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

[...]

>>
>>>   - ability to enable / disable re-tuning
>>
>> Handled internally by the mmc core.
>
> The host controller driver enables re-tuning based on whether the host
> controller requires it for that transfer mode. For example, only the SDHCI
> host controller knows if tuning is required for SDR50 mode according to the
> SDHCI capability register bit 45.

That seems a bit silly.

All hosts wants the re-tuning to be "enabled" if the current used
speed mode requires it. It's not a host driver thing to deal with,
just the core.

What's needed for the SDHCI case (in runtime PM suspend), is to be
able to disable the re-tune timer and to flag that a re-tune is
needed. Both of these things can be dealt with from the
mmc_retune_needed() API, since I believe there should never be a case
when we want the re-tune timer to continue to run, when someone have
set the need_retune flag.

[...]

>>>   - ability to hold off re-tuning if the card is busy
>>
>> What do you mean by "card is busy"?
>
> I guess, more accurately, any time the card is in a state that is incapable
> of supporting re-tuning. For example:
>         - DAT0 busy
>         - between dependent commands like erase start, end, etc
>         - card is asleep
> Also SDIO cards can have a custom sleep state where tuning won't work.
>
>> Is this requirement due to that the re-tune timer may complete at any
>> point, which then flags that a re-tune is needed?
>
> Primarily. But control is also needed when handling recovery. Or in the SDIO
> custom sleep case.
>
> There is also SDHCI re-tuning modes 2 and 3 (presently not supported) where
> the host controller itself indicates that re-tuning is needed via the
> present state and interrupt status registers.

To me, I assume mmc_retune_needed() API should be enough to cover
SDHCI mode 2 and 3, right?

Potentially mmc_retune_needed() may then be called from IRQ context so
we just have to be sure the API also copes with that (thinking that
cancelling the timer must not "sleep").

[...]

>>
>>>   - ability to run a re-tuning timer
>>
>> As we discussed earlier, it's not obvious when it make sense to run this timer.
>>
>> For the SDIO case, we should likely run it all the time, since we want
>> to prevent I/O errors as long as possible.
>>
>> For MMC/SD, I would rather see that we perform re-tune as a part of an
>> "idle operation" and not from a timer (yes I know about the SDHCI
>> spec, but it doesn't make sense). We can do this because we are able
>> to re-cover from I/O errors (re-trying when getting CRC errors for
>> example).
>
> It makes sense to attempt to re-tune before CRC errors occur. If the
> hardware vendor has gone to the trouble to determine when that might be,
> then it makes sense to use that timeout. It is surely an approximation
> (SDHCI only has values in powers-of-2 with units of seconds) but it seems
> unreasonable to use a completely different value.

I agree in cases where the hardware itself can measure heat and thus
anticipate+signal when a re-tuning is needed. SDHCI mode 1 doesn't
work like that, it's just a guess - as good as any. Therefore I would
only use a timer in the SDIO case and rely on the recover sequence for
the SD/MMC case.

Now, I am not going to argue about this any more. Let's follow your
suggestion and to make it possible to use a timer for _all_ cases.

>
> Doing it in the idle operation would not work because we would then runtime
> suspend and just have to do it again after resuming.

That's correct, it will be completely useless for SDHCI. That's isn't
the case for other hosts.

Anyway, let's leave the "idle operation" scenarios out of this
discussion. If considered, later it needs to be a configurable option.

Kind regards
Uffe
