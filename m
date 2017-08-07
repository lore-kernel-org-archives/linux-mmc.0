From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [EXT] Re: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Mon, 7 Aug 2017 11:18:21 +0200
Message-ID: <CAPDyKFr5GOoW63+JHyYga9XBs_ANSSkr+KY_cjewW4DKv9ggqQ@mail.gmail.com>
References: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
 <CAPDyKFpOcDOi8+nPsw0dk_rhcvzP94C9Mmp+RX=hfLvNqEs6sg@mail.gmail.com>
 <20170713172559.6dd2d65a@xhacker> <CAPDyKFrDq6sMH9ciHnW0sEu+hCrS1j978XjZtMe=EAssO5xihA@mail.gmail.com>
 <20170713181323.14dd0615@xhacker> <CAPDyKFrkLR64tZVVTjQpXx0rwHwVtMJS6w7PBh0i--+mSyB=uA@mail.gmail.com>
 <CAPDyKFq3XFNsdOByWjqEUQj=uYm5J0WqLYh4RdQJpt2SKGmqDw@mail.gmail.com>
 <5967E9FB.80508@marvell.com> <CAPDyKFoAAUK+R3B2H38+sXC6FazdxnB2mdWOc0fqB-hYROnu6g@mail.gmail.com>
 <CAG18LKhrm8jvB6G5+_YQS4sYmnAo+HHwhMGVb2N2Wq6uqemzaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33457 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbdHGJSX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 05:18:23 -0400
Received: by mail-qk0-f178.google.com with SMTP id a77so36359751qkb.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 02:18:22 -0700 (PDT)
In-Reply-To: <CAG18LKhrm8jvB6G5+_YQS4sYmnAo+HHwhMGVb2N2Wq6uqemzaQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <davidhuzj@gmail.com>
Cc: Zhoujie Wu <zjwu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>

[...]

>>> But considering about the benefits, it is not that urgent to take runtime pm
>>> feature as a must, it is a better to have feature. System standby is a must
>>> feature, without this patch, the system can't work well after resume.
>>> Do you think it is reasonable to add complete standby support at first, then
>>> take runtime pm as a next step?
>>
>> You can do that, but why? And will then the "next step" ever happen?
>>
>> Do you really want to spend efforts in getting something working for
>> system suspend only, while you instead easily could deploy both
>> runtime PM and system PM support at the same time?
>>
>
> As the author of this patch, I'd like to argue for myself here, although it is
> not my task any more. :p
> The reason of implementing system PM firstly, is definitely NOT that
> runtime PM is
> unnecessary. Instead, I was just not able to.
>
> Internal customers in Marvell and external customers previously just required
> simple system PM. Thus I decided to meet customers requirement at first.
> Otherwise, I didn't have any platform to verify runtime PM even if runtime PM
> is completed.
>
> Those SoCs implementation vary a lot. Thus I was actually not sure
> what a generic Xenon runtime PM should look like for all those Marvell products.
> I previously planed to implement runtime PM when I got enough resources
> (boards/BSP/supports) from customers.

If saving power during system sleep makes sense, then it seems odd
that one don't want to care about saving power in runtime as well.

Anyway, I rest my case and I won't prevent you from adding only system
sleep support.

>
>>>
>>>> Besides the clocks, you have the xenon mmc phy. Can't that also be put
>>>> that in some low power mode at request in-activity?
>>>
>>> For the phy behavior, currently I don't see any SW operation for the lpm, I
>>> will check with HW guys about the behaviour.
>>
>> Great, that would really be interesting from a runtime PM point of view.
>>
>> Perhaps then also ask if re-configuring the phy via xenon_phy_adj(),
>> makes sense when powering off the card? Because currently you seems to
>> keep the latest configuration, even if the mmc core decides to power
>> off the card during system sleep. Unless I am reading the code wrong
>> from the ->set_ios() ops.
>>
>
>     As I know, PHY HW will also automatically enter standby mode
> (power saving mode)
> when ACG/SDCLK-off-while-idle are triggered. Actually there is no SW interface
> to "enable" or "disable" PHY. It requires confirm from HW bros.
>
>     xenon_phy_adj() will set PHY based on current timing. For example,
> when coming back
> from resume, xenon_phy_adj() will re-configure PHY for legacy timing.
>     Thus it is unnecessary to clean PHY setting before sleep.

Okay, thanks for clarifying.

Kind regards
Uffe
