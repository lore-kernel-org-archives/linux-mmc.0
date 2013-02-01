From: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 03/10] ARM: edma: add AM33XX support to the private
 EDMA API
Date: Fri, 1 Feb 2013 08:01:41 +0200
Message-ID: <1359698501.14894.74.camel@cumari.coelho.fi>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <201301300932.58732.arnd@arndb.de> <20130131183255.GI2244@beef>
 <6932828d68394f71ba6df8e6bf608635@DFLE72.ent.ti.com>
 <20130131214241.GJ2244@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130131214241.GJ2244@beef>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2013-01-31 at 16:42 -0500, Matt Porter wrote:
> On Thu, Jan 31, 2013 at 08:58:39PM +0000, Arnd Bergmann wrote:
> > On Thursday 31 January 2013, Matt Porter wrote:
> > > On Wed, Jan 30, 2013 at 09:32:58AM +0000, Arnd Bergmann wrote:
> > > > On Wednesday 30 January 2013, Matt Porter wrote:
> > > > > +               dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
> > > > > +               of_dma_controller_register(dev->of_node,
> > > > > +                                          of_dma_simple_xlate,
> > > > > +                                          &edma_filter_info);
> > > > > +       }
> > > > 
> > > > How do you actually deal with the problem mentioned by Padma, that
> > > > the filter function does not know which edma instance it is looking
> > > > at? If you assume that there can only be a single edma instance in
> > > > the system, that is probably a limitation that should be documented
> > > > somewhere, and ideally the probe() function should check for that.
> > > 
> > > I make an assumption of one edma instance in the system in the case of
> > > DT being populated. This is always true right now as the only SoC with
> > > two EDMA controllers in existence is Davinci DA850. Until recently,
> > > Davinci had no DT support. Given the steady work being done today on DT
> > > support for DA850, it'll probably be something needed in 3.10.
> > > 
> > > I will add a comment and check in probe() to capture this assumption
> > > and then plan to update separately to support DA850 booting from DT.
> > 
> > Ok, sounds good. Hopefully by then we will already have a nicer
> > way to write an xlate function that does not rely on a filter
> > function.
> 
> Yes, it would be nice to avoid what Padma had to do. I should have
> mentioned also that the second EDMA on DA850 has no DMA events of
> immediate use on it anyway. All the in-kernel users use events on the
> first controller, except for the second MMC instance. That's only used
> for a wl12xx module on the EVM and that driver has no DT support so it
> doesn't matter yet in the DT case. Because of this, DA850 can actually
> add EDMA DT support immediately (on top of this series) and add DMA
> support to the DT support already posted for the Davinci SPI and MMC
> client drivers.

I haven't followed this whole discussion in details, but please notice
that I'm aiming to get DT support for the WiLink modules (wlcore,
wl12xx...) for 3.10. ;)

--
Cheers,
Luca.
