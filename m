From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: max_discard anomaly on certain Sandisk eMMC
Date: Tue, 17 Dec 2013 19:05:20 +0800
Message-ID: <CAA+hA=RL6f5-Z1T0ahWMn6TNtKvjQhy6CiHORYEUn6KXSC2oXg@mail.gmail.com>
References: <52AB8DA2.9000001@wwwdotorg.org>
	<52AF8A30.9050700@wwwdotorg.org>
	<52B008AB.7060909@intel.com>
	<CAPDyKFooKY7nyOdLxQS-u9oC_pZL3V8pH5kixLgQpUkPG=kqKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35090 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab3LQLFV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 06:05:21 -0500
In-Reply-To: <CAPDyKFooKY7nyOdLxQS-u9oC_pZL3V8pH5kixLgQpUkPG=kqKw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On Tue, Dec 17, 2013 at 6:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 17 December 2013 09:17, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 17/12/13 01:18, Stephen Warren wrote:
>>> On 12/13/2013 03:43 PM, Stephen Warren wrote:
>>>> On one of my eMMC devices, I see the following results from calling
>>>> mmc_do_calc_max_discard() with various parameters:
>>>>
>>>> [    3.057263] MMC_DISCARD_ARG max_discard 1
>>>> [    3.057266] MMC_ERASE_ARG   max_discard 4096
>>>> [    3.057267] MMC_TRIM_ARG    max_discard 1
>>>>
>>>> This causes mmc_calc_max_discard() to return 1, which makes the discard
>>>> IOCTL extremely slow.
>>>
>>> Further investigation shows that if I make a few hacks that essentially
>>> revert e056a1b5b67b "mmc: queue: let host controllers specify maximum
>>> discard timeout":
>>>
>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>> index 357bbc54fe4b..e66af930d0e3 100644
>>> --- a/drivers/mmc/card/queue.c
>>> +++ b/drivers/mmc/card/queue.c
>>> @@ -167,13 +167,15 @@ static void mmc_queue_setup_discard(struct
>>> request_queue *q,
>>>               return;
>>>
>>>       queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>>> -     q->limits.max_discard_sectors = max_discard;
>>> +     q->limits.max_discard_sectors = UINT_MAX;
>>>       if (card->erased_byte == 0 && !mmc_can_discard(card))
>>>               q->limits.discard_zeroes_data = 1;
>>>       q->limits.discard_granularity = card->pref_erase << 9;
>>>       /* granularity must not be greater than max. discard */
>>> +#if 0
>>>       if (card->pref_erase > max_discard)
>>>               q->limits.discard_granularity = 0;
>>> +#endif
>>>       if (mmc_can_secure_erase_trim(card))
>>>               queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
>>>  }
>>>
>>> I end up with:
>>>
>>> $ cat /sys/.../block/mmcblk1/queue# cat discard_granularity
>>> 2097152
>>> $ cat /sys/.../block/mmcblk1/queue# cat discard_max_bytes
>>> 2199023255040
>>> $ cat /sys/.../block/mmcblk1/queue# cat discard_zeroes_data
>>> 1
>>>
>>> With those values, mke2fs is fast, and I validated that "blkdiscard"
>>> works; I filled a large partition with /dev/urandom, executed
>>> "blkdiscard" on the 4M at the start, and saw zeroes when reading the
>>> discarded part back.
>>>
>>> This implies that the issue is simply the operation of
>>> mmc_calc_max_discard(), rather than the eMMC device mis-reporting its
>>> discard abilities, doesn't it?
>>
>> No.
>>
>> The underlying problem is a combination of:
>>         a) JEDEC specified very large timeouts for erase operations e.g. can be
>> minutes for large erases
>>         b) SDHCI controllers have been implemented with high frequency timeout
>> clocks which limit the maximum timeout to a few seconds
>>         c) It is not possible to disable the timeout on SDHCI
>>
>> What a) means is that you can get away with much larger erases than you can
>> specify the timeout for - which is what you have discovered.
>>
>> To understand the timeouts, you should manually do the calculations.
>>
>> Also note, that using HC Erase Size may help (MMC_CAP2_HC_ERASE_SZ), but
>> beware of the partitioning implications of changing that.
>>
>> The best solution is to change the hardware to use the lowest possible
>> frequency timeout clock e.g. a 1KHz timeout clock could support timeouts of
>> up to 36 hours.
>
> Don't know the details about the limitations for SDHCI, but I guess
> similar exists for other controllers as well.
>
> I do get the impression that we have got a problem in the mmc
> core/block layer for how erase/trim/discard timeouts are being
> handled.
>
> I don't think the mmc hw-controller should be waiting for the R1B
> response from the CMD38 as long as this "timeout" we are discussing
> here. According to the spec, at least how I interpret it, the card
> should respond rather quickly to CMD38, then it will assert the DAT0
> line to indicate busy.
>

For IMX, CMD38 responds very quick since it does not wait for TC interrupt
when DAT0 de-assertion due to IP limitation.

> The total time the card is allowed to stay busy, that is what the
> timeout specifies. We may either use a mmc hw-controller busy
> detection mechanism or send CMD13 to poll for status. The latter is
> somewhat already being handled in mmc_do_erase(), but we are using
> "MMC_CORE_TIMEOUT_MS" instead of the correct timeout.
>

Maybe one better way may be using polling for status if erase timeout
is bigger than
host capability, else still prefer to use hw timeout mechanism instead
to save CPU.
However, then we have two issues:
1) not waiting for R1B seems a bit violation with standard spec.
Also it increase complexity on handling the R1B of the same command
for two different
cases: using hw timeout or polling status for CMD38.

2) In current implementation, the data size to erase will not exceed
the max_discard_bytes
which is calculated based on max_discard_to of host.
Then how do we specify max_discard_to if want to use polling? UNIT_MAX?
Will it be too long to affect other activities in the same system?

Regards
Dong Aisheng

> Kind regards
> Ulf Hansson
>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
