From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v4.21
Date: Thu, 27 Dec 2018 15:31:52 +0100
Message-ID: <20181227143152.11176-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with MMC updates for v4.21. Details about the highlights are as
usual found in the signed tag. Please pull this in!

This time, the PR contains changes crossing subsystems/archs/platforms, which
is mainly because of a bigger modernization of moving from legacy GPIO to GPIO
descriptors for MMC (by Linus Walleij). Additionally, again, I am funneling
changes to drivers/misc/cardreader/* and drivers/memstick/*, through my MMC
tree, mostly due to that we lack a maintainer for these. Perhaps, I should
simply volunteer and make that the formal process, let's see.

Happy holidays!

Kind regards
Ulf Hansson


The following changes since commit e3ae3401aa19432ee4943eb0bbc2ec704d07d793:

  mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl (2018-12-17 08:59:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.21

for you to fetch changes up to 5215b2e952f3f94d74cac1a59494eb8ac647e216:

  mmc: mediatek: Add MMC_CAP_SDIO_IRQ support (2018-12-19 10:16:15 +0100)

----------------------------------------------------------------
MMC core:
 - Cleanup BKOPS support
 - Introduce MMC_CAP_SYNC_RUNTIME_PM
 - slot-gpio: Delete legacy slot GPIO handling

MMC host:
 - alcor: Add new mmc host driver for Alcor Micro PCI based cardreader
 - bcm2835: Several improvements to better recover from errors
 - jz4740: Rework and fixup pre|post_req support
 - mediatek: Add support for SDIO IRQs
 - meson-gx: Improve clock phase management
 - meson-gx: Stop descriptor on errors
 - mmci: Complete the sbc error path by sending a stop command
 - renesas_sdhi/tmio: Fixup reset/resume operations
 - renesas_sdhi: Add support for r8a774c0 and R7S9210
 - renesas_sdhi: Whitelist R8A77990 SDHI
 - renesas_sdhi: Fixup eMMC HS400 compatibility issues for H3 and M3-W
 - rtsx_usb_sdmmc: Re-work card detection/removal support
 - rtsx_usb_sdmmc: Re-work runtime PM support
 - sdhci: Fix timeout loops for some variant drivers
 - sdhci: Improve support for error handling due to failing commands
 - sdhci-acpi/pci: Disable LED control for Intel BYT-based controllers
 - sdhci_am654: Add new SDHCI variant driver to support TI's AM654 SOCs
 - sdhci-of-esdhc: Add support for eMMC HS400 mode
 - sdhci-omap: Fixup reset support
 - sdhci-omap: Workaround errata regarding SDR104/HS200 tuning failures
 - sdhci-msm: Fixup sporadic write transfers issues for SDR104/HS200
 - sdhci-msm: Fixup dynamical clock gating issues
 - various: Complete converting all hosts into using slot GPIO descriptors

Other:
 - Move GPIO mmc platform data for mips/sh/arm to GPIO descriptors
 - Add new Alcor Micro cardreader PCI driver
 - Support runtime power management for memstick rtsx_usb_ms driver
 - Use USB remote wakeups for card detection for rtsx_usb misc driver

----------------------------------------------------------------
A.s. Dong (1):
      dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp compatible string

Adrian Hunter (10):
      mmc: sdhci: Fix data command CRC error handling
      mmc: sdhci: Rename SDHCI_ACMD12_ERR and SDHCI_INT_ACMD12ERR
      mmc: sdhci: Handle auto-command errors
      mmc: sdhci-pci: Add max-frequency device property for Intel controllers
      mmc: sdhci-of-esdhc: Fix timeout checks
      mmc: sdhci-omap: Fix timeout checks
      mmc: sdhci-xenon: Fix timeout checks
      mmc: sdhci: Add quirk to disable LED control
      mmc: sdhci-pci: Disable LED control for Intel BYT-based controllers
      mmc: sdhci-acpi: Disable LED control for Intel BYT-based controllers

Arnd Bergmann (1):
      mmc: sdhci-msm: avoid unused function warning

Biju Das (1):
      mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0

Chris Brandt (2):
      mmc: renesas_sdhi_internal_dmac: Add R7S9210 support
      dt-bindings: mmc: tmio_mmc: Document Renesas R7S9210

Chunyan Zhang (1):
      mmc: sdhci: Convert sdhci_allocate_bounce_buffer() to return void

Colin Ian King (2):
      mmc: sdhci-of-esdhc: fix spelling mistake "upsupported" -> "unsupported"
      misc: alcor_pci: fix spelling mistake "invailid" -> "invalid"

Evan Green (1):
      dt-bindings: mmc: sdhci-msm: Clarify register requirements

Ezequiel Garcia (1):
      mmc: jz4740: rework pre_req/post_req implementation

Fabrizio Castro (1):
      dt-bindings: mmc: renesas_sdhi: Add r8a774c0 support

Faiz Abbas (7):
      mmc: sdhci-omap: Add platform specific reset callback
      mmc: sdhci-omap: Remove redundant structure assignments
      dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs
      dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for AM65
      mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
      dt-bindings: sdhci-omap: Add note for cpu_thermal
      mmc: sdhci-omap: Workaround errata regarding SDR104/HS200 tuning failures (i929)

Jerome Brunet (4):
      mmc: meson-gx: make sure the descriptor is stopped on errors
      mmc: meson-gx: remove useless lock
      mmc: meson-gx: align default phase on soc vendor tree
      mmc: meson-gx: add signal resampling

Jonas Danielsson (1):
      mmc: atmel-mci: do not assume idle after atmci_request_end

Kai-Heng Feng (5):
      memstick: rtsx_usb_ms: Add missing pm_runtime_disable() in probe function
      misc: rtsx_usb: Use USB remote wakeup signaling for card insertion detection
      memstick: Prevent memstick host from getting runtime suspended during card detection
      memstick: rtsx_usb_ms: Use ms_dev() helper
      memstick: rtsx_usb_ms: Support runtime power management

Liming Sun (1):
      mmc: dw_mmc-bluefield: simplify the probe() function

Linus Walleij (16):
      mmc: slot-gpio: Allocate GPIO labels dynamically
      mmc: jz4740: Get CD/WP GPIOs from descriptors
      mmc: jz4740: Use GPIO descriptor for power
      mmc: sdhci: imx: Use the slot GPIO descriptor
      mmc: spi: Convert to use GPIO descriptors
      mmc: host: tmio: Use GPIO descriptors
      mmc: s3cmci: Use the slot GPIO descriptor
      gpio: name PCA953x gpio chips after device name
      ARM: pxa: Add gpio descriptor lookup tables for MMC CD/WP
      ARM: pxa: Add GPIO descriptors for Palm27x
      mmc: pxamci: Support getting GPIO descs for RO and WP
      ARM: pxa: Delete platform data for CD/WP
      mmc: pxamci: Delete platform data handling of CD and WP
      mmc: pxa: Use GPIO descriptor for power
      mmc: slot-gpio: Delete legacy GPIO handling
      sh: ecovec24: Fix an ifdef

Loic Poulain (1):
      mmc: sdhci-msm: Disable CDR function on TX

Ludovic Barre (2):
      mmc: mmci: send stop command if sbc error issue
      mmc: mmci: add variant property to set command stop bit

Marek Vasut (1):
      mmc: renesas_sdhi: Whitelist R8A77990 SDHI

Masaharu Hayakawa (1):
      mmc: tmio: delete wait in tuning process

Masahiro Yamada (1):
      mmc: sdhci-cadence: include <linux/bits.h> instead of <linux/bitops.h>

Michal Suchanek (1):
      mmc: bcm2835: reset host on timeout

Nicholas Mc Guire (1):
      mmc: meson-mx-sdio: check devm_kasprintf for failure

Niklas Söderlund (7):
      mmc: renesas_sdhi: remove workaround for HS400 clock
      mmc: tmio: enable module clock before resetting when resuming
      mmc: tmio: fix reset operation
      mmc: renesas_sdhi: add initial setting of interrupt mask register
      mmc: renesas_sdhi: handle 4tap hs400 mode quirk based on SoC revision
      mmc: renesas_sdhi: align compatibility properties for H3 and M3-W
      mmc: renesas_sdhi: disable HS400 on H3 ES1.x and M3-W ES1.[012]

Oleksij Rempel (2):
      misc: cardreader: add new Alcor Micro Cardreader PCI driver
      mmc: add new Alcor Micro Cardreader SD/MMC driver

Phil Elwell (1):
      mmc: bcm2835: Recover from MMC_SEND_EXT_CSD

Stefan Wahren (6):
      mmc: bcm2835: Switch to SPDX identifier
      mmc: bcm2835: Release DMA channel on driver unload
      mmc: bcm2835: Avoid possible races on data requests
      mmc: bcm2835: Terminate timeout work synchronously
      mmc: bcm2835: Refactor dma_map_sg handling
      mmc: bcm2835: Properly handle dmaengine_prep_slave_sg

Ulf Hansson (7):
      mmc: core: Introduce MMC_CAP_SYNC_RUNTIME_PM
      mmc: rtsx_usb_sdmmc: Don't runtime resume the device while changing led
      mmc: rtsx_usb_sdmmc: Re-work runtime PM support
      mmc: rtsx_usb_sdmmc: Re-work card detection/removal support
      Merge branch 'fixes' into next
      mmc: core: Drop redundant check in mmc_send_hpi_cmd()
      mmc: core: Cleanup BKOPS support

Veerabhadrarao Badiganti (2):
      dt-bindings: mmc: sdhci-msm: Add SoC-specific compatible strings
      mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically

Wolfram Sang (3):
      mmc: core: remove obsolete mmc_set_blockcount() function
      mmc: tmio: introduce mask for 'always 1' bits
      mmc: document 'Reliable Write' bit in uapi header

Yangbo Lu (4):
      mmc: sdhci-of-esdhc: add hs400 mode support
      mmc: sdhci-of-esdhc: add erratum A011334 support
      mmc: sdhci-of-esdhc: temporary fixup for eMMC HS400 issue
      mmc: sdhci-of-esdhc: workaround for unreliable pulse width detection

Yangtao Li (1):
      mmc: convert to DEFINE_SHOW_ATTRIBUTE

Yinbo Zhu (1):
      mmc: core: Add ->hs400_prepare_ddr() callback

YueHaibing (2):
      mmc: jz4740: Use PTR_ERR_OR_ZERO in jz4740_mmc_request_gpios()
      mmc: alcor: remove set but not used variables 'len, clock_out'

jjian zhou (1):
      mmc: mediatek: Add MMC_CAP_SDIO_IRQ support

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |    4 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
 .../devicetree/bindings/mmc/sdhci-am654.txt        |   36 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   23 +-
 .../devicetree/bindings/mmc/sdhci-omap.txt         |    2 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |    4 +-
 arch/arm/mach-ep93xx/simone.c                      |   14 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   17 +-
 arch/arm/mach-imx/mach-pcm043.c                    |   17 +-
 arch/arm/mach-pxa/balloon3.c                       |    3 -
 arch/arm/mach-pxa/cm-x270.c                        |   18 +-
 arch/arm/mach-pxa/cm-x300.c                        |   18 +-
 arch/arm/mach-pxa/colibri-evalboard.c              |   40 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c          |   19 +-
 arch/arm/mach-pxa/corgi.c                          |   20 +-
 arch/arm/mach-pxa/csb726.c                         |   19 +-
 arch/arm/mach-pxa/em-x270.c                        |   34 +-
 arch/arm/mach-pxa/gumstix.c                        |    3 -
 arch/arm/mach-pxa/idp.c                            |    3 -
 arch/arm/mach-pxa/littleton.c                      |   18 +-
 arch/arm/mach-pxa/lubbock.c                        |    3 -
 arch/arm/mach-pxa/magician.c                       |   26 +-
 arch/arm/mach-pxa/mainstone.c                      |    3 -
 arch/arm/mach-pxa/mioa701.c                        |   21 +-
 arch/arm/mach-pxa/mxm8x10.c                        |   19 +-
 arch/arm/mach-pxa/palm27x.c                        |   10 +-
 arch/arm/mach-pxa/palm27x.h                        |    8 +-
 arch/arm/mach-pxa/palmld.c                         |   16 +-
 arch/arm/mach-pxa/palmt5.c                         |   16 +-
 arch/arm/mach-pxa/palmtc.c                         |   19 +-
 arch/arm/mach-pxa/palmte2.c                        |   18 +-
 arch/arm/mach-pxa/palmtreo.c                       |   31 +-
 arch/arm/mach-pxa/palmtx.c                         |   16 +-
 arch/arm/mach-pxa/palmz72.c                        |   16 +-
 arch/arm/mach-pxa/pcm990-baseboard.c               |    3 -
 arch/arm/mach-pxa/poodle.c                         |   15 +-
 arch/arm/mach-pxa/raumfeld.c                       |    3 -
 arch/arm/mach-pxa/spitz.c                          |   16 +-
 arch/arm/mach-pxa/stargate2.c                      |    3 -
 arch/arm/mach-pxa/tosa.c                           |   18 +-
 arch/arm/mach-pxa/trizeps4.c                       |    3 -
 arch/arm/mach-pxa/vpac270.c                        |   16 +-
 arch/arm/mach-pxa/z2.c                             |   14 +-
 arch/arm/mach-pxa/zeus.c                           |   15 +-
 arch/arm/mach-pxa/zylonite.c                       |   57 +-
 arch/arm/mach-pxa/zylonite_pxa300.c                |    2 +
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   14 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   15 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   15 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |   15 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   15 +-
 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h     |    4 -
 arch/mips/jz4740/board-qi_lb60.c                   |   18 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   43 +-
 drivers/gpio/gpio-pca953x.c                        |    2 +-
 drivers/memstick/core/memstick.c                   |    3 +
 drivers/memstick/host/rtsx_usb_ms.c                |  170 +--
 drivers/misc/Makefile                              |    2 +-
 drivers/misc/cardreader/Kconfig                    |   11 +
 drivers/misc/cardreader/Makefile                   |    4 +-
 drivers/misc/cardreader/alcor_pci.c                |  371 +++++++
 drivers/misc/cardreader/rtsx_usb.c                 |    8 +
 drivers/mmc/core/block.c                           |    2 +-
 drivers/mmc/core/card.h                            |    6 +-
 drivers/mmc/core/core.c                            |   19 +-
 drivers/mmc/core/core.h                            |    2 -
 drivers/mmc/core/mmc.c                             |    9 +-
 drivers/mmc/core/mmc_ops.c                         |   93 +-
 drivers/mmc/core/mmc_ops.h                         |    3 +-
 drivers/mmc/core/mmc_test.c                        |   14 +-
 drivers/mmc/core/slot-gpio.c                       |   97 +-
 drivers/mmc/host/Kconfig                           |   28 +-
 drivers/mmc/host/Makefile                          |    2 +
 drivers/mmc/host/alcor.c                           | 1162 ++++++++++++++++++++
 drivers/mmc/host/atmel-mci.c                       |   34 +-
 drivers/mmc/host/bcm2835.c                         |   71 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |   11 +-
 drivers/mmc/host/jz4740_mmc.c                      |  202 ++--
 drivers/mmc/host/meson-gx-mmc.c                    |  100 +-
 drivers/mmc/host/meson-mx-sdio.c                   |    6 +
 drivers/mmc/host/mmc_spi.c                         |   27 +-
 drivers/mmc/host/mmci.c                            |   11 +-
 drivers/mmc/host/mmci.h                            |    2 +
 drivers/mmc/host/mtk-sd.c                          |   53 +-
 drivers/mmc/host/of_mmc_spi.c                      |   34 -
 drivers/mmc/host/omap_hsmmc.c                      |   14 +-
 drivers/mmc/host/pxamci.c                          |   68 +-
 drivers/mmc/host/renesas_sdhi_core.c               |   50 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   28 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   20 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   44 +-
 drivers/mmc/host/s3cmci.c                          |   59 +-
 drivers/mmc/host/sdhci-acpi.c                      |    7 +-
 drivers/mmc/host/sdhci-cadence.c                   |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   26 +-
 drivers/mmc/host/sdhci-esdhc.h                     |   24 +
 drivers/mmc/host/sdhci-msm.c                       |  126 ++-
 drivers/mmc/host/sdhci-of-arasan.c                 |   46 -
 drivers/mmc/host/sdhci-of-esdhc.c                  |  151 ++-
 drivers/mmc/host/sdhci-omap.c                      |  130 ++-
 drivers/mmc/host/sdhci-pci-core.c                  |   19 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |   10 +-
 drivers/mmc/host/sdhci-xenon.c                     |   10 +-
 drivers/mmc/host/sdhci.c                           |  106 +-
 drivers/mmc/host/sdhci.h                           |   13 +-
 drivers/mmc/host/sdhci_am654.c                     |  374 +++++++
 drivers/mmc/host/tmio_mmc.h                        |    6 +
 drivers/mmc/host/tmio_mmc_core.c                   |   41 +-
 include/linux/alcor_pci.h                          |  286 +++++
 include/linux/mfd/tmio.h                           |    9 +-
 include/linux/mmc/host.h                           |    5 +-
 include/linux/mmc/slot-gpio.h                      |    5 -
 include/linux/platform_data/mmc-esdhc-imx.h        |    4 -
 include/linux/platform_data/mmc-pxamci.h           |    4 -
 include/linux/platform_data/mmc-s3cmci.h           |    4 -
 include/linux/spi/mmc_spi.h                        |   15 -
 include/uapi/linux/mmc/ioctl.h                     |    5 +-
 117 files changed, 4012 insertions(+), 1097 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 drivers/misc/cardreader/alcor_pci.c
 create mode 100644 drivers/mmc/host/alcor.c
 create mode 100644 drivers/mmc/host/sdhci_am654.c
 create mode 100644 include/linux/alcor_pci.h
