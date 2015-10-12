From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v2 2/5] mmc: sdhci-pxav3: enable usage of DAT3 pin as HW
 card detect
Date: Mon, 12 Oct 2015 10:52:12 +0800
Message-ID: <20151012105212.504a4ab1@xhacker>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
	<1444352635-21965-3-git-send-email-mw@semihalf.com>
	<20151009201356.78488116@xhacker>
	<CAPv3WKddfCOSCCOSByAEzyZ3qnAX22TFi2acrNDcTgEvy+ioFA@mail.gmail.com>
	<20151010150535.6047dab9@xhacker>
	<CAPv3WKcPAieXFBWD9m2LLZLaiUprh83ySB9LCG2DyAq5p-RT=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8962 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752826AbbJLC4Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2015 22:56:16 -0400
In-Reply-To: <CAPv3WKcPAieXFBWD9m2LLZLaiUprh83ySB9LCG2DyAq5p-RT=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Marcin,

On Sat, 10 Oct 2015 14:13:51 +0200
Marcin Wojtas <mw@semihalf.com> wrote:

> Hi Jisheng,
> 
> 
> >>
> >> >>
> >> >> When using DAT3-based detection Armada 38x SDIO IP expects its internal
> >> >> clock to be always on, which had to be ensured twofold:
> >> >
> >> > What happen if runtime suspend disables its core clk and axi clk? I guess
> >> > dat3-based detection isn't compatible with runtime pm. If so, do we also
> >> > need to disable runtime pm in probe function?
> >>
> >> Is runtime resume supposed to be triggered by card detection? Is there
> >
> > I think so. Take marvell berlin for example, card insert => gpio interrupt
> > or => sdhci runtime resume.
> >
> >> a way to manually trigger runtime suspend and resume of sdhci? Anyway
> >
> > If runtime-pm is builtin and the host driver supports runtime-pm (sdhci-pxav3
> > supports runtime-pm well), when there's no sdhc transactions, runtime suspend
> > will be triggered automatically after some time (50ms?)
> >
> >> coreclk is not a problem, as it's not used by A38x.
> >
> > I checked A38x dts files, it's <&gateclk 17>. So the question is: what will
> > happen if <&gateclk 17> is disabled in runtime suspend? Is the dat3-based
> > CD still works? In theory, it should not work any more.
> >
> 
> Actually in pxav3 driver there is one obligatory clock ("io") which
> can be either named in dts on not (like in armada38x.dtsi). "coreclk"
> is optional, however all this does not matter, as both are disabled in

Hmm, grep the dts, I think commit 8afdc9cca27f ("mmc: sdhci-pxav3: Get optional
core clock") mainly targets for Marvell Berlin SoCs, but the two clks for sdhci
in Berlin SoCs are coreclk and axiclk, rather than ioclk and coreclk, during
which the axiclk is optional. Will cook one patch to fix this.

> runtime_suspend function. I think that when we disable the gate clock,
> dat3 detection won't work, but I guess that card detection is not the
> only thing that wakes up the mmc subsystem and make runtime_pm useful.

Card insert is not the only thing can wake up mmc, mmc initiate sdhc
transactions will also wake up mmc.

Thanks,
Jisheng

> 
> I will try to check how it works. If there's problem with detection I
> propose, in order not to spoil the code too much and not to loose all
> runtime_pm benefits, to avoid disabling/enabling clock in
> runtime_suspend/resume functions on a38x working with dat3 detection.
> In such case sdhci_runtime_suspend/resume would execute without
> problems and we will be sure that detection will work in such
> configuration.
> 
> Best regards,
> Marcin

