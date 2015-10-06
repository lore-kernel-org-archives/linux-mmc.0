From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
Date: Tue, 6 Oct 2015 16:45:23 +0200
Message-ID: <20151006144523.GA32615@lunn.ch>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
 <20151006033131.GA24230@lunn.ch>
 <CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:36596 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbbJFOp0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Oct 2015 10:45:26 -0400
Content-Disposition: inline
In-Reply-To: <CAPv3WKeUQ6rsYWJ3C+aX8eHTAdS4SmQ3oCjA9feFf+d-n1RvhA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory =?iso-8859-1?Q?Cl=E9ment?= <gregory.clement@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>

On Tue, Oct 06, 2015 at 09:02:25AM +0200, Marcin Wojtas wrote:
> Hi Andrew,
> 
> 2015-10-06 5:31 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> > On Tue, Oct 06, 2015 at 03:22:40AM +0200, Marcin Wojtas wrote:
> >> The newest revisions of A388-GP (v1.5 and higher) support only
> >> DAT3-based card detection, which is enabled by this commit. Hitherto
> >> revisions, without such modification, will be impacted with a broken
> >> card detection - in order to operate the cards have to be present
> >> during kernel boot.
> >
> > Humm. Is this acceptable, breaking old boards?
> >
> > I would say at minimum, there should be a big fat comment at the top
> > of armada-388-gp.dts explaining that this DTS file is broken on
> > v0.0-v1.4.
> >
> > Or we have two .dts files for the 388-gp file, and a dtsi file.
> >
> 
> I expected this patch would be controversial, hence I propose a
> compromise: set A388-GP SDHCI to 'broken-cd' by defeault.

So for boards < 1.5, you are introducing a regression. It used to work
via GPIO. Now that is ignored and it is declared broken. Or am i
mis-understanding what broken-cd means, and it actually means, poll
it?

> However Marvell insisted on HW card detection

Marvell does not get to decide what goes into the kernel and what can
be deliberately broken. Marvell can make recommendations, provide
benchmarks reports, etc. But the community, and ultimately the
responsible maintainer decides.

> because software polling spoils the SD/MMC benchmarks, but this way
> the user would decide whether to stay with broken-cd or switch to
> GPIO/DAT3 detection. What do you think?

So rather than presenting a solution, please could you list all the
different options you can think of, and how they would work for < 1.5
and >= 1.5.

One other useful bit of information. How many < 1.5 boards are there,
and who has them. Are they internal to Marvell and Free Electrons, or
do a lot of people have them? We have thrown away fixes which are
requires for A0 stepping SoCs, because very few people have such
devices and they can easily replace them for B1. If nearly nobody
actually has < 1.5, ....

Thanks
	 Andrew
