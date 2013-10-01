From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/2] mmc: core: Remove all code related to MMC_CLKGATE
Date: Tue, 1 Oct 2013 11:07:22 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1310011106270.27413@axis700.grange>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
 <Pine.LNX.4.64.1309302301400.24147@axis700.grange>
 <CAPDyKFq17j7cOjDQogTofKQOTHyUMbQxg7eRS7OARL-0U7phZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54208 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3JAJHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Oct 2013 05:07:46 -0400
In-Reply-To: <CAPDyKFq17j7cOjDQogTofKQOTHyUMbQxg7eRS7OARL-0U7phZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Ulf

On Tue, 1 Oct 2013, Ulf Hansson wrote:

> On 30 September 2013 23:10, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Hi Ulf
> >
> > On Mon, 30 Sep 2013, Ulf Hansson wrote:
> >
> >> This patchset is remove all code related to MMC_CLKGATE. A significant
> >> portion of code can then be removed from the core layer which would
> >> simplify maintainance.
> >>
> >> At the moment it seems like only some MIPS platforms were using
> >> MMC_CLKGATE, but at the same time the corresponding host drivers
> >> were not taking advantage of the mechanism. This made me feel confident
> >> in removing the feature entirely from the mmc subsystem could be done.
> >>
> >> Also do note that for host drivers that would like to implement clock
> >> gating as a power save operation, using runtime PM is a far easier
> >> way to address this. Several host drivers is already fully supporting
> >> this as well.
> >>
> >> Ulf Hansson (2):
> >>   MIPS: db1235: Don't use MMC_CLKGATE
> >>   mmc: core: Remove MMC_CLKGATE
> >
> > Do I understand correctly, that you're proposing to remove the aggressive
> > clock gating feature from MMC? If so, then please take into account my
> > NAK. At least two SD / MMC drivers, that I'm aware of, actively used and
> > developed on multiple platforms - sh_mmcif and tmio / sdhi implement MMC
> > clock gating and rely on it to save power between IO.
> 
> Guennadi, thanks for your NAK, you have understood correctly what my
> intention is. :-)
> 
> Looking into your two examples, sh_mmcif and sh_mobile_sdhci (using
> tmio), I realize that they use runtime PM in an awkward way. I would
> suggest to move parts of the clock gating from .set_ios to runtime PM
> callbacks instead. Obviously proper calls to pm_runtime_get|put needs
> to be adopted as well. pm_runtime_get|put should be used to make sure
> your "runtime resources" are active while I/O operations are ongoing,
> they aren't in those drivers as of today.
> 
> So to give you some more details about why I wanted to push for a
> removal of MMC_CLKGATE. You have one reason above. I want host drivers
> that considers power save at request inactivity, to implement proper
> runtime PM support and to do clock gating as a part of runtime PM.
> There are already good references, like mmci and sdhci-* for example.
> 
> MMC_CLKGATE is an old way of dealing with clock gating for power save,
> runtime PM is better suited and has been there now for a long time
> now. It is time to switch.
> 
> I don't think mmc clock gating should be depending on a separate
> kernel config as MMC_CLKGATE, which likely is the reason to why there
> are no defconfig that has this option enabled. Instead RUNTIME_PM
> already has this implicit meaning of handling with power save at
> request inactivity.
> 
> Finally, it is nice to remove code from a maintenance point of view.
> The MMC_CLKGATE code is being used in a lot of places around the core
> layer, since "mmc_host_clk_hold|release" needs to be called so many
> times.
> 
> What are your thoughts on the way forward? Could we adopt fully
> runtime pm support for sh_mmcif sh_mobile_sdhci soon?

Sorry, I don't have any information whether or when this will be done.

Thanks
Guennadi

> Kind regards
> Ulf Hansson
> 
> >
> > Thanks
> > Guennadi
> >
> >>
> >>  Documentation/mmc/mmc-dev-attrs.txt |   10 --
> >>  arch/mips/configs/db1235_defconfig  |    1 -
> >>  drivers/mmc/core/Kconfig            |   10 --
> >>  drivers/mmc/core/core.c             |  116 +----------------
> >>  drivers/mmc/core/core.h             |    3 -
> >>  drivers/mmc/core/debugfs.c          |    5 -
> >>  drivers/mmc/core/host.c             |  245 -----------------------------------
> >>  drivers/mmc/core/mmc.c              |    6 +-
> >>  drivers/mmc/core/sd.c               |   12 +-
> >>  drivers/mmc/core/sdio.c             |    5 +-
> >>  drivers/mmc/core/sdio_irq.c         |   10 +-
> >>  include/linux/mmc/host.h            |   27 ----
> >>  12 files changed, 12 insertions(+), 438 deletions(-)
> >>
> >> --
> >> 1.7.9.5
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
