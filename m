From: Russ Dill <russ.dill-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 00/16] DMA Engine support for AM33XX
Date: Fri, 26 Oct 2012 01:32:53 -0700
Message-ID: <CA+Bv8XZhrFR2krMS=psL96uaiVxnQ12s3ORN6F+yfXw40T1_uw@mail.gmail.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1350566815-409-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 18, 2012 at 6:26 AM, Matt Porter <mporter-l0cyMroinI0@public.gmane.org> wrote:
> Changes since v2:
>         - Rebased on 3.7-rc1
>         - Fixed bug in DT/pdata parsing first found by Gururaja
>           that turned out to be masked by some toolchains
>         - Dropped unused mach-omap2/devices.c hsmmc patch
>         - Added AM33XX crossbar DMA event mux support
>         - Added am335x-evm support
>
> Changes since v1:
>         - Rebased on top of mainline from 12250d8
>         - Dropped the feature removal schedule patch
>         - Implemented dma_request_slave_channel_compat() and
>           converted the mmc and spi drivers to use it
>         - Dropped unneeded #address-cells and #size-cells from
>           EDMA DT support
>         - Moved private EDMA header to linux/platform_data/ and
>           removed some unneeded definitions
>         - Fixed parsing of optional properties
>
> TODO:
>         - Add dmaengine support for per-channel caps so the
>           hack to set the maximum segments can be replaced with
>           a query to the dmaengine driver
>
> This series adds DMA Engine support for AM33xx, which uses
> an EDMA DMAC. The EDMA DMAC has been previously supported by only
> a private API implementation (much like the situation with OMAP
> DMA) found on the DaVinci family of SoCs.

This pretty far along and looks great.

Reviewed-by: Russ.Dill-l0cyMroinI0@public.gmane.org

> The series applies on top of 3.7-rc1 and the following patches:
>
>         - GPMC fails to reserve memory fix:
>           http://www.spinics.net/lists/linux-omap/msg79675.html
>         - TPS65910 regulator fix:
>           https://patchwork.kernel.org/patch/1593651/
>         - dmaengine DT support from Vinod's dmaengine_dt branch in
>           git://git.infradead.org/users/vkoul/slave-dma.git since
>           027478851791df751176398be02a3b1c5f6aa824
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
>  Documentation/devicetree/bindings/dma/ti-edma.txt  |   51 +
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   25 +-
>  Documentation/devicetree/bindings/spi/omap-spi.txt |   27 +-
>  arch/arm/Kconfig                                   |    1 +
>  arch/arm/boot/dts/am335x-bone.dts                  |   23 +
>  arch/arm/boot/dts/am335x-evm.dts                   |   15 +
>  arch/arm/boot/dts/am33xx.dtsi                      |  101 ++
>  arch/arm/common/Kconfig                            |    3 +
>  arch/arm/common/Makefile                           |    1 +
>  arch/arm/common/edma.c                             | 1841 ++++++++++++++++++++
>  arch/arm/mach-davinci/Makefile                     |    2 +-
>  arch/arm/mach-davinci/board-da830-evm.c            |    4 +-
>  arch/arm/mach-davinci/board-da850-evm.c            |    8 +-
>  arch/arm/mach-davinci/board-dm646x-evm.c           |    4 +-
>  arch/arm/mach-davinci/board-omapl138-hawk.c        |    8 +-
>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
>  arch/arm/mach-davinci/davinci.h                    |    2 +-
>  arch/arm/mach-davinci/devices-da8xx.c              |    8 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c          |    6 +-
>  arch/arm/mach-davinci/devices.c                    |    7 +-
>  arch/arm/mach-davinci/dm355.c                      |    6 +-
>  arch/arm/mach-davinci/dm365.c                      |    6 +-
>  arch/arm/mach-davinci/dm644x.c                     |    6 +-
>  arch/arm/mach-davinci/dm646x.c                     |    6 +-
>  arch/arm/mach-davinci/dma.c                        | 1588 -----------------
>  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
>  arch/arm/mach-davinci/include/mach/edma.h          |  267 ---
>  arch/arm/plat-omap/Kconfig                         |    1 +
>  drivers/dma/Kconfig                                |    2 +-
>  drivers/dma/edma.c                                 |   57 +-
>  drivers/mmc/host/davinci_mmc.c                     |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |   20 +-
>  drivers/spi/spi-omap2-mcspi.c                      |   65 +-
>  include/linux/dmaengine.h                          |   10 +
>  include/linux/mfd/davinci_voicecodec.h             |    3 +-
>  include/linux/platform_data/edma.h                 |  199 +++
>  include/linux/platform_data/spi-davinci.h          |    2 +-
>  sound/soc/davinci/davinci-evm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.c                    |    1 +
>  sound/soc/davinci/davinci-pcm.h                    |    2 +-
>  sound/soc/davinci/davinci-sffsdr.c                 |    6 +-
>  41 files changed, 2436 insertions(+), 1954 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
>  create mode 100644 arch/arm/common/edma.c
>  delete mode 100644 arch/arm/mach-davinci/dma.c
>  delete mode 100644 arch/arm/mach-davinci/include/mach/edma.h
>  create mode 100644 include/linux/platform_data/edma.h
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
