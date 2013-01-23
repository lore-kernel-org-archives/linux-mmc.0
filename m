From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 00/14] DMA Engine support for AM33XX
Date: Wed, 23 Jan 2013 15:49:18 -0500
Message-ID: <20130123204917.GA5256@beef>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
	<50FFC48B.80902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50FFC48B.80902-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 23, 2013 at 04:37:55PM +0530, Santosh Shilimkar wrote:
> Matt,
> 
> On Wednesday 16 January 2013 02:02 AM, Matt Porter wrote:
> 
> [..]
> 
> >This series adds DMA Engine support for AM33xx, which uses
> >an EDMA DMAC. The EDMA DMAC has been previously supported by only
> >a private API implementation (much like the situation with OMAP
> >DMA) found on the DaVinci family of SoCs.
> >
> >The series applies on top of 3.8-rc3 and the following patches:
> >
> >	- TPS65910 REGMAP_IRQ build fix:
> >	  https://patchwork.kernel.org/patch/1857701/
> >	- dmaengine DT support from Vinod's dmaengine_dt branch in
> >	  git://git.infradead.org/users/vkoul/slave-dma.git since
> >	  027478851791df751176398be02a3b1c5f6aa824
> >	- edma dmaengine driver fix:
> >	  https://patchwork.kernel.org/patch/1961521/
> >	- dmaengine dma_get_channel_caps v2:
> >	  https://patchwork.kernel.org/patch/1961601/
> >	- dmaengine edma driver channel caps support v2:
> >	  https://patchwork.kernel.org/patch/1961591/
> >
> >The approach taken is similar to how OMAP DMA is being converted to
> >DMA Engine support. With the functional EDMA private API already
> >existing in mach-davinci/dma.c, we first move that to an ARM common
> >area so it can be shared. Adding DT and runtime PM support to the
> >private EDMA API implementation allows it to run on AM33xx. AM33xx
> >*only* boots using DT so we leverage Jon's generic DT DMA helpers to
> >register EDMA DMAC with the of_dma framework and then add support
> >for calling the dma_request_slave_channel() API to both the mmc
> >and spi drivers.
> >
> >With this series both BeagleBone and the AM335x EVM have working
> >MMC and SPI support.
> >
> >This is tested on BeagleBone with a SPI framebuffer driver and MMC
> >rootfs. A trivial gpio DMA event misc driver was used to test the
> >crossbar DMA event support. It is also tested on the AM335x EVM
> >with the onboard SPI flash and MMC rootfs. The branch at
> >https://github.com/ohporter/linux/tree/edma-dmaengine-am33xx-v4
> >has the complete series, dependencies, and some test
> >drivers/defconfigs.
> >
> >Regression testing was done on AM180x-EVM (which also makes use
> >of the EDMA dmaengine driver and the EDMA private API) using SD,
> >SPI flash, and the onboard audio supported by the ASoC Davinci
> >driver. Regression testing was also done on a BeagleBoard xM
> >booting from the legacy board file using MMC rootfs.
> >
> >Matt Porter (14):
> >   ARM: davinci: move private EDMA API to arm/common
> >   ARM: edma: remove unused transfer controller handlers
> >   ARM: edma: add AM33XX support to the private EDMA API
> >   dmaengine: edma: enable build for AM33XX
> >   dmaengine: edma: Add TI EDMA device tree binding
> >   ARM: dts: add AM33XX EDMA support
> >   dmaengine: add dma_request_slave_channel_compat()
> >   mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()
> >   mmc: omap_hsmmc: set max_segs based on dma engine limitations
> >   mmc: omap_hsmmc: add generic DMA request support to the DT binding
> >   ARM: dts: add AM33XX MMC support
> >   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
> >   spi: omap2-mcspi: add generic DMA request support to the DT binding
> >   ARM: dts: add AM33XX SPI DMA support
> >
> While going through the series and testing it out, I observed an issue
> with MMC driver. You need patch in the end of the email to avoid the
> issue. Same is attached in case mailer damages it. Can you please
> add it with your series if you agree ?

Yes, by inspection this makes sense. As you noticed, we've been relying
on the fact that DMA resources still don't come from DT, we only use our
DT data in conjunction with the DMA OF helpers to do channel filtering.
I was figuring we would address that separately later, but I see how
even omap4 has this issue with DMA resources named with "tx1", for
example. A good followup once this series is taken will be to only
use hwmod resources on a !populated-dt platform like we do for other
resources now. Baby steps. :)

Thanks for the catch, I'll add this in with your tested line as well for
the series. 

-Matt

> 
> Overall the series looks good to my eyes.
> Acked-tested-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> 
> Regards,
> Santosh
> 
> From 2dcc90b7a4b2dcdb52ddd052ca7f3e88a78e83e4 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Date: Wed, 23 Jan 2013 16:04:32 +0530
> Subject: [PATCH] mmc: omap_hsmmc: Skip platform_get_resource_byname() for dt
>  case
> 
> MMC driver probe will abort for DT case because of failed
> platform_get_resource_byname() lookup. Fix it by skipping resource
> byname lookup for device tree build.
> 
> Issue is hidden because hwmod popullates the IO resources which
> helps to succeed platform_get_resource_byname() and probe.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index f74bd69..d4655e7 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1897,21 +1897,23 @@ static int omap_hsmmc_probe(struct
> platform_device *pdev)
> 
>  	omap_hsmmc_conf_bus_power(host);
> 
> -	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -	if (!res) {
> -		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> -	}
> -	tx_req = res->start;
> +	if (!pdev->dev.of_node) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +			ret = -ENXIO;
> +			goto err_irq;
> +		}
> +		tx_req = res->start;
> 
> -	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -	if (!res) {
> -		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +			ret = -ENXIO;
> +			goto err_irq;
> +		}
> +		rx_req = res->start;
>  	}
> -	rx_req = res->start;
> 
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
> -- 
> 1.7.9.5
> 
> 
> 
> 

> >From 2dcc90b7a4b2dcdb52ddd052ca7f3e88a78e83e4 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Date: Wed, 23 Jan 2013 16:04:32 +0530
> Subject: [PATCH] mmc: omap_hsmmc: Skip platform_get_resource_byname() for dt
>  case
> 
> MMC driver probe will abort for DT case because of failed
> platform_get_resource_byname() lookup. Fix it by skipping resource
> byname lookup for device tree build.
> 
> Issue is hidden because hwmod popullates the IO resources which
> helps to succeed platform_get_resource_byname() and probe.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index f74bd69..d4655e7 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1897,21 +1897,23 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>  
>  	omap_hsmmc_conf_bus_power(host);
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -	if (!res) {
> -		dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> -	}
> -	tx_req = res->start;
> +	if (!pdev->dev.of_node) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +			ret = -ENXIO;
> +			goto err_irq;
> +		}
> +		tx_req = res->start;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -	if (!res) {
> -		dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> -		ret = -ENXIO;
> -		goto err_irq;
> +		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +			ret = -ENXIO;
> +			goto err_irq;
> +		}
> +		rx_req = res->start;
>  	}
> -	rx_req = res->start;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
> -- 
> 1.7.9.5
> 

> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
