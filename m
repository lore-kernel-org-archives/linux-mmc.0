From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Sat, 28 May 2011 21:04:12 +0200
Message-ID: <201105282104.12552.arnd@arndb.de>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com> <201105281052.39803.arnd@arndb.de> <A68B8B3A-AED9-407D-ABD7-0A0FA63F30B8@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59829 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1E1TEo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 May 2011 15:04:44 -0400
In-Reply-To: <A68B8B3A-AED9-407D-ABD7-0A0FA63F30B8@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Saturday 28 May 2011 18:25:00 Philip Rakity wrote:
> On May 28, 2011, at 1:52 AM, Arnd Bergmann wrote:
> > I would actually prefer in general if the Kconfig file listed only
> > the strictly necessary dependencies for building the driver.
> > If this driver can be built anywhere, I would list no dependency at
> > all. If it depends on something ARM specific, I'd make it depend
> > on CONFIG_ARM.
> > 
> > Then change the defconfig for the particular board to enable the
> > driver.
> > 
> > The main advantage of this is to increase build coverage on test
> > building machines doing an allyesconfig and randconfig once we
> > get there (right now, these have too many build errors, but we
> > have plans to work on that). 
> 
> The controller is built into the mmp2 SoC.  No build error could
> occur if once the SoC is determined it selected the type of
> controller available (in the arch/arm).  Like the patch you
> helped me with a while ago (which never was accepted).

My point was not avoiding build errors in this driver, which is
fairly easy and obviously needs to happen. I want to enable the
driver (and most others) to be built in all cases that don't
cause a build error, instead of limiting them to very few
configurations.

> The Kconfig entry for MMP2 in drivers/mmc/host would
> add the line 
> depends on 
> 
> This is not a general as depending on ARM but at least
> the code would work.
> 
> The best solution would be far more general and involve
> generic probing and registration but that is a lot of work and
> should be done for all of the arm/ directory. 

We actually do all the generic probing based on the machine
type already. Any place where we don't do that and hardcode
the presence of a device based on a compile-time option should
be considered a bug.

> > I guess the idea was to be able to free the structure later. I already
> > commented that it should be statically allocation instead of kzalloc,
> > so that would make the pointer unnecessary.
> 
> I do not understand why pxa->ops is needed at all.  More general 
> question.

pxa->ops is the same as host->ops, which is required by the base
sdhci driver.

	Arnd
