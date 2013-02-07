From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 06/13] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 7 Feb 2013 09:59:58 +0900
Message-ID: <20130207005957.GB9775@verge.net.au>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
 <1360180020-18555-7-git-send-email-g.liakhovetski@gmx.de>
 <201302062224.20549.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201302062224.20549.arnd@arndb.de>
Sender: linux-sh-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 06, 2013 at 10:24:20PM +0000, Arnd Bergmann wrote:
> On Wednesday 06 February 2013, Guennadi Liakhovetski wrote:
> > +* Toshiba Mobile IO SD/MMC controller
> > +
> > +The tmio-mmc driver doesn't probe its devices actively, instead its binding to
> > +devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
> > +driver. Those drivers supply the tmio-mmc driver with platform data, that either
> > +describe hardware capabilities, known to them, or are obtained by them from
> > +their own platform data or from their DT information. In the latter case all
> > +compulsory and any optional properties, common to all SD/MMC drivers, as
> > +described in mmc.txt, should or can be used. Additionally the following optional
> > +bindings can be used. They set respective TMIO_MMC_* flags.
> > +
> > +Optional properties:
> > +- toshiba,mmc-wrprotect-disable        : set TMIO_MMC_WRPROTECT_DISABLE flag
> > +- toshiba,mmc-blksz-2bytes     : set TMIO_MMC_BLKSZ_2BYTES
> > +- toshiba,mmc-has-idle-wait    : set TMIO_MMC_HAS_IDLE_WAIT
> 
> Please write the binding in a way that does not refer to a specific
> implementation in Linux: The binding should describe the hardware
> independent of details in the driver. In particular, I think you
> should not refer to the TMIO_MMC_BLKSZ_2BYTES etc macros but describe
> in text what the flags are about.
> 
> Regarding the toshiba,mmc-wrprotect-disable property, would it be
> enough to just check the presence of the wp-gpios property?
> 
> TMIO_MMC_BLKSZ_2BYTES seems to be set unconditionally in
> sh_mobile_sdhi_probe and nowhere else, so I'd assume we don't
> actually need to provide this here, but can keep that knowledge
> implicit based on whether we're talking to sh_mobile_sdhi
> or another tmio_mmc variant.
> 
> For the other last one, is that actually board specific, or just
> a feature of a given chip? If we can tell by the SoC, then I'd
> suggest using separate "compatible" properties instead, and
> put a bitmask of features into the .data field of the of match
> table. For all I can tell, SH7372 does not set it, while SH73A0,
> R8A7740 and R8A7779 always do.

My understanding is that TMIO_MMC_HAS_IDLE_WAIT can be set based
on the SoC in use.
