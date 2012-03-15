From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Thu, 15 Mar 2012 20:30:37 +0000
Message-ID: <20120315203037.GA2311@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <201203151746.56678.arnd@arndb.de> <20120315175443.GG15988@n2100.arm.linux.org.uk> <201203151823.32882.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36555 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161428Ab2COUbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 16:31:03 -0400
Content-Disposition: inline
In-Reply-To: <201203151823.32882.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org

On Thu, Mar 15, 2012 at 06:23:32PM +0000, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Russell King - ARM Linux wrote:
> > On Thu, Mar 15, 2012 at 05:46:56PM +0000, Arnd Bergmann wrote:
> > > Can you elaborate? I suggested the split in order to keep the ux500
> > > specific parts local to one file. With the device tree conversion,
> > > we really want to have them out of the platform code, but sticking them
> > > into the main driver seems wrong, too.
> > 
> > You're talking about the data structures which describe what quirks to
> > apply for the ux500 parts, rather than the actual quirks themselves.
> > That's not a particularly clever thing to do because it separates out
> > the selection of the works from the rest of the driver, which means
> > simply searching for the flags to find out what's applied for what has
> > to span several files.
> 
> Right, that is a disadvantage, but it's also how a lot of other
> drivers work, in particular sdhci.
> 
> My reasoning is roughly this:
> 
> * we want to get rid of arch/arm/mach-ux500/board-mop500-sdi.c
> * the sdi0_configure() and mop500_sdi0_vdd_handler() functions
>   need to be moved somewhere in order to do that, so they should
>   be with the driver.

I don't believe they should.  MMCI _is_ the peripheral itself.  All the
stuff that's in board-mop500-sdi.c seems to be doing is configuration
type stuff for the SoC that its been integrated into.  Are you seriously
advocating having multiple drivers for essentially the same hardware?

> * we don't want them in mmci.c, so we create a new file for these.
> * in order to call do the setup from sdi0_configure right, it needs
>   to be done in the probe() function

I've always disagreed with this whole approach of "drivers should callback
into generic code to claim their GPIOs".  If the GPIO is dedicated by a
platform to a function, then that function is there independent of whether
the driver is present or not.  In many cases, it is totally _wrong_ to
leave a signal which should be driven unconfigured - if the board design
is such that its intended to be an output and there's no pull-up, it
could end up floating at half-supply which will eat power.

I have always been of the opinion that resources like GPIOs which are
under platform control should be requested and configured by the platform
and not by their respective drivers.

Have you noticed how much of the configuration is tweaked depending on
which init function is called?

> * if we want to have a separate probe function, we also need to
>   have a separate amba_driver structure
> * the variant_data in mmci.c belongs with the amba_id, so that
>   also gets moved to the ux500 file.
> 
> If you have a better solution for one or more of these, I'm
> all ears.

Are you really advocating having mmci_foo.c where foo is an ever
increasing number of SoCs with the MMCI integrated because you want
to integrate SoC specific details into the MMCI peripheral driver?

> The alternatives that I can see are:
> a) keep using auxdata to supply a platform_data pointer and
>    do everything in the main driver. Problem: we want to
>    avoid auxdata if possible
> b) move the code from patch 4 into mmci.c using #ifdef.
>    Problem: it's ugly code that has nothing to do with mmci
>    in general.
> c) use the regulator framework to do the voltage selection
>    here, and have only generic code in mmci.c. This may
>    be the best solution, but I have no idea if this is
>    actually possible, or how to do it.

Let's ignore the DMA stuff for the time being - that's a separate problem
which needs to be addressed once we work out how to deal with how DMA
engine stuff gets resolved with DT based systems.

The remainder of it (mmci_platform_data) looks like it can be easily
represented as DT properties, the exception to that is the ios_handler.
I think the right solution for that is to move to the regulator framework,
but allow the driver to continue having the ios callback if there is
no attached regulator.  It needs that because of the four integrated
regulator control bits (which are entirely undefined.)

We _do_ need a solution for GPIO-controlled voltage regulators, as these
are actually quite common - see the various soc-common using PCMCIA
drivers.

So I think actually a bit more thought is required here, and there's a
need to use some of the facilities such as regulator which are now present
that weren't when the driver was originally written some 9 years ago.
