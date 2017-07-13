From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [EXT] Re: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Thu, 13 Jul 2017 13:03:09 +0200
Message-ID: <CAPDyKFq3XFNsdOByWjqEUQj=uYm5J0WqLYh4RdQJpt2SKGmqDw@mail.gmail.com>
References: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
 <CAPDyKFpOcDOi8+nPsw0dk_rhcvzP94C9Mmp+RX=hfLvNqEs6sg@mail.gmail.com>
 <20170713172559.6dd2d65a@xhacker> <CAPDyKFrDq6sMH9ciHnW0sEu+hCrS1j978XjZtMe=EAssO5xihA@mail.gmail.com>
 <20170713181323.14dd0615@xhacker> <CAPDyKFrkLR64tZVVTjQpXx0rwHwVtMJS6w7PBh0i--+mSyB=uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34241 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdGMLDL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2017 07:03:11 -0400
Received: by mail-qk0-f171.google.com with SMTP id d78so47044560qkb.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2017 04:03:10 -0700 (PDT)
In-Reply-To: <CAPDyKFrkLR64tZVVTjQpXx0rwHwVtMJS6w7PBh0i--+mSyB=uA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Zhoujie Wu <zjwu@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>

On 13 July 2017 at 12:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 13 July 2017 at 12:13, Jisheng Zhang <jszhang@marvell.com> wrote:
>> On Thu, 13 Jul 2017 11:52:54 +0200 Ulf Hansson wrote:
>>
>>> On 13 July 2017 at 11:25, Jisheng Zhang <jszhang@marvell.com> wrote:
>>> > Hi Ulf,
>>> >
>>> > On Thu, 13 Jul 2017 11:18:32 +0200 Ulf Hansson wrote:
>>> >
>>> >> On 13 July 2017 at 00:16, Zhoujie Wu <zjwu@marvell.com> wrote:
>>> >> > From: Hu Ziji <huziji@marvell.com>
>>> >> >
>>> >> > Add Xenon specific system-level suspend and resume support.
>>> >> > Especially during resume, re-configure Xenon specific registers
>>> >> > since registers setting will be lost in suspend if Xenon is power off.
>>> >>
>>> >> I recommend to start with deploying runtime PM support instead of
>>> >> system PM support. Then on top of such change, you should make use of
>>> >> the runtime PM centric path to get system sleep support for "free"
>>> >> (and thus all the nice benefits).
>>> >
>>> > I'm not sure whether runtime PM is useful for xenon case. The xenon HW
>>> > support ACG(Auto Clock Gating) and SDCLK-Off-While-Idle features, that's
>>> > to say we even don't need to do anything but achieve the runtime PM gains.
>>>
>>> Yeah, but that's only internally managed by mmc controller. The clock
>>> will not be unprepared/disabled, from clock tree point of view. Isn't
>>> that also worth doing?
>>>
>>
>> The HW is clock gated, the difference is clock itself. From power saving
>> point of view, the gain is nearly zero. From latency point of view, could
>
> I assume the clock you are talking about is the "core" clock? I then
> assumes that clock is used as the interface clock for the card?
>
> That makes me wonder, don't you have other device clocks to manage as
> well? Clocks that is provided to the controller to make it functional?

Besides the clocks, you have the xenon mmc phy. Can't that also be put
that in some low power mode at request in-activity?

[...]

Kind regards
Uffe
