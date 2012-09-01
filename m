From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
Date: Sat, 1 Sep 2012 09:14:42 -0400
Message-ID: <20120901131442.GE27758@beef>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
	<1345684176-21472-4-git-send-email-mporter@ti.com>
	<503F75C0.1050507@ti.com> <20120830144307.GA26737@beef>
	<5040E00A.3080600@ti.com> <1346430709.15463.15.camel@vkoul-mobl4>
	<5040E6C7.6030106@ti.com> <1346432577.15463.16.camel@vkoul-mobl4>
	<1346461349.2806.4.camel@vkoul-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1346461349.2806.4.camel@vkoul-mobl4>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vinod Koul <vkoul-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Sep 01, 2012 at 06:32:29AM +0530, Vinod Koul wrote:
> On Fri, 2012-08-31 at 22:32 +0530, Vinod Koul wrote:
> > On Fri, 2012-08-31 at 22:01 +0530, Sekhar Nori wrote:
> > > >> Yes, this was the problem. Since the SPI driver now depends on
> > > >> CONFIG_TI_EDMA for basic operation may be select CONFIG_TI_EDMA in
> > > >> Kconfig if SPI is enabled? That should do until the fallback to PIO
> > > is
> > > >> implemented.
> > > > Then this should be enabled for SPI. Care to send a patch
> > > 
> > > By 'this' you mean the Kconfig select? Then there should be no need of
> > > a
> > > new patch for this. It can be part of this patch itself, no? 
> > Either way is okay for me.
> And am in good mood :)

I am as well...thanks for taking care of the patch to address the Kconfig
issue and applying. It's nice to return from holiday and not have to do
anything with this series. :)

-Matt

> Applied all with this as well
> 
> >From b5f14330590118e6a0659255476c0f24ab681e05 Mon Sep 17 00:00:00 2001
> From: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Date: Sat, 1 Sep 2012 06:29:22 +0530
> Subject: [PATCH] spi: davici - make davinci select edma
> 
> Reported-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/spi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 5f84b55..b9fb9a1 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -134,6 +134,7 @@ config SPI_DAVINCI
>  	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI
> controller"
>  	depends on ARCH_DAVINCI
>  	select SPI_BITBANG
> +	select TI_EDMA
>  	help
>  	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.
>  
> -- 
> 1.7.9.5
> 
> 
> 
> -- 
> ~Vinod Koul
> Intel Corp.
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
