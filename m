From: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v10 0/8] DMA Engine support for AM33XX
Date: Fri, 14 Jun 2013 21:29:04 -0500
Message-ID: <1371263352-9229-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This series is a repost of Matt Porter's EDMA patches for AM33XX EDMA support
with changes for few pending review comments on v9 series.

Currently this is required for AM33XX (Beaglebone or EVM) to access MMC
and be able mount to rootfs and boot till command prompt over MMC.
Unless there are other pending review comments, I hope this series can
finally make it into 3.11 merge window though that is probably wishful
thinking at this point considering below code movement patches [1] is
pending review and Ack.

Tested EDMA on AM1808 EVM and AM33XX Beaglebone with MMC.

Sekhar Nori has posted a GIT PULL [1] which has 2 patches this series depends on:
ARM: davinci: move private EDMA API to arm/common
ARM: dts: add AM33XX MMC support
[1] http://www.spinics.net/lists/arm-kernel/msg251503.html

Changes since v9:
    - Droped reserved and queue DT entries from Documentation
    for now from the original patch series.
    - Drop DT entries that are non-hardware-description
    - Split EDMA xbar support out of original EDMA DT parsing patch
    to keep it easier for review.
    - Rewrite shift and offset calculation xbar event mapping.
    - Setup default one-to-one mapping for queue_priority and queue_tc
    mapping as discussed in.
    - Split out xbar stuff to separate patch.

	Reference discussion:
   https://patchwork.kernel.org/patch/2226761/

Changes since v8:
	- Removed edma node interrupt-parent property, it is inherited

Changes since v7:
	- Dropped dmaengine compat() patch. It is upstream.
	- Submitted edma_alloc_slot() error checking bug fix separately,
	  now a dependency
	- Fixed bisect issues due to 3/10 hunks that went into 1/10
	- Fixed incorrect IS_ERRVALUE() use in 3/10

Changes since v6:
	- Converted edma_of_read_*() to wrappers around of_property_read_*()
	- Fixed wording on the omap-spi generic DMA properties
	- Added comment/check to clarify that the driver only supports
	  a single EDMA instance when booting from DT

Changes since v5:
	- Dropped mmc portion and moved it to a separate series
	- Incorporate corrected version of dma_request_slave_channel_compat()
	- Fix #defines and enablement of TI_PRIV_EDMA option

Changes since v4:
	- Fixed debug section mismatch in private edma api [01/14]
	- Respun format-patch to catch the platform_data/edma.h rename [01/14]
	- Removed address/size-cells from the EDMA binding [05/14]

Changes since v3:
	- Rebased on 3.8-rc3
	- No longer an RFC
	- Fixed bugs in DT/pdata parsing reported by Vaibhav Bedia
	- Restored all the Davinci pdata to const
	- Removed max_segs hack in favor of using dma_get_channel_caps()
	- Fixed extra parens, __raw_* accessors and, ioremap error checks
	  in xbar handling
	- Removed excess license info in platform_data/edma.h
	- Removed unneeded reserved channels data for AM33xx
	- Removed test-specific pinmuxing from dts files
	- Adjusted mmc1 node to be disabled by default in the dtsi

Changes since v2:
	- Rebased on 3.7-rc1
	- Fixed bug in DT/pdata parsing first found by Gururaja
	  that turned out to be masked by some toolchains
	- Dropped unused mach-omap2/devices.c hsmmc patch
	- Added AM33XX crossbar DMA event mux support
	- Added am335x-evm support

Changes since v1:
	- Rebased on top of mainline from 12250d8
	- Dropped the feature removal schedule patch
	- Implemented dma_request_slave_channel_compat() and
	  converted the mmc and spi drivers to use it
	- Dropped unneeded #address-cells and #size-cells from
	  EDMA DT support
	- Moved private EDMA header to linux/platform_data/ and
	  removed some unneeded definitions
	- Fixed parsing of optional properties

This series adds DMA Engine support for AM33xx, which uses
an EDMA DMAC. The EDMA DMAC has been previously supported by only
a private API implementation (much like the situation with OMAP
DMA) found on the DaVinci family of SoCs.

The series applies on top of 3.10-rc4.

The approach taken is similar to how OMAP DMA is being converted to
DMA Engine support. With the functional EDMA private API already
existing in mach-davinci/dma.c, we first move that to an ARM common
area so it can be shared. Adding DT and runtime PM support to the
private EDMA API implementation allows it to run on AM33xx. AM33xx
*only* boots using DT so the upstream generic DT DMA helpers are
leveraged to register EDMA DMAC with the of_dma framework. SPI (and
MMC in a separate series) are supported using the upstream
dma_request_slave_channel_compat() dmaengine call that allows
compatibility with !DT platforms.

With this series both BeagleBone and the AM335x EVM have working
SPI DMA support (and MMC support with the separate MMC series).

This is tested on BeagleBone with a SPI framebuffer driver and MMC
rootfs. A trivial gpio DMA event misc driver was used to test the
crossbar DMA event support. It is also tested on the AM335x EVM
with the onboard SPI flash and MMC rootfs. Note that MMC can only
be tested with a separate MMC dmaengine/DT series applied.

Regression testing was done on AM180x-EVM (which also makes use
of the EDMA dmaengine driver and the EDMA private API) using SD,
SPI flash, and the onboard audio supported by the ASoC Davinci
driver. Regression testing was also done on a BeagleBoard xM
booting from the legacy board file using MMC rootfs.

Matt Porter (8):
  ARM: edma: Add AM33XX support to the private EDMA API
  ARM: edma: Add AM33XX EDMA crossbar event mux support
  ARM: dts: add AM33XX EDMA support
  dmaengine: edma: enable build for AM33XX
  dmaengine: edma: Add TI EDMA device tree binding
  spi: omap2-mcspi: add generic DMA request support to the DT binding
  spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
  ARM: dts: add AM33XX SPI DMA support

 Documentation/devicetree/bindings/dma/ti-edma.txt  |   26 ++
 Documentation/devicetree/bindings/spi/omap-spi.txt |   27 ++-
 arch/arm/boot/dts/am33xx.dtsi                      |   22 ++
 arch/arm/common/edma.c                             |  249 +++++++++++++++++++-
 arch/arm/mach-omap2/Kconfig                        |    1 +
 drivers/dma/Kconfig                                |    2 +-
 drivers/spi/spi-omap2-mcspi.c                      |   64 +++--
 include/linux/platform_data/edma.h                 |    5 +-
 8 files changed, 360 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt

-- 
1.7.9.5


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
