From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [RFC PATCH v3 00/16] DMA Engine support for AM33XX
Date: Mon, 5 Nov 2012 07:19:33 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAC0633@DBDE01.ent.ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1350566815-409-1-git-send-email-mporter@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Porter, Matt" <mporter@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>, "Cousson,
 Benoit" <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux Documentation List <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vinod.koul@intel.com>, Rob Landley <rob@landley.net>, Dan Williams <djbw@fb.com>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infrade>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 18, 2012 at 18:56:39, Porter, Matt wrote:

...snip...
...snip...
...snip...

> 
> This series adds DMA Engine support for AM33xx, which uses
> an EDMA DMAC. The EDMA DMAC has been previously supported by only
> a private API implementation (much like the situation with OMAP
> DMA) found on the DaVinci family of SoCs.
> 
> The series applies on top of 3.7-rc1 and the following patches:
> 
> 	- GPMC fails to reserve memory fix:
> 	  http://www.spinics.net/lists/linux-omap/msg79675.html
> 	- TPS65910 regulator fix:
> 	  https://patchwork.kernel.org/patch/1593651/
> 	- dmaengine DT support from Vinod's dmaengine_dt branch in
> 	  git://git.infradead.org/users/vkoul/slave-dma.git since
> 	  027478851791df751176398be02a3b1c5f6aa824
> 
> The approach taken is similar to how OMAP DMA is being converted to
> DMA Engine support. With the functional EDMA private API already
> existing in mach-davinci/dma.c, we first move that to an ARM common
> area so it can be shared. Adding DT and runtime PM support to the
> private EDMA API implementation allows it to run on AM33xx. AM33xx
> *only* boots using DT so we leverage Jon's generic DT DMA helpers to
> register EDMA DMAC with the of_dma framework and then add support
> for calling the dma_request_slave_channel() API to both the mmc
> and spi drivers.
> 
> With this series both BeagleBone and the AM335x EVM have working
> MMC and SPI support.
> 
> This is tested on BeagleBone with a SPI framebuffer driver and MMC
> rootfs. A trivial gpio DMA event misc driver was used to test the
> crossbar DMA event support. It is also tested on the AM335x EVM
> with the onboard SPI flash and MMC rootfs. The branch at
> https://github.com/ohporter/linux/tree/edma-dmaengine-v3 has the
> complete series, dependencies, and some test drivers/defconfigs.
> 
> Regression testing was done on AM180x-EVM (which also makes use
> of the EDMA dmaengine driver and the EDMA private API) using SD,
> SPI flash, and the onboard audio supported by the ASoC Davinci
> driver.

Since you have tested MMC, and probably will be adding Audio support
for AM335x as well, I believe you will also be adding Pin-mux support
for both the modules.

Can you share your plan to release the next version? 
I have few patches pending for AM335x Audio (DT related). 

Thanks in advance

Regards
Gururaja

> 
> After this series, the plan is to convert the last in-tree user
> of the private EDMA API (davinci-pcm/mcasp) and then eliminate
> the private EDMA API by folding its functionality into
> drivers/dma/edma.c.
> 
> Matt Porter (16):
>   dmaengine: edma: fix slave config dependency on direction
>   ARM: davinci: move private EDMA API to arm/common
>   ARM: edma: remove unused transfer controller handlers
>   ARM: edma: add DT and runtime PM support for AM33XX
>   ARM: edma: add AM33XX crossbar event support
>   dmaengine: edma: enable build for AM33XX
>   dmaengine: edma: Add TI EDMA device tree binding
>   ARM: dts: add AM33XX EDMA support
>   dmaengine: add dma_request_slave_channel_compat()
>   mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()
>   mmc: omap_hsmmc: limit max_segs with the EDMA DMAC
>   mmc: omap_hsmmc: add generic DMA request support to the DT binding
>   ARM: dts: add AM33XX MMC support
>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>   ARM: dts: add AM33XX SPI support
> 
