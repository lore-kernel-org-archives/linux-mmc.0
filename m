From: Ravikumar <a0131654@ti.com>
Subject: Re: Enabling MMC BKOPs in kernel based on host caps
Date: Wed, 5 Oct 2016 17:25:29 +0530
Message-ID: <dfcdad0d-0780-0641-cb0a-46557334fa16@ti.com>
References: <1475491384-15818-1-git-send-email-rk@ti.com>
 <74289549-5576-c4fc-5270-8820c8654bc5@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40330 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbcJELyq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 07:54:46 -0400
In-Reply-To: <74289549-5576-c4fc-5270-8820c8654bc5@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>

Hi Shawn,


On Wednesday 05 October 2016 03:07 PM, Shawn Lin wrote:
> Hi Ravikumar,
>
> + Alex,
>
> 在 2016/10/3 18:43, Ravikumar Kattekola 写道:
>> Hi all,
>>     I’ve seen an eMMC failure due to pending background operations on 
>> a certain OMAP device since bkops enable bit was not set.
>> Further investigation showed me that someone already posted patch to 
>> enable Background operations in kernel  based on a host capability 
>> check (Caps2 & BK_OPS_EN)
>> but was turned down quoting that it should be enabled from user space 
>> using mmc-utils.
>>
>> Enabling this would add one additional check for exception event in 
>> the response R1 or R1B (only on hosts that explicitly set BK_OPS_EN 
>> in caps2).
>> But not enabling this could lead to a system failure especially when 
>> the Filesystem is on eMMC and the card stops responding due to 
>> pending critical bkops.
>>
>> I would like to ask for expert opinion on ‘why is it a bad idea to 
>> enable bkops in kernel?’
>
> Some discussion about the similar topic could be found here:
> https://patchwork.kernel.org/patch/9157121/
>
>
>> It’s a one time programmable bit but if it helps in keeping system 
>> functional why not do it?
>
> Actually BKOPS_EN is not OTP bit.. Quoted from Ulf "I don't have any
> issue to allow all non-OTP registers bits to be written." So I guess
> you could do this, although it needs more discussion there.
In the spec for 4.5, jesd84_B45 it does say not whether the ENABLE bit 
is OTP.
But in 5.1 spec, jesd84-b51, it says MANUAL_EN is R/W which means OTP 
and readable.
As I read form mmc-utils -help
"        mmc bkops enable <device>
                 Enable the eMMC BKOPS feature on <device>.
                 NOTE!  This is a one-time programmable (unreversible) 
change "
>
> But it's persistent EXT_CSD register and we get used to control it from
> userspace, which is the policy we have been sticking to when writing to
> persistent EXT_CSD registers. I guess that is nothing about "right and
> wrong", just a rule for us in case someone wants to set the persistent
> bit in kernel but setting other persistent bits from user-space, which
> is prone to mess up the mmc core. Or, someone will sent mail to the list
> asking "why is it a good idea to enable bkops in kernel" ? :)
So there's no functional problem/reason that stops us from enabling 
BKOPS (Manual) in
kernel except for consistency with other persistent registers.
Since not enabling BKOPS could lead to a functional failure / 
non-responsive system
at a later point of time I guess this could be exempted.
what do you think?

As user I would choose functional safety and reliability over performance.
Hence it would make sense to have the bkops (at least manual) be enabled 
by default,
especially in Automotive applications.

>
>> I haven’t measured the performance impact but I don’t see a reason 
>> for major drop because the frequency of critical bkops events would 
>> be less.
>>
>> Regards,
>> RK
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
>
Thanks for your response.

Regards,
RK

