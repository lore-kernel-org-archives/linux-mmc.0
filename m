From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4 v4] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Wed, 16 Mar 2011 14:16:20 +0900
Message-ID: <20110316051604.GF27684@verge.net.au>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
 <1300071435-26759-5-git-send-email-horms@verge.net.au>
 <20110315222738.GA23288@verge.net.au>
 <AANLkTimgwpP-WTGF-E=KO3TAXDX7FP4WnW3XQiHi0Ton@mail.gmail.com>
 <20110316011427.GB6724@verge.net.au>
 <AANLkTimBOc2+Ryq+fwas0SPmYqbnJH6_b28DTPJx_p99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:59119 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1CPFQ0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2011 01:16:26 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimBOc2+Ryq+fwas0SPmYqbnJH6_b28DTPJx_p99@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>

On Wed, Mar 16, 2011 at 11:20:46AM +0900, Magnus Damm wrote:
> On Wed, Mar 16, 2011 at 10:14 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Mar 16, 2011 at 09:37:50AM +0900, Magnus Damm wrote:

[snip]

> >> Not sure if it makes sense at this point, but perhaps it's a good idea
> >> to move the mmc_loader() function into the CPU specific portion. As
> >> you know, the CPU itself has multiple SDHI hardware blocks, and
> >> because of that we want the common SDHI loader to be written to
> >> support any SDHI hardware block instance.
> >
> > Wouldn't that mean moving all of
> > arch/arm/boot/compressed/sdhi-shmobile.c into CPU specific code?
> > That could easily be achived by just guarding its compilation with
> > CONFIG_ARCH_SH7372 (as mmcif-sh7372.c already is) and perhaps
> > renaming the file to sdhi-sh7372.c. We could probably move
> > arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h back into
> > sdhi-shmobile.c.
> 
> No, I didn't mean moving all the SDHI loader code into the CPU
> specific place - just the mmc_loader() function.
> 
> >> Right now the SDHI_BASE variable is limiting the shared SDHI loader
> >> code to a fixed hardware block instance. That's fine because we only
> >> boot from a single SDHI hardware block instance on sh7372, but future
> >> processors most likely support selecting boot SDHI hardware block
> >> instance.
> >
> > So mmc_loader() would need to take SDHI_BASE as an argument?
> > That sounds like a fairly small amount of refactoring.
> 
> Yes, that's maybe more realistic, I'm not sure. Please remember that
> you probably want to select different GPIO pins for different SDHI
> instances, so you also need to adjust the
> sdhi_boot_enter()/sdhi_boot_cleanup() to receive SDHI_BASE as an
> argument too if you go down that route.
> 
> > How do you envisage that the hardware block would be selected?
> > At compile time through Kconfig? If so the current #define mechanism
> > might be sufficient.
> 
> Not through Kconfig. I think you should use Kconfig to enable the SDHI
> loader, but you should be able to select the SDHI base address during
> run-time. Similar to how we enable platform device drivers with
> Kconfig but put the instance information in the platform device
> resource and data outside the driver.
> 
> So for instance, on some board we may want to read a GPIO pin at boot
> up time to select if we should boot from SDHI0 or SDHI1. I would like
> the SDHI loader to be designed so we can have support for multiple
> instances complied-in. Because of that I'd like to see the fixed
> SDHI_BASE disappear from the header, and letting the mmc_loader()
> function take the base address as an argument, or simply move the
> mmc_loader() function out of the SDHI loader code to give CPU specific
> and/or board specific code freedom to select which ever SDHI hardware
> block instance(s) they want to load from.
> 
> Perhaps this would require some serious refactoring?

Either making mmc_loader() CPU specific or allowing it
to take an argument should be pretty straight forward.

However, it is entirely unclear to me how the argument to mmc_loader()
would be supplied or alternatively the variant of mmc_loader() be
selected at run-time.

This code runs in very early boot. And as such I think that the two major
options are to either compile code in or pull it out of a register somehow.
We really don't have a whole lot of code that runs before mmc_loader() that
could do any kind of setup.

