From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] mmc: sdhi: Enable the driver on all ARM platforms
Date: Thu, 31 Oct 2013 13:00:11 +0100
Message-ID: <3866184.WsFITZrrct@avalon>
References: <1383086274-11049-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1383132190-5285-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CANqRtoR3Aj-j00=riDuDdWW2+AZD4jrjL2xHLt88ri2kdUB=Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50497 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab3JaL7s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Oct 2013 07:59:48 -0400
In-Reply-To: <CANqRtoR3Aj-j00=riDuDdWW2+AZD4jrjL2xHLt88ri2kdUB=Eg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, SH-Linux <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Magnus,

On Thursday 31 October 2013 17:26:30 Magnus Damm wrote:
> On Wed, Oct 30, 2013 at 8:23 PM, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> > 
> > Don't enable COMPILE_TEST support as the driver doesn't compile on x86
> > due (possibly among others) to missing readsw/writesw I/O accessors.
> > 
> > Whether the CTL_DMA_ENABLE register is part of the standard TMIO
> > controller or is Renesas-specific is unknown and impossible to test as
> > we have no current or planned TMIO DMA users other than SUPERH and
> > ARCH_SHMOBILE. Writing to the register is thus conditionally compiled
> > for SUPERH and ARCH_SHMOBILE only. Adding ARCH_SHMOBILE_MULTI to the
> > list would extend this to multiarch kernels, but would break the driver
> > for non-shmobile platforms if the register is Renesas-specific. We can
> > thus get rid of the conditional compilation completely without
> > introducing any further issue, and let future non-Renesas users deal
> > with the situation if it turns out to be a the problem.
> > 
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Ian Molton <ian@mnementh.co.uk>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/mmc/host/Kconfig        | 2 +-
> >  drivers/mmc/host/tmio_mmc_dma.c | 4 +---
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 7fc5099..51957d4 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -479,7 +479,7 @@ config MMC_TMIO
> > 
> >  config MMC_SDHI
> >         tristate "SH-Mobile SDHI SD/SDIO controller support"
> > -       depends on SUPERH || ARCH_SHMOBILE
> > +       depends on SUPERH || ARM
> >         select MMC_TMIO_CORE
> >         help
> >           This provides support for the SDHI SD/SDIO controller found in
> > diff --git a/drivers/mmc/host/tmio_mmc_dma.c
> > b/drivers/mmc/host/tmio_mmc_dma.c index 65edb4a..8a4fd2d 100644
> > --- a/drivers/mmc/host/tmio_mmc_dma.c
> > +++ b/drivers/mmc/host/tmio_mmc_dma.c
> > @@ -28,10 +28,8 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host,
> > bool enable)> 
> >         if (!host->chan_tx || !host->chan_rx)
> >                 return;
> > 
> > -#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> > -       /* Switch DMA mode on or off - SuperH specific? */
> > +       /* Switch DMA mode on or off. This might be Renesas-specific. */
> >         sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
> > -#endif
> 
> Hi Laurent,
> 
> Thanks for your efforts. Hate to slow things down, but this last hunk looks
> wrong to me. I believe the reason for the #ifdef is that non-Renesas IP may
> be using the tmio_mmc driver, at least they used to. Not sure if anyone is
> using DMA Engine though. If I were you I would play it safe and simply
> update the #ifdef with same kind of dependencies that the Kconfig bits have.

There are several points to consider here.

- drivers/mmc/host/tmio_mmc_dma.c is only compiled in when CONFIG_MMC_SDHI is 
selected. The symbol currently depends on SUPERH || ARCH_SHMOBILE. We thus 
have no non-Renesas users for TMIO DMA at the moment.

- I don't know whether the CTL_DMA_ENABLE register is specific to Renesas or 
not. I haven't been able to find a publicly available copy of the TMIO 
documentation. The Renesas datasheets I have access to don't document the SDHI 
module. Can you comment on that ?

- Merely adding CONFIG_ARCH_SHMOBILE_MULTI to the CTL_DMA_ENABLE write #if 
guard will break on multiplatform kernels anyway. If a non-Renesas platform 
uses TMIO DMA, a kernel that supports both a Renesas SoC and that non-Renesas 
platform will have the CTL_DMA_ENABLE code compiled in.

For those reasons I have decided to remove the #if and defer the fix (if 
needed, if CTL_DMA_ENGINE is indeed Renesas-specific) to the first non-Renesas 
TMIO DMA user.

> Also, it would of course be nice to clean up the driver, perhaps with a
> feature flag for this special register or why not simply move the code to
> the sdhi file. But that's not really related to your multiplatform kconfig
> change, is it? =)

No, it isn't :-) I could try to find time to fix that later, but I don't like 
adding support for features that are not used. I would first want to be sure 
that the CTL_DMA_ENABLE register is indeed Renesas-specific, which might be a 
bit hard to ascertain of no non-Renesas chip implements TMIO DMA :-)

-- 
Regards,

Laurent Pinchart

