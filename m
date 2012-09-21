From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
	arm/common
Date: Fri, 21 Sep 2012 14:34:46 -0400
Message-ID: <20120921183446.GH16522@beef>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
	<1348152226-13588-2-git-send-email-mporter@ti.com>
	<20120921092923.GA31374@n2100.arm.linux.org.uk>
	<1BAFE6F6C881BF42822005164F1491C33EA8AA3C@DBDE01.ent.ti.com>
	<20120921094205.GC31374@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120921094205.GC31374-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Hebbar,
	Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 21, 2012 at 10:42:05AM +0100, Russell King wrote:
> On Fri, Sep 21, 2012 at 09:33:42AM +0000, Hebbar, Gururaja wrote:
> > On Fri, Sep 21, 2012 at 14:59:23, Russell King - ARM Linux wrote:
> > > On Thu, Sep 20, 2012 at 10:43:34AM -0400, Matt Porter wrote:
> > > > Move mach-davinci/dma.c to common/edma.c so it can be used
> > > > by OMAP (specifically AM33xx atm) as well. This just moves
> > > > the private EDMA API but does not support OMAP.
> > > > 
> > > > Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> > > > ---
> > > >  arch/arm/Kconfig                           |    1 +
> > > >  arch/arm/common/Kconfig                    |    3 +
> > > >  arch/arm/common/Makefile                   |    1 +
> > > >  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++++++++
> > > >  arch/arm/include/asm/mach/edma.h           |  267 +++++
> > > 
> > > asm/mach should not be used as a dumping ground for platform header files.
> > > It is there to provide the interfaces between generic ARM architecture
> > > code and platform code.  (At least four files that are there at the
> > > moment need to be moved out of there - patch series to follow...)
> > 
> > Can this be moved to include/linux/platform_data/ ?
> 
> Here's the pertinant question: "is it platform data?"  Looking at the
> file, it appears to be internal data structures and register definitions
> for the driver itself.  Therefore, it isn't platform data, and it
> shouldn't be living separately from the driver.
> 
> If the driver itself only makes use of the data structures, the data
> structures should be defined either within the driver, or a header file
> co-located next to the driver itself.  The same goes for register
> definitions too.
> 
> The only structure that I can find which isn't internal to the driver
> is struct edma_soc_info, struct edma_rsv_info, and the enum dma_event_q.
> Those can go to include/linux/platform_data, but the rest should not.

Ok, but is it ok to keep the actual private EDMA API portion in
arch/arm/include/asm/mach/? It's not a problem to move the internal
portions to a local include and that pdata to the appropriate place.
We still need a place independent of mach-davinci and mach-omap2 to
keep that portion of the include. I suppose it could be put in with
the dmaengine wrapper's include/linux/edma.h but I hate to clutter
that up when the private API will go away later.

-Matt

------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
