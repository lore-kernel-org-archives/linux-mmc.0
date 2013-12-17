From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: max_discard anomaly on certain Sandisk eMMC
Date: Tue, 17 Dec 2013 10:45:56 +0100
Message-ID: <52B01D54.8010204@mleia.com>
References: <52AB8DA2.9000001@wwwdotorg.org> <52AF8A30.9050700@wwwdotorg.org> <52B008AB.7060909@intel.com> <CAA+hA=RR2JirHR_1c=PR9qBjakD-Wdo+xMMRw5x2Run7yFQ6Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:46662 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839Ab3LQJqB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Dec 2013 04:46:01 -0500
In-Reply-To: <CAA+hA=RR2JirHR_1c=PR9qBjakD-Wdo+xMMRw5x2Run7yFQ6Ow@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 12/17/13 10:40, Dong Aisheng wrote:
> On Tue, Dec 17, 2013 at 4:17 PM, Adrian Hunter<adrian.hunter@intel.com>  wrote:
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
>>>                return;
>>>
>>>        queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>>> -     q->limits.max_discard_sectors = max_discard;
>>> +     q->limits.max_discard_sectors = UINT_MAX;
>>>        if (card->erased_byte == 0&&  !mmc_can_discard(card))
>>>                q->limits.discard_zeroes_data = 1;
>>>        q->limits.discard_granularity = card->pref_erase<<  9;
>>>        /* granularity must not be greater than max. discard */
>>> +#if 0
>>>        if (card->pref_erase>  max_discard)
>>>                q->limits.discard_granularity = 0;
>>> +#endif
>>>        if (mmc_can_secure_erase_trim(card))
>>>                queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
>>>   }
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
>>          a) JEDEC specified very large timeouts for erase operations e.g. can be
>> minutes for large erases
>>          b) SDHCI controllers have been implemented with high frequency timeout
>> clocks which limit the maximum timeout to a few seconds
>
> Right, especially for controllers using SDCLK as timeout clock.
> I'm a bit suspect the timeout supported by host whether is designed
> for erase operation
> since they have huge gap.
> For IMX, when running on 198Mhz for a SD3.0 cards, the max_discard_to is 1355ms.
> However, i have one Toshiba SDHC U1 card which ERASE_OFFSET is 2s.
> That means our host has no chance to support discard for such card.
>
> Now, i'm think for those host controller with limited timeout time, if we should
> use CMD13 to polling the status instead of using HW timeout machanism.
> And actuall the mmc core already has some base code to support it.
> The timeout is 10 seconds.

That's my point also. I presume JEDEC specifies maximum safe timeout for 
erase
operations, but since it is so huge (if properly calculated it may reach 
hours
for multiple erase groups) and erase operations are so fast, I don't think
we should care much of data line timeout on controller's side during
erase/trim/discard.

> See mmc_do_erase function and
> /* If the device is not responding */
> #define MMC_CORE_TIMEOUT_MS     (10 * 60 * 1000) /* 10 minute timeout */
>
> Regards
> Dong Aisheng
>
>>          c) It is not possible to disable the timeout on SDHCI
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
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
