From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 15:07:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205241441240.1462@axis700.grange>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
 <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51362 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab2EXNHl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 09:07:41 -0400
In-Reply-To: <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>

On Thu, 24 May 2012, Ohad Ben-Cohen wrote:

> Hi Guennadi,
> 
> On Thu, May 24, 2012 at 2:18 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Some sources
> > indicate, that this flag means, that the host / board are _capable_ of
> > powering down the slot.  Others seem to suggest, that it also means, that
> > the card can handle being powered off.
> 
> Take a look how MMC_CAP_POWER_OFF_CARD is described in the commit log
> which added it:

Yes, I read it, it was one of "sources."

> commit ed919b0125b26dcc052e44836f66e7e1f5c49c7e
> Author: Ohad Ben-Cohen <ohad@wizery.com>
> Date:   Fri Nov 19 09:29:09 2010 +0200
> 
>     mmc: sdio: fix runtime PM anomalies by introducing MMC_CAP_POWER_OFF_CARD
> 
>     Some board/card/host configurations are not capable of powering off the
>     card after boot.
> 
>     To support such configurations, and to allow smoother transition to
>     runtime PM behavior, MMC_CAP_POWER_OFF_CARD is added, so hosts need to
>     explicitly indicate whether it's OK to power off their cards after boot.
> 
>     SDIO core will enable runtime PM for a card only if that cap is set.
>     As a result, the card will be powered down after boot, and will only
>     be powered up again when a driver is loaded (and then it's up to the
>     driver to decide whether power will be kept or not).
> 
>     This will prevent sdio_bus_probe() failures with setups that do not
>     support powering off the card.
> 
>     Reported-and-tested-by: Daniel Drake <dsd@laptop.org>
>     Reported-and-tested-by: Arnd Hannemann <arnd@arndnet.de>
>     Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>
> 
> > The former meaning would make sense
> > to me, but then - why would one want to check it when deciding whether or
> > not to use runtime PM with the host?
> 
> Because if a certain board/host/card setup doesn't support it, then we
> should not power off the card, because doing so means we'll have to
> reset the entire board if we want the card to work again.

How do you know, if this is a normal sd-card slot?

> > Isn't it exactly what the MMC_PM_KEEP_POWER flag is for?
> 
> No, MMC_PM_KEEP_POWER is different: it is a dynamic user decision
> controlling whether the card should stay on while the system is
> suspended,

Isn't it both? mmc_host::pm_caps is static capabilities, and ::pm_flags is 
the current dynamic configuration?

> while MMC_CAP_POWER_OFF_CARD is a static capability of the
> hardware.
> 
> > If MMC_CAP_POWER_OFF_CARD does indeed mean,
> > that the host is able to switch the power off and on, then it can be
> > safely set almost always. E.g., if the slot is supplied by a regulator,
> > this flag can be enabled automatically?
> 
> Not always.
> 
> For example, consider a (non-fictional) configuration where you can
> power off the card, but after you power it on again, you must toggle
> some card reset pin for it to work, but your board doesn't have that
> reset pin hardwired to any gpio.
> 
> In this case, despite the existing regulator, you must not power off
> the card, because doing so requires you to reset your entire board if
> you want the card to work again.

A complete board reset in this case will differ from the card power-off 
only in the state of the rest of the SD-card ping, e.g., the clock. So, 
additionally switching off the clock in this case should be equivalent to 
the board reset?

Given the above, wouldn't it be sufficient to test (mmc->pm_flags & 
MMC_PM_KEEP_POWER) to decide, whether the card can be suspended?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
