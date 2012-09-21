From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 10/13] spi: omap2-mcspi: dma_request_slave_channel()
 support for DT platforms
Date: Fri, 21 Sep 2012 14:37:29 -0400
Message-ID: <20120921183729.GI16522@beef>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-11-git-send-email-mporter@ti.com>
 <20120920220931.GJ28835@atomide.com>
 <201209210816.01473.arnd@arndb.de>
 <20120921154247.GZ28835@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120921154247.GZ28835-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 21, 2012 at 08:42:47AM -0700, Tony Lindgren wrote:
> * Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> [120921 02:19]:
> > On Thursday 20 September 2012, Tony Lindgren wrote:
> > > >  /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
> > > > @@ -798,14 +801,26 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
> > > >       dma_cap_zero(mask);
> > > >       dma_cap_set(DMA_SLAVE, mask);
> > > >       sig = mcspi_dma->dma_rx_sync_dev;
> > > > -     mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
> > > > +     if (spi->dev.of_node)
> > > > +             mcspi_dma->dma_rx =
> > > > +                     dma_request_slave_channel(&master->dev,
> > > > +                                               mcspi_dma->dma_rx_ch_name);
> > > > +     else
> > > > +             mcspi_dma->dma_rx =
> > > > +                     dma_request_channel(mask, omap_dma_filter_fn, &sig);
> > > >       if (!mcspi_dma->dma_rx) {
> > > >               dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
> > > >               return -EAGAIN;
> > > >       }
> > > >  
> > > 
> > > Hmm this does not look nice.. We should be able to somehow not to care about
> > > the configuration at the mcspi driver level.
> > 
> > I agree, but as far as I understand Vinod's plans, we would actually move
> > all drivers over to dma_request_slave_channel() when we have an interface
> > to register the lookup tables from platform code.
> > 
> > I think the above is ok for a transitional phase and we can remove the
> > fallback path when we have converted all platforms using this driver
> > to either use DT or move to the new style way of passing the channel
> > configuration.
> 
> Can't we come up with a version of dma_request_slave_channel that works
> both ways for now:
> 
> 	mcspi_dma->dma_rx =
> 		dma_request_slave_channel_compat(mask, omap_dma_filter_fn, &sig,
> 					&master->dev, mcspi_dma->dma_rx_ch_name);
> 	...			
> 
> Then it's just question of patching away two lines later on rather than
> having to add all this if else to all the drivers first, then patching
> it away again.

I think that something like that is workable with the implementation
simply checking for of_node to do the right thing.

-Matt
