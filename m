From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: edma: Split up header file to platform_data and API file
Date: Mon, 08 Dec 2014 14:16:59 +0100
Message-ID: <5296454.gCL6SxI1xr@wuerfel>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com> <1417084891-17990-4-git-send-email-peter.ujfalusi@ti.com> <20141208124917.GI16827@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141208124917.GI16827-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Monday 08 December 2014 18:19:17 Vinod Koul wrote:
> On Thu, Nov 27, 2014 at 12:41:31PM +0200, Peter Ujfalusi wrote:
> > include/linux/platform_data/ is not a correct place to keep the API
> > definitions for edma, it is meant to be only for the pdata for the device.
> > Clean up this by moving the API to include/linux/edma.h
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/common/edma.c                     |   3 +-
> >  arch/arm/mach-davinci/devices.c            |   1 +
> >  arch/arm/mach-davinci/include/mach/da8xx.h |   1 +
> >  drivers/dma/edma.c                         |   2 +-
> >  include/linux/edma.h                       | 153 +++++++++++++++++++++++++++++
> >  include/linux/platform_data/edma.h         | 148 ++--------------------------
> >  sound/soc/davinci/davinci-pcm.h            |   1 +
> >  7 files changed, 165 insertions(+), 144 deletions(-)
> >  create mode 100644 include/linux/edma.h
> I was hoping that this will have delete for platform_data/edma.h, do we
> still need that and why shouldn't we get rid of this 

I think the platform_data/edma.h file is needed for as long as we have
mach-davinci systems that are not converted to boot using DT. At the current
pace of development in that area, I would expect that to take a few more
years at least: da850 support is slowly proceeding (since 2012), da830 should
be fairly straightforward to add once da850 is done, but I haven't seen
anybody start working on the dm* socs for DT.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
