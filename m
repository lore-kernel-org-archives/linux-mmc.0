From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v12 00/11] DMA Engine support for AM33XX
Date: Mon, 24 Jun 2013 03:19:04 -0700
Message-ID: <20130624101903.GV5523@atomide.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55604 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab3FXKTL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jun 2013 06:19:11 -0400
Content-Disposition: inline
In-Reply-To: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joel A Fernandes <joelagnel@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Andrew Morton <akpm@linux-foundation.org>, Jason Kridner <jkridner@beagleboard.org>, Koen Kooi <koen@beagleboard.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>Linux SPI Devel List <s>

Hi,

For merging this series, I suggest the following sets:

* Joel A Fernandes <joelagnel@ti.com> [130620 14:13]:
> 
> Joel A Fernandes (3):
>   edma: config: Enable config options for EDMA
>   da8xx: config: Enable MMC and FS options
>   ARM: davinci: Fix compiler warnings in devices-da8xx
>
> Matt Porter (8):
>   dmaengine: edma: Add TI EDMA device tree binding
>   ARM: edma: Add DT and runtime PM support to the private EDMA API
>   ARM: edma: Add EDMA crossbar event mux support
>   dmaengine: edma: enable build for AM33XX

Sekhar should queue the above patches, I've acked the
mach-omap2/Kconfig change.

>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()


The spi changes should get merged via the driver list.

>   ARM: dts: add AM33XX EDMA support
>   ARM: dts: add AM33XX SPI DMA support

Benoit should queue the .dts changes.
 
>  Documentation/devicetree/bindings/dma/ti-edma.txt  |   34 +++
>  Documentation/devicetree/bindings/spi/omap-spi.txt |   27 ++-
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/am33xx.dtsi                      |   22 ++
>  arch/arm/common/edma.c                             |  242 ++++++++++++++++++--
>  arch/arm/configs/da8xx_omapl_defconfig             |    3 +
>  arch/arm/mach-davinci/devices-da8xx.c              |    8 +-
>  arch/arm/mach-omap2/Kconfig                        |    2 +
>  drivers/dma/Kconfig                                |    4 +-
>  drivers/spi/spi-omap2-mcspi.c                      |   64 ++++--
>  include/linux/platform_data/edma.h                 |    5 +-
>  11 files changed, 369 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt

Regards,

Tony
