From: Ravikumar <a0131654@ti.com>
Subject: Re: Enabling MMC BKOPs in kernel based on host caps
Date: Fri, 7 Oct 2016 19:35:52 +0530
Message-ID: <29d94a8f-935e-b313-a562-dc15909b78d1@ti.com>
References: <1475491384-15818-1-git-send-email-rk@ti.com>
 <74289549-5576-c4fc-5270-8820c8654bc5@rock-chips.com>
 <dfcdad0d-0780-0641-cb0a-46557334fa16@ti.com>
 <4B194B80-8DE7-4296-914E-00FC1C0A4D66@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:47053 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755194AbcJGOFH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 7 Oct 2016 10:05:07 -0400
In-Reply-To: <4B194B80-8DE7-4296-914E-00FC1C0A4D66@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Alex,


On Thursday 06 October 2016 03:39 AM, Alex Lemberg wrote:
> Hi Ravikumar,
>
> The reason for enabling Auto/Manual BKOPS is understandable.
> Personally I don’t think that user space should play with a storage device
> BKOPS settings, it should be a matter of storage device and a driver decision.
> But as Shown mentioned, there is a discussion on this topic.
> Also, recently I have submitted a patch for letting device more time
> to complete its BKOPS on runtime Suspend:
> http://www.spinics.net/lists/linux-mmc/msg38952.html
>
> Thanks,
> Alex
Thanks for sharing this information.

I totally agree with you, it should be the driver who makes the decision.

I'm still wondering why there's a concern even after adding a platform 
level check.

Should the code to enable BKOPS be wrapped inside a CONFIG_ENABLE_BKOPS
in order to give the individual an option to change the default behavior?

Thanks and Regards,
RK
>
> On 10/5/16, 1:55 PM, "Ravikumar" <a0131654@ti.com> wrote:
>
>> Hi Shawn,
>>
>>
>> On Wednesday 05 October 2016 03:07 PM, Shawn Lin wrote:
>>> Hi Ravikumar,
>>>
>>> + Alex,
>>>
>>> 在 2016/10/3 18:43, Ravikumar Kattekola 写道:
>>>> Hi all,
>>>>      I’ve seen an eMMC failure due to pending background operations on
>>>> a certain OMAP device since bkops enable bit was not set.
>>>> Further investigation showed me that someone already posted patch to
>>>> enable Background operations in kernel  based on a host capability
>>>> check (Caps2 & BK_OPS_EN)
>>>> but was turned down quoting that it should be enabled from user space
>>>> using mmc-utils.
>>>>
>>>> Enabling this would add one additional check for exception event in
>>>> the response R1 or R1B (only on hosts that explicitly set BK_OPS_EN
>>>> in caps2).
>>>> But not enabling this could lead to a system failure especially when
>>>> the Filesystem is on eMMC and the card stops responding due to
>>>> pending critical bkops.
>>>>
>>>> I would like to ask for expert opinion on ‘why is it a bad idea to
>>>> enable bkops in kernel?’
>>> Some discussion about the similar topic could be found here:
>>> https://patchwork.kernel.org/patch/9157121/
>>>
>>>
>>>> It’s a one time programmable bit but if it helps in keeping system
>>>> functional why not do it?
>>> Actually BKOPS_EN is not OTP bit.. Quoted from Ulf "I don't have any
>>> issue to allow all non-OTP registers bits to be written." So I guess
>>> you could do this, although it needs more discussion there.
>> In the spec for 4.5, jesd84_B45 it does say not whether the ENABLE bit
>> is OTP.
>> But in 5.1 spec, jesd84-b51, it says MANUAL_EN is R/W which means OTP
>> and readable.
>> As I read form mmc-utils -help
>> "        mmc bkops enable <device>
>>                  Enable the eMMC BKOPS feature on <device>.
>>                  NOTE!  This is a one-time programmable (unreversible)
>> change "
>>> But it's persistent EXT_CSD register and we get used to control it from
>>> userspace, which is the policy we have been sticking to when writing to
>>> persistent EXT_CSD registers. I guess that is nothing about "right and
>>> wrong", just a rule for us in case someone wants to set the persistent
>>> bit in kernel but setting other persistent bits from user-space, which
>>> is prone to mess up the mmc core. Or, someone will sent mail to the list
>>> asking "why is it a good idea to enable bkops in kernel" ? :)
>> So there's no functional problem/reason that stops us from enabling
>> BKOPS (Manual) in
>> kernel except for consistency with other persistent registers.
>> Since not enabling BKOPS could lead to a functional failure /
>> non-responsive system
>> at a later point of time I guess this could be exempted.
>> what do you think?
>>
>> As user I would choose functional safety and reliability over performance.
>> Hence it would make sense to have the bkops (at least manual) be enabled
>> by default,
>> especially in Automotive applications.
>>
>>>> I haven’t measured the performance impact but I don’t see a reason
>>>> for major drop because the frequency of critical bkops events would
>>>> be less.
>>>>
>>>> Regards,
>>>> RK
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>> Thanks for your response.
>>
>> Regards,
>> RK
>>

