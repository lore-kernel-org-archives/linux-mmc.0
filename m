From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 06/13] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 7 Feb 2013 08:27:29 +0000
Message-ID: <201302070827.29355.arnd@arndb.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de> <201302062224.20549.arnd@arndb.de> <20130207005957.GB9775@verge.net.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130207005957.GB9775@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thursday 07 February 2013, Simon Horman wrote:
> > Please write the binding in a way that does not refer to a specific
> > implementation in Linux: The binding should describe the hardware
> > independent of details in the driver. In particular, I think you
> > should not refer to the TMIO_MMC_BLKSZ_2BYTES etc macros but describe
> > in text what the flags are about.
> > 
> > Regarding the toshiba,mmc-wrprotect-disable property, would it be
> > enough to just check the presence of the wp-gpios property?
> > 
> > TMIO_MMC_BLKSZ_2BYTES seems to be set unconditionally in
> > sh_mobile_sdhi_probe and nowhere else, so I'd assume we don't
> > actually need to provide this here, but can keep that knowledge
> > implicit based on whether we're talking to sh_mobile_sdhi
> > or another tmio_mmc variant.
> > 
> > For the other last one, is that actually board specific, or just
> > a feature of a given chip? If we can tell by the SoC, then I'd
> > suggest using separate "compatible" properties instead, and
> > put a bitmask of features into the .data field of the of match
> > table. For all I can tell, SH7372 does not set it, while SH73A0,
> > R8A7740 and R8A7779 always do.
> 
> My understanding is that TMIO_MMC_HAS_IDLE_WAIT can be set based
> on the SoC in use.

Ok, thanks for the confirmation. Just to be clear: Either way (compatible
or separate property) works fine and can be used here. I tend to prefer
basing these things on the "compatible" string in order to keep
specific knowledge of the device internals out of the device tree
binding though.

	Arnd
