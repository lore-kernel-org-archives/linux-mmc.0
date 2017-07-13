From: Zhoujie Wu <zjwu@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Thu, 13 Jul 2017 14:45:31 -0700
Message-ID: <5967E9FB.80508@marvell.com>
References: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
 <CAPDyKFpOcDOi8+nPsw0dk_rhcvzP94C9Mmp+RX=hfLvNqEs6sg@mail.gmail.com>
 <20170713172559.6dd2d65a@xhacker>
 <CAPDyKFrDq6sMH9ciHnW0sEu+hCrS1j978XjZtMe=EAssO5xihA@mail.gmail.com>
 <20170713181323.14dd0615@xhacker>
 <CAPDyKFrkLR64tZVVTjQpXx0rwHwVtMJS6w7PBh0i--+mSyB=uA@mail.gmail.com>
 <CAPDyKFq3XFNsdOByWjqEUQj=uYm5J0WqLYh4RdQJpt2SKGmqDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52270 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752602AbdGMVpj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2017 17:45:39 -0400
In-Reply-To: <CAPDyKFq3XFNsdOByWjqEUQj=uYm5J0WqLYh4RdQJpt2SKGmqDw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jisheng Zhang <jszhang@marvell.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>



On 07/13/2017 04:03 AM, Ulf Hansson wrote:
> On 13 July 2017 at 12:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 13 July 2017 at 12:13, Jisheng Zhang <jszhang@marvell.com> wrote:
>>> On Thu, 13 Jul 2017 11:52:54 +0200 Ulf Hansson wrote:
>>>
>>>> On 13 July 2017 at 11:25, Jisheng Zhang <jszhang@marvell.com> wrote:
>>>>> Hi Ulf,
>>>>>
>>>>> On Thu, 13 Jul 2017 11:18:32 +0200 Ulf Hansson wrote:
>>>>>
>>>>>> On 13 July 2017 at 00:16, Zhoujie Wu <zjwu@marvell.com> wrote:
>>>>>>> From: Hu Ziji <huziji@marvell.com>
>>>>>>>
>>>>>>> Add Xenon specific system-level suspend and resume support.
>>>>>>> Especially during resume, re-configure Xenon specific registers
>>>>>>> since registers setting will be lost in suspend if Xenon is power off.
>>>>>> I recommend to start with deploying runtime PM support instead of
>>>>>> system PM support. Then on top of such change, you should make use of
>>>>>> the runtime PM centric path to get system sleep support for "free"
>>>>>> (and thus all the nice benefits).
>>>>> I'm not sure whether runtime PM is useful for xenon case. The xenon HW
>>>>> support ACG(Auto Clock Gating) and SDCLK-Off-While-Idle features, that's
>>>>> to say we even don't need to do anything but achieve the runtime PM gains.
>>>> Yeah, but that's only internally managed by mmc controller. The clock
>>>> will not be unprepared/disabled, from clock tree point of view. Isn't
>>>> that also worth doing?
>>>>
>>> The HW is clock gated, the difference is clock itself. From power saving
>>> point of view, the gain is nearly zero. From latency point of view, could
>> I assume the clock you are talking about is the "core" clock? I then
>> assumes that clock is used as the interface clock for the card?
>>
>> That makes me wonder, don't you have other device clocks to manage as
>> well? Clocks that is provided to the controller to make it functional?
At first, really appreciate your quick and valuable feedback.
The core clock in this driver is the clock provided by SOC to sdh 
controller, and there is a divider inside the controller to generate 
sdclk which provides to sd/emmc card.
Actually there are two runtime power saving features inside the 
controller per my understanding.
sdclk_idle_enable will cut the clock to sd/emmc card if sd bus idle for 
some time. auto_clkgate_enable means HW will auto gate the clock to sdh 
controller core logic.
With SW runtime pm mechanism, compares with HW auto clock gating, the 
only difference is SW cut the source of sdh clock tree, external clock 
gating vs internal clock gating, there will be some benefits, but limited.
Previously we enabled the runtime pm mechanism in our mobile products, 
which were using the same IP(some old version, including 3 sdh slots) 
with auto clock gating feature(the driver is sdhci-pxav3.c).  The saving 
of power was about 2~3mA@vcc_main_1.05V(28nm chip) with 3 sdh slots 
inside soc. No more than 1mA/1sdh slot.
I read sdhci-of-at91 driver and your recommended patch, I got your point 
is using a light way for system sleep based on runtime pm feature. From 
SW perspective, kill two birds with one stone, it is good.
But considering about the benefits, it is not that urgent to take 
runtime pm feature as a must, it is a better to have feature. System 
standby is a must feature, without this patch, the system can't work 
well after resume.
Do you think it is reasonable to add complete standby support at first, 
then take runtime pm as a next step?

> Besides the clocks, you have the xenon mmc phy. Can't that also be put
> that in some low power mode at request in-activity?
For the phy behavior, currently I don't see any SW operation for the 
lpm, I will check with HW guys about the behaviour.
>
> [...]
>
> Kind regards
> Uffe

