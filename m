From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3] mmc: sdhci-xenon: Add Xenon SDHCI specific
 system-level PM support
Date: Thu, 13 Jul 2017 18:13:23 +0800
Message-ID: <20170713181323.14dd0615@xhacker>
References: <1499897779-12338-1-git-send-email-zjwu@marvell.com>
        <CAPDyKFpOcDOi8+nPsw0dk_rhcvzP94C9Mmp+RX=hfLvNqEs6sg@mail.gmail.com>
        <20170713172559.6dd2d65a@xhacker>
        <CAPDyKFrDq6sMH9ciHnW0sEu+hCrS1j978XjZtMe=EAssO5xihA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41723 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751193AbdGMKSO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2017 06:18:14 -0400
In-Reply-To: <CAPDyKFrDq6sMH9ciHnW0sEu+hCrS1j978XjZtMe=EAssO5xihA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Zhoujie Wu <zjwu@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jimmy Xu <zmxu@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Wilson Ding <dingwei@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, hongd@marvell.com, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Thu, 13 Jul 2017 11:52:54 +0200 Ulf Hansson wrote:

> On 13 July 2017 at 11:25, Jisheng Zhang <jszhang@marvell.com> wrote:
> > Hi Ulf,
> >
> > On Thu, 13 Jul 2017 11:18:32 +0200 Ulf Hansson wrote:
> >  
> >> On 13 July 2017 at 00:16, Zhoujie Wu <zjwu@marvell.com> wrote:  
> >> > From: Hu Ziji <huziji@marvell.com>
> >> >
> >> > Add Xenon specific system-level suspend and resume support.
> >> > Especially during resume, re-configure Xenon specific registers
> >> > since registers setting will be lost in suspend if Xenon is power off.  
> >>
> >> I recommend to start with deploying runtime PM support instead of
> >> system PM support. Then on top of such change, you should make use of
> >> the runtime PM centric path to get system sleep support for "free"
> >> (and thus all the nice benefits).  
> >
> > I'm not sure whether runtime PM is useful for xenon case. The xenon HW
> > support ACG(Auto Clock Gating) and SDCLK-Off-While-Idle features, that's
> > to say we even don't need to do anything but achieve the runtime PM gains.  
> 
> Yeah, but that's only internally managed by mmc controller. The clock
> will not be unprepared/disabled, from clock tree point of view. Isn't
> that also worth doing?
> 

The HW is clock gated, the difference is clock itself. From power saving
point of view, the gain is nearly zero. From latency point of view, could
runtime PM introduce extra latency? I.E the time spent on
sdhci_runtime_suspend_host and sdhci_runtime_resume_host.

Thanks,
Jisheng
