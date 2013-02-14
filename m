From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 06/13] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 14 Feb 2013 10:59:21 +0900
Message-ID: <20130214015920.GK15879@verge.net.au>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
 <1360180020-18555-7-git-send-email-g.liakhovetski@gmx.de>
 <201302062224.20549.arnd@arndb.de>
 <20130207005957.GB9775@verge.net.au>
 <Pine.LNX.4.64.1302131632280.18535@axis700.grange>
 <CANqRtoS_3wbNxVoPy48r=OFbnG=a7f6TDwc9XWcajkdANqsd8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANqRtoS_3wbNxVoPy48r=OFbnG=a7f6TDwc9XWcajkdANqsd8g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 14, 2013 at 10:42:21AM +0900, Magnus Damm wrote:
> On Thu, Feb 14, 2013 at 12:59 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Thu, 7 Feb 2013, Simon Horman wrote:
> >
> >> On Wed, Feb 06, 2013 at 10:24:20PM +0000, Arnd Bergmann wrote:
> >> > On Wednesday 06 February 2013, Guennadi Liakhovetski wrote:
> >> > > +* Toshiba Mobile IO SD/MMC controller
> >> > > +
> >> > > +The tmio-mmc driver doesn't probe its devices actively, instead its binding to
> >> > > +devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
> >> > > +driver. Those drivers supply the tmio-mmc driver with platform data, that either
> >> > > +describe hardware capabilities, known to them, or are obtained by them from
> >> > > +their own platform data or from their DT information. In the latter case all
> >> > > +compulsory and any optional properties, common to all SD/MMC drivers, as
> >> > > +described in mmc.txt, should or can be used. Additionally the following optional
> >> > > +bindings can be used. They set respective TMIO_MMC_* flags.
> >> > > +
> >> > > +Optional properties:
> >> > > +- toshiba,mmc-wrprotect-disable        : set TMIO_MMC_WRPROTECT_DISABLE flag
> >> > > +- toshiba,mmc-blksz-2bytes     : set TMIO_MMC_BLKSZ_2BYTES
> >> > > +- toshiba,mmc-has-idle-wait    : set TMIO_MMC_HAS_IDLE_WAIT
> >> >
> >> > Please write the binding in a way that does not refer to a specific
> >> > implementation in Linux: The binding should describe the hardware
> >> > independent of details in the driver. In particular, I think you
> >> > should not refer to the TMIO_MMC_BLKSZ_2BYTES etc macros but describe
> >> > in text what the flags are about.
> >> >
> >> > Regarding the toshiba,mmc-wrprotect-disable property, would it be
> >> > enough to just check the presence of the wp-gpios property?
> >> >
> >> > TMIO_MMC_BLKSZ_2BYTES seems to be set unconditionally in
> >> > sh_mobile_sdhi_probe and nowhere else, so I'd assume we don't
> >> > actually need to provide this here, but can keep that knowledge
> >> > implicit based on whether we're talking to sh_mobile_sdhi
> >> > or another tmio_mmc variant.
> >
> > Can do that, yes.
> >
> >> > For the other last one, is that actually board specific, or just
> >> > a feature of a given chip? If we can tell by the SoC, then I'd
> >> > suggest using separate "compatible" properties instead, and
> >> > put a bitmask of features into the .data field of the of match
> >> > table. For all I can tell, SH7372 does not set it, while SH73A0,
> >> > R8A7740 and R8A7779 always do.
> >>
> >> My understanding is that TMIO_MMC_HAS_IDLE_WAIT can be set based
> >> on the SoC in use.
> >
> > So far TMIO_MMC_HAS_IDLE_WAIT is set on
> >
> > board-kzm9g.c (sh73a0 / AG5)
> > board-ag5evm.c (sh73a0 / AG5)
> > board-armadillo800eva.c (r8a7740 / A1)
> > board-kota2.c (sh73a0 / AG5)
> > board-marzen.c (r8a7779 / H1)
> >
> > and isn't set on
> >
> > board-ap4evb.c (sh7372 / ap4)
> > board-bonito.c (r8a7740 / a1, SDHI isn't used)
> > board-mackerel.c (sh7372 / ap4)
> >
> > So, shall we use a compatible property for this and drop this property? We
> > can add later at any time, if needed, which is better, than defining
> > something redundant. OTOH I seem to remember, that using SoC-version from
> > the "compatible" property was considered by someone inappropriate. Magnus,
> > what do you think?
> 
> I prefer you to use a hardware-block version compatible suffix instead
> of SoC suffix.
> 
> This since we have more SoCs than actual hardware block
> configurations. Using the list above, how many configurations would we
> have?
> 
> Actually, forcing the drivers to be updated for each new SoC sounds
> like a pretty terrible idea. Wouldn't that be against one of the
> merits of using DT? Also, don't you have enough interesting work piled
> up already? =)
> 
> Basically, I can't see any point in adding an extra unnecessary need
> for updating the drivers when there is no real functional change.

My understanding is that the discussion is about the details of
bindings that are required for SDHI to function when brought
up using DT on a variety of boards. Not exciting new work.

In particular how to set TMIO_MMC_HAS_IDLE_WAIT via DT.
