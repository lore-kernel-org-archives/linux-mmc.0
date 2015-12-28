From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: Optimize boot time by detecting cards
 simultaneously
Date: Mon, 28 Dec 2015 17:44:48 +0800
Message-ID: <56810490.5020507@rock-chips.com>
References: <1448982916-21485-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
 <5670A0BA.8090402@samsung.com>
 <CAPDyKFpF+rqv1WQ0Hu-YdAM1pdNwKyKjFsAg1BfeEj=kDfH0Ag@mail.gmail.com>
 <CAOGqxeWw-qcRNV=4GDbh6znvd6Wh4yOtFcZtua3QuX8ZExGCBw@mail.gmail.com>
 <CAPDyKFo6DFOynRpB2mJE5KhAm7SQKd8xK6Ki54Rf5OjGLwwQcA@mail.gmail.com>
 <5673612C.9050808@samsung.com> <567377F3.2060906@rock-chips.com>
 <CAPDyKFqKkGpT0uiGP5BkZt-Z=Lphiu2Xeiv0Lsosti_XH-SKNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:37387 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbL1JpR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 04:45:17 -0500
In-Reply-To: <CAPDyKFqKkGpT0uiGP5BkZt-Z=Lphiu2Xeiv0Lsosti_XH-SKNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Alan Cooper <alcooperx@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 2015/12/28 17:31, Ulf Hansson wrote:
> On 18 December 2015 at 04:05, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> On 2015/12/18 9:28, Jaehoon Chung wrote:
>>>
>>> Hi,
>>>
>>> On 12/18/2015 06:49 AM, Ulf Hansson wrote:
>>>>
>>>> On 17 December 2015 at 20:47, Alan Cooper <alcooperx@gmail.com> wrote:
>>>>>
>>>>> On Wed, Dec 16, 2015 at 4:07 AM, Ulf Hansson <ulf.hansson@linaro.org>
>>>>> wrote:
>>>>>>
>>>>>> To find the improved card detection times, I just used the kernel boot
>>>>>> log and checked the time stamps for when the cards get detected. I ran
>>>>>> the tests ~10 times and picked up some average values.
>>>>>>
>>>>>> To notice the improvement you need at least two cards to be inserted
>>>>>> during boot. Perhaps you have a platform with one eMMC and one SD card
>>>>>> slot, you can test.
>>>>>
>>>>>
>>>>> I tested the patch on one of our ARM bases SoC's. The SoC has an SD
>>>>> card slot on the first controller and an eMMC device on the second
>>>>> controller. I found ~100ms improvement on the time it took for the
>>>>> rootfs on the eMMC device to be ready for use. Interestingly, I did
>>>>> see the SD/eMMC order swap once in 20 tries. This is not an issue for
>>>>> us as we already have to use UUID for the eMMC rootfs in case an SD
>>>>> card is installed.
>>>>>
>>
>
> Hi Shawn,
>
> Thanks for helping out testing.
>
>> hi Ulf,
>>      I'm interested in this patch since I also spent a little time optimzing
>> the boot time and sequence for my local branch based on kernel 3.1x. With
>> you patch, it seems, the tablet only achieves very small improvement for the
>> SD controller(less than 20ms).
>>
>> My test environment:
>> Kernel: 3.14
>> Slot: 1 emmc(1st) + 1 SD card(2nd) + 1 sdio card(3rd)
>
> How much time you *gain* comparing to the original behaviour for each
> card, depends on the ->probe() order of your mmc hosts.
>
> I would guess that the host that holds the eMMC is the one being
> probed first, right?
> In general eMMC is quite fast to initialize, comparing to SD-cards and
> that's probably the reason to why you don't see that much
> improvements.
>

yes, my emmc is the first order to be probed. And sdio gain nearly 80ms 
with your patch.

No any problems found yet. So I think this patch is good :)

> Although, for your SDIO card you should see a greater improvement as
> this don't need to wait for your SD and eMMC to be initialized.
>
>>
>> I happen to run massive reboot test for my stable kernel branch this
>> weekend, so I will apply this patch to see if any problem occurs. :)
>>
>
> Great!
>
> As you haven't reported any problems, I suppose the tests went well!?
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Best Regards
Shawn Lin

