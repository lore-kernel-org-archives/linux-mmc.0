From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4 v4] mmc, ARM: Add zboot from eSD support for SuperH
 Mobile ARM
Date: Wed, 16 Mar 2011 14:35:57 +0900
Message-ID: <20110316053542.GG27684@verge.net.au>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
 <1300071435-26759-5-git-send-email-horms@verge.net.au>
 <20110315222738.GA23288@verge.net.au>
 <AANLkTimgwpP-WTGF-E=KO3TAXDX7FP4WnW3XQiHi0Ton@mail.gmail.com>
 <20110316011427.GB6724@verge.net.au>
 <AANLkTimBOc2+Ryq+fwas0SPmYqbnJH6_b28DTPJx_p99@mail.gmail.com>
 <20110316051604.GF27684@verge.net.au>
 <AANLkTikwet++Dwz17C+MO2vH0tSuvNh-u0o8GKF814iF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikwet++Dwz17C+MO2vH0tSuvNh-u0o8GKF814iF@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 16, 2011 at 02:26:05PM +0900, Magnus Damm wrote:
> On Wed, Mar 16, 2011 at 2:16 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Mar 16, 2011 at 11:20:46AM +0900, Magnus Damm wrote:
> >> On Wed, Mar 16, 2011 at 10:14 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > How do you envisage that the hardware block would be selected?
> >> > At compile time through Kconfig? If so the current #define mechanism
> >> > might be sufficient.
> >>
> >> Not through Kconfig. I think you should use Kconfig to enable the SDHI
> >> loader, but you should be able to select the SDHI base address during
> >> run-time. Similar to how we enable platform device drivers with
> >> Kconfig but put the instance information in the platform device
> >> resource and data outside the driver.
> >>
> >> So for instance, on some board we may want to read a GPIO pin at boot
> >> up time to select if we should boot from SDHI0 or SDHI1. I would like
> >> the SDHI loader to be designed so we can have support for multiple
> >> instances complied-in. Because of that I'd like to see the fixed
> >> SDHI_BASE disappear from the header, and letting the mmc_loader()
> >> function take the base address as an argument, or simply move the
> >> mmc_loader() function out of the SDHI loader code to give CPU specific
> >> and/or board specific code freedom to select which ever SDHI hardware
> >> block instance(s) they want to load from.
> >>
> >> Perhaps this would require some serious refactoring?
> >
> > Either making mmc_loader() CPU specific or allowing it
> > to take an argument should be pretty straight forward.
> 
> Good!
> 
> > However, it is entirely unclear to me how the argument to mmc_loader()
> > would be supplied or alternatively the variant of mmc_loader() be
> > selected at run-time.
> 
> At this point, the sh7372 specific could would simply pass the same
> SDHI base address that your code is using. No special selection
> needed. Just compile it in.

Understood

> In the future we may want to read out the boot mode pins and select
> base address accordingly. It's too early to tell exactly what to do
> with the CPU specific bits for future processors, but at least we can
> make sure that the SDHI loader isn't tied to a single SDHI instance by
> design.

Ok, that is fine. I agree its too early to tell exactly what to
do beyond refactoring mmc_loader() at this point.

> > This code runs in very early boot. And as such I think that the two major
> > options are to either compile code in or pull it out of a register somehow.
> > We really don't have a whole lot of code that runs before mmc_loader() that
> > could do any kind of setup.
> 
> Compiling in the base address is fine for sh7372, but please put that
> base address in the CPU specific code and feed that to the more
> generic SDHI loader using a function argument.
> 
> Do you understand what I'm trying to do, or am I just going in circles? =)

I feared we would be going in circles, but I think we have averted that :-)
