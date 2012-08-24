From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Fri, 24 Aug 2012 09:51:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.01.1208240942100.21552@pmeerw.net>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org> <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com> <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com> <20120718065951.GH6522@atomide.com>
 <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com> <20120718071039.GI6522@atomide.com> <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com> <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
 <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com> <alpine.DEB.2.01.1208232246530.15831@pmeerw.net> <CAMQu2gyEGPbNEE0ur0wh9RoJKuBe4B5NkQMUafQNWGVLX8t9vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAMQu2gyEGPbNEE0ur0wh9RoJKuBe4B5NkQMUafQNWGVLX8t9vg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 24 Aug 2012, Shilimkar, Santosh wrote:

> On Fri, Aug 24, 2012 at 2:30 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> >
> > On Wed, 18 Jul 2012, Javier Martinez Canillas wrote:
> >
> > > On Wed, Jul 18, 2012 at 10:36 AM, Shilimkar, Santosh
> > > <santosh.shilimkar@ti.com> wrote:
> > > > On Wed, Jul 18, 2012 at 1:14 PM, S, Venkatraman <svenkatr@ti.com>
> > > > wrote:
> > > >> On Wed, Jul 18, 2012 at 12:40 PM, Tony Lindgren <tony@atomide.com>
> > > >> wrote:
> > > >>> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120718 00:09]:
> > > >>>> On Wed, Jul 18, 2012 at 12:29 PM, Tony Lindgren <tony@atomide.com>
> > > >>>> wrote:
> > > >>>> > * Javier Martinez Canillas <javier@dowhile0.org> [120716 23:56]:
> > > >>>> >> On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
> > > >>>> >> <santosh.shilimkar@ti.com> wrote:
> > > >>>> >> > Hi,
> > > >>>> >> >
> > > >>>> >> > On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
> > > >>>> >> > <javier@dowhile0.org> wrote:
> > > >>>> >> >> The OMAP MMC and OMAP High Speed MMC hosts now use entirely
> > > >>>> >> >> the DMA
> > > >>>> >> >> engine API instead of the previous private DMA API
> > > >>>> >> >> implementation.
> > > >>>> >> >>
> > > >>>> >> >> So, if the kernel is built with support for any of these
> > > >>>> >> >> hosts but it
> > > >>>> >> >> doesn't support DMA devices nor OMAP DMA support, it fails
> > > >>>> >> >> when trying
> > > >>>> >> >> to obtain a DMA channel which leads to the following error on
> > > >>>> >> >> an OMAP3
> > > >>>> >> >> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC
> > > >>>> >> >> support):
> > > >>>> >> >>
> > > >>>> >> >> [ 2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA
> > > >>>> >> >> engine channel 48
> > > >>>> >> >> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX
> > > >>>> >> >> DMA engine channel 62
> > > >>>> >> >>
> > > >>>> >> >> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP
> > > >>>> >> >> solves it.
> > > >>>> >> >>
> > > >>>> >> >> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> > > >>>> >> >> ---
> > > >>>> >> > Considering, we are updating drivers to select the DMA engine,
> > > >>>> >> > can you
> > > >>>> >> > also include
> > > >>>> >> > "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA
> > > >>>> >> > engine.
> > > >>>> >> >
> > > >>>> >> > Regards
> > > >>>> >> > Santosh
> > > >>>> >>
> > > >>>> >> Hi Santosh,
> > > >>>> >>
> > > >>>> >> Ok, I'll send a v2 now which includes spi-omap2-mcspi then.
> > > >>>> >
> > > >>>> > I don't think we should do this, the drivers should work with and
> > > >>>> > without
> > > >>>> > dma. This just needs to be added to the omap2plus_defconfig.
> > > >>>> >
> > > >>>> Well this was not decided based on any DMA CONFIG option before for
> > > >>>> the subject drivers. It is already by default enabled if the DMA is
> > > >>>> supported
> > > >>>> by the driver IP. There is a possibility to disable it from driver
> > > >>>> platform/dt
> > > >>>> data so that still remains.
> > > >>>
> > > >>> I think it should rather be that if the driver is broken and does
> > > >>> not work
> > > >>> without DMA, it should have depends on CONFIG_DMA_OMAP.
> > > >>>
> > > >> I can confirm that omap MMC can't work without DMA; polled mode is
> > > >> not
> > > >> supported / implemented.
> > > >
> > > > Same case for SPI driver as well. It uses DMA for everything except
> > > > the cases
> > > > where DMA doesn't make sense like 1 byte/2 byte etc. And its not
> > > > configurable,
> > > >
> > > > At least considering this, it is better we do this per driver than
> > > > enabling
> > > > it at SOC config.
> > > >
> > > > Regards
> > > > Santosh
> > > > --
> > >
> > > Hi Santosh,
> > >
> > > And what about enabling it at the SoC config level but making the
> > > drivers dependant on CONFIG_DMADEVICES and CONFIG_DMA_OMAP? If you
> > > agree I can send something like this in two different patches (one for
> > > the omap2plus_defconfig and another to make the drivers dependant on
> > > the config option):
> > >
> > > diff --git a/arch/arm/configs/omap2plus_defconfig
> > > b/arch/arm/configs/omap2plus_defconfig
> > > index b152de7..e58edc3 100644
> > > --- a/arch/arm/configs/omap2plus_defconfig
> > > +++ b/arch/arm/configs/omap2plus_defconfig
> > > @@ -193,6 +193,8 @@ CONFIG_MMC_OMAP_HS=y
> > >  CONFIG_RTC_CLASS=y
> > >  CONFIG_RTC_DRV_TWL92330=y
> > >  CONFIG_RTC_DRV_TWL4030=y
> > > +CONFIG_DMADEVICES=y
> > > +CONFIG_DMA_OMAP=y
> > >  CONFIG_EXT2_FS=y
> > >  CONFIG_EXT3_FS=y
> > >  # CONFIG_EXT3_FS_XATTR is not set
> >
> > above has been merged, 89269ef1f0abc72c551198123e19cd4edfd43cf4
> > but I am missing the patches below in mainline (3.6-rc3) -- what happened?
> >
> > as Javier pointed out in https://patchwork.kernel.org/patch/1203391/,
> > MMC is broken support e.g. on beagleboard unless DMA_OMAP is defined
> >
> > I suggest to take below patches and help to avoid some extra gray hair for
> > people looking for a fix for non-booting beagleboards
> >
> May be I am missing something, but why you would need below patch
> for beagle with "89269ef1f0abc72c551198123e19cd4edfd43cf4" commit
> enabling the DMA_OMAP for all OMAP boards.

the commit just sets CONFIG_DMA_OMAP=y and CONFIG_DMADEVICES=y in 
omap2plus_defconfig; this does not help people updating the kernel while 
keeping the config, nor does it help people in configuring the kernel

there is a dependency (at least for beagleboard) between MMC_OMAP_HS and 
DMA_OMAP, and I think this should be made explicit

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
