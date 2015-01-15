From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH 02/13] mmc: host: Add facility to support re-tuning
Date: Thu, 15 Jan 2015 15:17:15 +0100
Message-ID: <54B7CBEB.9020404@broadcom.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>	<1417801271-15575-3-git-send-email-adrian.hunter@intel.com>	<CAPDyKFo_51e=BERS9qX6x_LbK3tM5aijOicVkhQ5==39b+C93Q@mail.gmail.com>	<54B51C55.9060500@intel.com>	<CAPDyKFpN285zHUZr61R51AuGwwXAJJsoUS7hbnmiO_+bQ=OuKQ@mail.gmail.com>	<54B52D53.8080106@intel.com>	<CAPDyKFr-U+z3B5bhfP36Lxju5=zS6ZxFL8usm4XypodYLZ0_dw@mail.gmail.com>	<54B53592.9070303@broadcom.com>	<CAPDyKFrs9SVt+8OSTHbkCFiY5ujdfXsqjg7E837CVZjEqz4EvA@mail.gmail.com>	<54B54187.7080008@broadcom.com>	<CAPDyKFqwQ+GPLv9T3fW3Y74hKhagKSOiXydvL9WoK8y3k0O6hQ@mail.gmail.com>	<54B63D94.2050602@intel.com>	<CAPDyKFosO9D6sQagk1nPRZ5aTMDhYu2P7Y5jzFUdA8gAcTNJog@mail.gmail.com>	<54B66015.1010507@intel.com>	<CAPDyKFrtByPeRvU-pSc62JjthRXQJyPkTR+PcNOSDeTPXwFEoA@mail.gmail.com>	<54B7
 93B2.8090100@intel.com> <CAPDyKFqAWR_L58=McCo0_GAUatm2373To8pduK+nV2cFZt8CnQ@mail.gmail.com> <54B7C9A7.1090803@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:48753 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbbAOOR1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 09:17:27 -0500
In-Reply-To: <54B7C9A7.1090803@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arindam Nath <arindam.nath@amd.com>, zhangfei.gao@marvell.com

On 01/15/15 15:07, Arend van Spriel wrote:
> On 01/15/15 14:39, Ulf Hansson wrote:
>> On 15 January 2015 at 11:17, Adrian Hunter<adrian.hunter@intel.com>
>> wrote:
>>> On 14/01/15 14:59, Ulf Hansson wrote:
>>>> [...]
>>>>
>>>>>>
>>>>>> The value from the register is also just randomly selected, only
>>>>>> difference is that it's the HW that has randomly set it.
>>>>>
>>>>> Presumably the value is chosen based on the maximum rate of
>>>>> temperature
>>>>> change and the corresponding effect that has on the signal.
>>>>>
>>>>>>
>>>>>> Even if the above commit was merged, I don't think it was the correct
>>>>>> way of dealing with re-tuning.
>>>>>>
>>>>>> First of all, re-tuning this is a mmc protocol specific thing should
>>>>>> be managed from the mmc core, like the approach you have taken in
>>>>>> your
>>>>>> $subject patchset. Second I question whether the timer is useful at
>>>>>> all.
>>>>>
>>>>> The SD Host Controller Specification does not document another way
>>>>> to do
>>>>> mode 1 re-tuning. The timer is it. Otherwise re-tuning is never done.
>>>>>
>>>>> In the patches I sent, the driver must call mmc_retune_needed() to set
>>>>> host->need_retune = 1 otherwise mmc_retune() does nothing.
>>>>>
>>>>> I would like to extend the model to include transparently re-tuning
>>>>> and
>>>>> re-trying when there is a CRC error, but that is a separate issue, not
>>>>> documented in the spec but recommended by others.
>>>>>
>>>>
>>>> That perfect and in line from what I heard as recommendations from
>>>> memory vendors as well.
>>>
>>> How would that work for SDIO? How do you know it is OK to retry SDIO
>>> operations?
>>
>> Retries or error handling, needs to be handled from SDIO func drivers
>> or upper level code. They certainly also need it for other errors,
>> which are not caused by the lack of a re-tune. I believe they exist
>> already.
>>
>> For mmc core point of view, we need to act on SDIO data transfers
>> errors and perform re-tuning for cases when it makes sense.
>>
>> More importantly, using a timer won't make SDIO data transfers error
>> free, since we can still end up needing a re-tune at any point.
>>
>> Still, you do have point for SDIO. Minimizing the number of errors for
>> SDIO could be important, due to that an SDIO func driver may not be
>> able to recover from data errors as smoothly as the mmc block layer
>> can. Thus, a timer could help to improve the situation, but I think it
>> only makes sense in the SDIO case.
>>
>> BTW, what's your experience around SDIO cards supporting SDR104. I
>> have never used such, have you?
>
> My primary focus in all this discussing is about SDIO cards. The main
> reason being that our 11ac wifi SDIO cards do support SDR104. So the
> brcmfmac driver support SDIO and has retry mechanisms in place. However,
> it may also end-up doing an abort under certain conditions.
>
> You also mentioned using runtime-pm, but how do you deal with func
> drivers not supporting runtime-pm. That is already an issue aka. bug
> right now. Our driver does not support runtime-pm (yet) and we have
> reported issues that host controller does runtime-pm basically killing
> communication between device and func driver.

Could leave it to the function driver to call mmc_retune_needed().

Regards,
Arend

> Gr. AvS
>
>>>
>>>>
>>>> Now, can we stop arguing about the timer and try without it?
>>>>
>>>> If we do see a need for a more frequent re-tuning to happen, due to
>>>> that we get lots of CRC errors to recover from, then I think we should
>>>> look into using runtime PM instead of the timer. And that's because I
>>>> want to minimize the impact on performance.
>>>
>>> The minimum timer value is 1 second. The maximum is 1024 seconds. The
>>> ASUS
>>> T100TA had a timer value of 128 seconds. The timer is not a
>>> performance issue.
>>>
>>> There is a performance question with runtime PM because that happens far
>>> more frequently (typical auto-suspend delay is 50ms) and we re-tune
>>> after
>>> that. In fact I generalized that a bit in patch 13.
>>>
>>> [PATCH 13/13] mmc: sdhci: Change to new way of doing re-tuning
>>>
>>> Make use of mmc core support for re-tuning instead
>>> of doing it all in the sdhci driver.
>>>
>>> This patch also changes to flag the need for re-tuning
>>> always after runtime suspend when tuning has been used
>>> at initialization. Previously it was only done if
>>> the re-tuning timer was in use.
>>>
>>> One option to reduce the impact of the latency would be to increase the
>>> auto-suspend delay.
>>
>> The latency will affect the first request after a runtime PM
>> suspend/resume cycle. So for continues data transfers the impact
>> should be zero. Also, increasing the delay would impact power
>> consumption, but it's a balance I guess. :-)
>>
>> This is a specific issue for SDHCI (it's not clear to me if all SDHCI
>> variants have the same behaviour). Obviously the mmc core needs to
>> support the demand from SDHCI, such enable it to tell the core to
>> perform a re-tune. Exactly what your patchset does.
>>
>> For your reference, I know about other controllers which can restore a
>> bunch of register values, saved from earlier re-tunings, from its
>> runtime PM resume callbacks. Thus preventing a re-tuning from happen.
>> I wonder if some of the SDHCI variant are capable of this as well.
>>
>>
>> Kind regards
>> Uffe
>

