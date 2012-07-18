From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Wed, 18 Jul 2012 00:10:39 -0700
Message-ID: <20120718071039.GI6522@atomide.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
 <20120718065951.GH6522@atomide.com>
 <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Kevin.Hilman.khilman@ti.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120718 00:09]:
> On Wed, Jul 18, 2012 at 12:29 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Javier Martinez Canillas <javier@dowhile0.org> [120716 23:56]:
> >> On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
> >> <santosh.shilimkar@ti.com> wrote:
> >> > Hi,
> >> >
> >> > On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
> >> > <javier@dowhile0.org> wrote:
> >> >> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
> >> >> engine API instead of the previous private DMA API implementation.
> >> >>
> >> >> So, if the kernel is built with support for any of these hosts but it
> >> >> doesn't support DMA devices nor OMAP DMA support, it fails when trying
> >> >> to obtain a DMA channel which leads to the following error on an OMAP3
> >> >> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
> >> >>
> >> >> [    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
> >> >> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
> >> >>
> >> >> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
> >> >>
> >> >> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> >> >> ---
> >> > Considering, we are updating drivers to select the DMA engine, can you
> >> > also include
> >> > "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.
> >> >
> >> > Regards
> >> > Santosh
> >>
> >> Hi Santosh,
> >>
> >> Ok, I'll send a v2 now which includes spi-omap2-mcspi then.
> >
> > I don't think we should do this, the drivers should work with and without
> > dma. This just needs to be added to the omap2plus_defconfig.
> >
> Well this was not decided based on any DMA CONFIG option before for
> the subject drivers. It is already by default enabled if the DMA is supported
> by the driver IP. There is a possibility to disable it from driver platform/dt
> data so that still remains.

I think it should rather be that if the driver is broken and does not work
without DMA, it should have depends on CONFIG_DMA_OMAP.

Regards,

Tony
