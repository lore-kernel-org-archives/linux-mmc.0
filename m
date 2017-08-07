From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [EXT] Re: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Mon, 7 Aug 2017 11:23:56 +0200
Message-ID: <CAPDyKFpwYQ5rAMAa8BQwURDh3hXCQfyXmFxrQGa7WfXdVY3FBw@mail.gmail.com>
References: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
 <CAPDyKFpOcDOi8+nPsw0dk_rhcvzP94C9Mmp+RX=hfLvNqEs6sg@mail.gmail.com>
 <20170713172559.6dd2d65a@xhacker> <CAPDyKFrDq6sMH9ciHnW0sEu+hCrS1j978XjZtMe=EAssO5xihA@mail.gmail.com>
 <20170713181323.14dd0615@xhacker> <CAPDyKFrkLR64tZVVTjQpXx0rwHwVtMJS6w7PBh0i--+mSyB=uA@mail.gmail.com>
 <CAPDyKFq3XFNsdOByWjqEUQj=uYm5J0WqLYh4RdQJpt2SKGmqDw@mail.gmail.com>
 <5967E9FB.80508@marvell.com> <CAPDyKFoAAUK+R3B2H38+sXC6FazdxnB2mdWOc0fqB-hYROnu6g@mail.gmail.com>
 <59691191.8080209@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35991 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbdHGJX5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 05:23:57 -0400
Received: by mail-qk0-f170.google.com with SMTP id d136so36521641qkg.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 02:23:57 -0700 (PDT)
In-Reply-To: <59691191.8080209@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>
Cc: Jisheng Zhang <jszhang@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>

[...]

>>
>> I am not sure I get the second part here. The clock to shd is enabled
>> via a call to clk_prepare_enable(). Unless you explicitly call
>> clk_disable_unprepare() for it, no? How can any outer logic know when
>> it can be gated?
>
>
> This is my understanding. Hope it can make you clear.
> The clock tree is like below.
> SOC --> [ SDH_CLK_GEN --> SDH_CONTROLLER ] --> SD/EMMC CARD
>
> There is one clock generator inside sdh slot IP, SOC provides the clock to
> the sdh slot IP. This clock is enabled/disabled by SW when calling
> clk_prepare_enable/clk_disable_unprepare.
> The auto clock gating is not any outer logic, it is inside sdh slot IP, when
> sdh controller has no activity, the IP will gate the clock from sdh_clk_gen
> to sdh_controller.  sdh_clk_gen logic itself still has clock from SOC.
> With or without runtime pm, the only difference is if sdh_clk_gen has clock
> or not. So the power benefit is limited.

Thanks for clarifying!

>
>>
>>> With SW runtime pm mechanism, compares with HW auto clock gating, the
>>> only
>>> difference is SW cut the source of sdh clock tree, external clock gating
>>> vs
>>> internal clock gating, there will be some benefits, but limited.
>>
>> Right.
>>
>>> Previously we enabled the runtime pm mechanism in our mobile products,
>>> which
>>> were using the same IP(some old version, including 3 sdh slots) with auto
>>> clock gating feature(the driver is sdhci-pxav3.c).  The saving of power
>>> was
>>> about 2~3mA@vcc_main_1.05V(28nm chip) with 3 sdh slots inside soc. No
>>> more
>>> than 1mA/1sdh slot.
>>
>> 1 mA/sdh slot is a great reason to deploy runtime PM support. For a
>> battery driven device that would be a significant improvement.
>>
>> Back in the days when I worked at ST-Ericssion, we were chasing uA
>> when optimizing for power-save. :-)
>
>
> Definitely for mobile products, but now I didn't see urgent requirement for
> our networking products.

I see.

I think what puzzles me is that you do care about saving power in
system sleep, but not during runtime.

>>
>>
>>> I read sdhci-of-at91 driver and your recommended patch, I got your point
>>> is
>>> using a light way for system sleep based on runtime pm feature. From SW
>>> perspective, kill two birds with one stone, it is good.
>>
>> Right.
>>
>>> But considering about the benefits, it is not that urgent to take runtime
>>> pm
>>> feature as a must, it is a better to have feature. System standby is a
>>> must
>>> feature, without this patch, the system can't work well after resume.
>>> Do you think it is reasonable to add complete standby support at first,
>>> then
>>> take runtime pm as a next step?
>>
>> You can do that, but why? And will then the "next step" ever happen?
>>
>> Do you really want to spend efforts in getting something working for
>> system suspend only, while you instead easily could deploy both
>> runtime PM and system PM support at the same time?
>
>
> As Ziji said in another mail, it takes time for next step. The runtime pm
> need to be verified completely on all supported boards.
> I understand from SW perspective, we'd better have both. But I need input
> from internal customers to see if they only request system sleep or they
> want both, and what's their priority.

Okay. As I just responded in the other email, I rest my case. :-)

[...]

However, I need an ack from Adrian before I can apply this.

Kind regards
Uffe
