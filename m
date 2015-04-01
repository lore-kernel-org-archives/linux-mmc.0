From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH V4 01/15] mmc: host: Add facility to support re-tuning
Date: Wed, 1 Apr 2015 17:10:04 +0200
Message-ID: <551C0A4C.9020602@broadcom.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>	<1427489863-9050-2-git-send-email-adrian.hunter@intel.com> <CAPDyKFrs4X+nDDkikUNSO5uz+Wsoz3TmkLJ9RwvvdjYqd8+Ygg@mail.gmail.com> <551BDAEA.20405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:4940 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbbDAPKJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2015 11:10:09 -0400
In-Reply-To: <551BDAEA.20405@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>

On 04/01/15 13:47, Adrian Hunter wrote:
> On 01/04/15 12:50, Ulf Hansson wrote:
>> On 27 March 2015 at 21:57, Adrian Hunter<adrian.hunter@intel.com>  wrote:
>>> Currently, there is core support for tuning during
>>> initialization. There can also be a need to re-tune
>>> periodically (e.g. sdhci) or to re-tune after the
>>> host controller is powered off (e.g. after PM
>>> runtime suspend / resume) or to re-tune in response
>>> to CRC errors.
>>>
>>> The main requirements for re-tuning are:
>>
>> It's a bit hard to follow why these requirements.
>
> Yes they are driven by SDHCI requirements.
>
>>
>> I am giving some comments below, also for my own reference. Please
>> tell me if I am way off.
>>
>>>    - ability to enable / disable re-tuning
>>
>> Handled internally by the mmc core.
>
> The host controller driver enables re-tuning based on whether the host
> controller requires it for that transfer mode. For example, only the SDHCI
> host controller knows if tuning is required for SDR50 mode according to the
> SDHCI capability register bit 45.
>
>>
>> Or maybe SDIO func drivers needs an API to control this?
>
> No - it is for the host controller drivers.
>
>>
>>>    - ability to flag that re-tuning is needed
>>
>> Both from mmc core and mmc host point of view.
>
> At the moment only the host controller driver flags re-tuning is needed.
>
>>
>>>    - ability to re-tune before any request
>>
>> Internal mechanism by the core.
>
> Yes
>
>>
>>>    - ability to hold off re-tuning if the card is busy
>>
>> What do you mean by "card is busy"?
>
> I guess, more accurately, any time the card is in a state that is incapable
> of supporting re-tuning. For example:
> 	- DAT0 busy

This state is not specific to re-tuning. An SDIO device can keep DAT0 
busy at which the host controller can not start another request.

> 	- between dependent commands like erase start, end, etc
> 	- card is asleep
> Also SDIO cards can have a custom sleep state where tuning won't work.

Our SDIO wifi device has such a state and it can only come out of it 
upon CMD52 write or CMD14 (ExitSleep).

Regards,
Arend

>> Is this requirement due to that the re-tune timer may complete at any
>> point, which then flags that a re-tune is needed?
>
> Primarily. But control is also needed when handling recovery. Or in the SDIO
> custom sleep case.
>
> There is also SDHCI re-tuning modes 2 and 3 (presently not supported) where
> the host controller itself indicates that re-tuning is needed via the
> present state and interrupt status registers.
>
>>
>>>    - ability to hold off re-tuning if re-tuning is in
>>>    progress
>>
>> This I don't understand. How can a re-tune sequence be triggered when
>> there is already a request ongoing towards the host. I mean the host
>> is claimed during the re-tuning process, so why do we need one more
>> layer of protection?
>
> This is primarily for safety. We shouldn't have to think about what would
> happen if the need_retune flag is set at an inopportune time.
>
>>
>>>    - ability to run a re-tuning timer
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
>
> Doing it in the idle operation would not work because we would then runtime
> suspend and just have to do it again after resuming.
>
>>
>> I will continue to review the rest of series in more detail.
>
> Thank you! :-)
>
>

