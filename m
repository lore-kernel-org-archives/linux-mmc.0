From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC_CAP_POWER_OFF_CARD, MMC_PM_KEEP_POWER - when to set
Date: Thu, 24 May 2012 15:24:46 +0300
Message-ID: <CAK=Wgbb7RwAhhSCwb-NYCd8SNzQTJSNna8t4Zqdi5Q9T1ADSxg@mail.gmail.com>
References: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:39581 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab2EXMZH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 08:25:07 -0400
Received: by gglu4 with SMTP id u4so7621595ggl.19
        for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 05:25:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205241205030.1462@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@marvell.com>

Hi Guennadi,

On Thu, May 24, 2012 at 2:18 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Some sources
> indicate, that this flag means, that the host / board are _capable_ of
> powering down the slot.  Others seem to suggest, that it also means, that
> the card can handle being powered off.

Take a look how MMC_CAP_POWER_OFF_CARD is described in the commit log
which added it:

commit ed919b0125b26dcc052e44836f66e7e1f5c49c7e
Author: Ohad Ben-Cohen <ohad@wizery.com>
Date:   Fri Nov 19 09:29:09 2010 +0200

    mmc: sdio: fix runtime PM anomalies by introducing MMC_CAP_POWER_OFF_CARD

    Some board/card/host configurations are not capable of powering off the
    card after boot.

    To support such configurations, and to allow smoother transition to
    runtime PM behavior, MMC_CAP_POWER_OFF_CARD is added, so hosts need to
    explicitly indicate whether it's OK to power off their cards after boot.

    SDIO core will enable runtime PM for a card only if that cap is set.
    As a result, the card will be powered down after boot, and will only
    be powered up again when a driver is loaded (and then it's up to the
    driver to decide whether power will be kept or not).

    This will prevent sdio_bus_probe() failures with setups that do not
    support powering off the card.

    Reported-and-tested-by: Daniel Drake <dsd@laptop.org>
    Reported-and-tested-by: Arnd Hannemann <arnd@arndnet.de>
    Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
    Signed-off-by: Chris Ball <cjb@laptop.org>

> The former meaning would make sense
> to me, but then - why would one want to check it when deciding whether or
> not to use runtime PM with the host?

Because if a certain board/host/card setup doesn't support it, then we
should not power off the card, because doing so means we'll have to
reset the entire board if we want the card to work again.

> Isn't it exactly what the MMC_PM_KEEP_POWER flag is for?

No, MMC_PM_KEEP_POWER is different: it is a dynamic user decision
controlling whether the card should stay on while the system is
suspended, while MMC_CAP_POWER_OFF_CARD is a static capability of the
hardware.

> If MMC_CAP_POWER_OFF_CARD does indeed mean,
> that the host is able to switch the power off and on, then it can be
> safely set almost always. E.g., if the slot is supplied by a regulator,
> this flag can be enabled automatically?

Not always.

For example, consider a (non-fictional) configuration where you can
power off the card, but after you power it on again, you must toggle
some card reset pin for it to work, but your board doesn't have that
reset pin hardwired to any gpio.

In this case, despite the existing regulator, you must not power off
the card, because doing so requires you to reset your entire board if
you want the card to work again.

Thanks,
Ohad.
