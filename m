From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
 selecting hs400es
Date: Fri, 23 Sep 2016 07:34:13 +0800
Message-ID: <3559c25a-44ce-021d-de1c-d330bb02b704@rock-chips.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com>
 <1474422233-29355-4-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoHxSpFurgV9swN3MCTWUinPFNUHSzxgyKj+K3iqkGSbA@mail.gmail.com>
 <62a8d622-39d2-db7d-042d-5425a3efba58@rock-chips.com>
 <CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:55370 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbcIVXeY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2016 19:34:24 -0400
In-Reply-To: <CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

On 2016/9/22 18:21, Ulf Hansson wrote:
> On 22 September 2016 at 12:06, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Hi ulf,
>>
>> 在 2016/9/22 17:38, Ulf Hansson 写道:
>>>
>>> On 21 September 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>>>
>>>> Per JESD84-B51 P69, Host need to change frequency to <=52MHz after
>>>> setting HS_TIMING to 0x1, and host may changes frequency to <= 200MHz
>>>> after setting HS_TIMING to 0x3. It seems there is no difference if
>>>> we don't change frequency to <= 52MHz as f_init is already less than
>>>> 52MHz. But actually it does make difference. When doing compatibility
>>>> test we see failures for some eMMC devices without changing the
>>>> frequency to hs_max_dtr. And let's read the spec again, we could see
>>>> that "Host may changes frequency to 200MHz" implies that it's not
>>>> mandatory. But the "Host need to change frequency to <= 52MHz" implies
>>>> that we should do this.
>>>
>>>
>>> I don't get this. Are you saying that f_init > 52 MHz? That should not
>>> be impossible, right!?
>>
>>
>> nope, I was saying that the spec implies we to set clock after
>> setting HS_TIMING to 0x1 when doing hs400es selection.
>>
>> I thought there is no difference because the spec says "Host need to
>> change frequency to <= 52MHz", and the f_init(<=400k) is <= 52MHz,
>> right? So I didn't set clock to hs_max_dtr. But I think I misunderstood
>> the spec, so this patch will fix this.
>
> Okay, I see what you mean now!
>
> In other words:
> The card expects the clock rate to increase from the current used
> f_init (which is <= 400KHz), but still being <= 52MHz, when you have
> set HS_TIMING to 0x1.
>
> Okay, we can do that change! Could you try to improve the change log a
> little bit or you want me to help?

yep, I could change the commit msg a bit and fix another
copy-paste error, then respin v2.
BTW, I noticed you have applied one of these 5 patches, so
I will remove that one for V2.

Thanks, Ulf.

>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

