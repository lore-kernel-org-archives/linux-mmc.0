From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Fri, 16 Mar 2012 12:48:15 +0000
Message-ID: <201203161248.15490.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <201203151823.32882.arnd@arndb.de> <20120315203037.GA2311@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53219 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030320Ab2CPMs4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 08:48:56 -0400
In-Reply-To: <20120315203037.GA2311@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> On Thu, Mar 15, 2012 at 06:23:32PM +0000, Arnd Bergmann wrote:
> > 
> > * we want to get rid of arch/arm/mach-ux500/board-mop500-sdi.c
> > * the sdi0_configure() and mop500_sdi0_vdd_handler() functions
> >   need to be moved somewhere in order to do that, so they should
> >   be with the driver.
> 
> I don't believe they should.  MMCI _is_ the peripheral itself.  All the
> stuff that's in board-mop500-sdi.c seems to be doing is configuration
> type stuff for the SoC that its been integrated into.  Are you seriously
> advocating having multiple drivers for essentially the same hardware?

It's basically the same we have for sdhci or ohci, or even the various
8250 versions. There is usually an identical core used in a number of
chips with slight variantions. In some cases it's better to describe
them as quirks of one driver, in other cases it's better abstract
them as separate driver files. The debate is just over which of these
two cases mmci fits into.

> > * if we want to have a separate probe function, we also need to
> >   have a separate amba_driver structure
> > * the variant_data in mmci.c belongs with the amba_id, so that
> >   also gets moved to the ux500 file.
> > 
> > If you have a better solution for one or more of these, I'm
> > all ears.
> 
> Are you really advocating having mmci_foo.c where foo is an ever
> increasing number of SoCs with the MMCI integrated because you want
> to integrate SoC specific details into the MMCI peripheral driver?

Only when they are significantly different from the common one.
According to your arguments above, the ux500 one might not be
different enough, but if something comes along that needs something
wildly different while still sharing a lot of the other code,
I would certainly use the same model.

> > The alternatives that I can see are:
> > a) keep using auxdata to supply a platform_data pointer and
> >    do everything in the main driver. Problem: we want to
> >    avoid auxdata if possible
> > b) move the code from patch 4 into mmci.c using #ifdef.
> >    Problem: it's ugly code that has nothing to do with mmci
> >    in general.
> > c) use the regulator framework to do the voltage selection
> >    here, and have only generic code in mmci.c. This may
> >    be the best solution, but I have no idea if this is
> >    actually possible, or how to do it.
> 
> Let's ignore the DMA stuff for the time being - that's a separate problem
> which needs to be addressed once we work out how to deal with how DMA
> engine stuff gets resolved with DT based systems.

Agreed.

> The remainder of it (mmci_platform_data) looks like it can be easily
> represented as DT properties, the exception to that is the ios_handler.
> I think the right solution for that is to move to the regulator framework,
> but allow the driver to continue having the ios callback if there is
> no attached regulator.  It needs that because of the four integrated
> regulator control bits (which are entirely undefined.)

Yes, that's what I was not sure about whether it's worth it. If we do this,
I absolutely agree that there is no need to split mmci.c.

> We _do_ need a solution for GPIO-controlled voltage regulators, as these
> are actually quite common - see the various soc-common using PCMCIA
> drivers.
> 
> So I think actually a bit more thought is required here, and there's a
> need to use some of the facilities such as regulator which are now present
> that weren't when the driver was originally written some 9 years ago.

Ok. Let's see what Mark has to say about this.

	Arnd
