From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: How to manage SDIO interrupts with a runtime power managed host.
Date: Tue, 27 Jan 2015 14:30:23 +0100
Message-ID: <CAPDyKFphGV9Scc8xfy+dJ=CK4AsVSs_B-HcNV5Z0y0_KtXoSig@mail.gmail.com>
References: <20150127224722.53f4ac83@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:42007 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932244AbbA0NaY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 08:30:24 -0500
Received: by mail-qg0-f45.google.com with SMTP id q107so11597508qgd.4
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2015 05:30:23 -0800 (PST)
In-Reply-To: <20150127224722.53f4ac83@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>

On 27 January 2015 at 12:47, NeilBrown <neilb@suse.de> wrote:
>
> The (libertas) wifi chip in my GTA04 is connected to an OMAP3 HS_MMC port as
> an SDIO card.
>
> When I configure it (via devicetree) to respond to the SD interrupt line
> (rather than polling for SD interrupts) it doesn't work well at all.
>
> After lots of experimenting and beating my head against a brick wall I have
> finally discovered why.
>
> According to section 7.1.2 of
>
> http://www.sandisk.com/media/File/OEM/Manuals/SD_SDIO_specsv1.pdf
>
>     In the case where the interrupt mechanism is used to wake the host while
>     the card is in a low power state (i.e. no clocks), Both the card and the
>     host shall be placed into the 1-bit SD mode prior to stopping the clock.
>
> The omap_hsmmc driver doesn't appear to be aware of this requirement (and I
> cannot see that other host drivers are either). It will turn off the clocks
> for a 4-bit device without first switching to 1-bit.

I guess the reason to why this isn't implemented in host drivers is
either because such behaviour for SDIO cards hasn't been observed
(that's my case) or that it's kept as "hacks" in out of tree patches.

>
> (The mmc core does switch to 1-bit mode for system suspend, but not for
> runtime suspend).
>
> This requirement exactly explains my observations.  The chip is configured
> for 4-bit mode, and once pm_runtime turns the clocks off, interrupts stop
> being delivered.  Note that the "reconfigure DAT1 as a GPIO" magic is properly
> configured.  When something else wakes the chip, the GPIO interrupt handler
> will sometimes run in the small window between the clocks coming back and
> the DAT1 pin being configured back to the default setting.

Have you really investigated that it's not the GPIO IRQ that's not
been properly configured?

>
> If I configure the chip as using a 1-bit wide interface, it works perfectly.
> In this configuration it is significantly faster than 4-bit polled mode, but
> somewhat slower than 4-bit interrupt mode with runtime_pm disabled.

Okay, so it seems like your assumption is correct. We need a way to
switch to 1-bit when host drivers is about to enter runtime PM suspend
state.

>
> I'm open for suggestions on how best to fix this.
> I tried putting code into the pm_runtime_{suspend,resume} callbacks in
> omap_hsmmc.c to switch the bus width, but that doesn't work.  The callbacks
> aren't allowed to sleep, and telling the card to use the new bus width is a
> sleeping operation.

They are allowed to sleep unless the have set pm_runtime_irq_safe(). I
don't think any of the mmc drivers are configured as such.

>
> I imagine I could possibly do something similar to MMC_CLKGATE to switch to
> 1-bit mode after some idle time, and have the pm_runtime_suspend abort if it
> is still in 4-bit mode.  Would that be a good idea?

I would prefer not.

I don't like the MMC_CLKGATE thing, since it just add complexity to
the mmc core for things that I think should be handled through runtime
PM instead.

> Would it make sense to get mmc_gate_clock to switch bus width (if it is an
> SDIO card with interrupts enabled) rather than having a separate timeout
> thing?

That will hit performance for each and every SDIO request. To me this
is not an option.

Kind regards
Uffe
