From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.10
Date: Mon, 12 Dec 2016 16:24:23 +0100
Message-ID: <CAPDyKFrU25smj26MUsZQwj00iC0w_yurgY-k6=aPgjfG-0SEqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR for MMC v4.10. Details about the highlights are as usual
found in the signed tag.

One note, you should expect a merge conflict when pulling in changes
with the block tree. The conflict is in drivers/mmc/card/block.c, also
reported by Stephen Rothwell, but I think it should be quite trivial
to resolve. Please, drop me an email if you encounter issues.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e5517c2a5a49ed5e99047008629f1cd60246ea0e:

  Linux 4.9-rc7 (2016-11-27 13:08:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.10

for you to fetch changes up to ff6af28faff53a7389230026b83e543385f7b21d:

  mmc: sdhci-cadence: add Cadence SD4HC support (2016-12-08 15:02:52 +0100)

----------------------------------------------------------------
It's been an busy period for mmc. Quite some changes in the mmc core, two new
mmc host drivers, some existing drivers being extended to support new IP
versions and lots of other updates.

MMC core:
 - Delete eMMC packed command support
 - Introduce mmc_abort_tuning() to enable eMMC tuning to fail gracefully
 - Introduce mmc_can_retune() to see if a host can be retuned
 - Re-work and improve the sequence when sending a CMD6 for mmc
 - Enable CDM13 polling when switching to HS and HS DDR mode for mmc
 - Relax checking for CMD6 errors after switch to HS200
 - Re-factoring the code dealing with the mmc block queue
 - Recognize whether the eMMC card supports CMDQ
 - Fix 4K native sector check
 - Don't power off the card when starting the host
 - Increase MMC_IOC_MAX_BYTES to support bigger firmware binaries
 - Improve error handling and drop meaningless BUG_ONs()
 - Lots of clean-ups and changes to improve the quality of the code

MMC host:
 - sdhci: Fix tuning sequence and clean-up the related code
 - sdhci: Add support to via DT override broken SDHCI cap register bits
 - sdhci-cadence: Add new driver for Cadence SD4HC SDHCI variant
 - sdhci-msm: Update clock management
 - sdhci-msm: Add support for eMMC HS400 mode
 - sdhci-msm: Deploy runtime/system PM support
 - sdhci-iproc: Extend driver support to newer IP versions
 - sdhci-pci: Add support for Intel GLK
 - sdhci-pci: Add support for Intel NI byt sdio
 - sdhci-acpi: Add support for 80860F14 UID 2 SDIO bus
 - sdhci: Lots of various small improvements and clean-ups
 - tmio: Add support for tuning
 - sh_mobile_sdhi: Add support for tuning
 - sh_mobile_sdhi: Extend driver to support SDHI IP on R7S72100 SoC
 - sh_mobile_sdhi: remove support for sh7372
 - davinci: Use mmc_of_parse() to enable generic mmc DT bindings
 - meson: Add new driver to support GX platforms
 - dw_mmc: Deploy generic runtime/system PM support
 - dw_mmc: Lots of various small improvements

As a part of the mmc changes this time, I have also pulled in an immutable
branch/tag (soc-device-match-tag1) hosted by Geert Uytterhoeven, to share the
implementation of the new soc_device_match() interface. This is needed by the
below mmc related changes:
 - mmc: sdhci-of-esdhc: Get correct IP version for T4240-R1.0-R2.0
 - soc: fsl: add GUTS driver for QorIQ platforms

----------------------------------------------------------------
Adrian Hunter (20):
      mmc: sdhci-pci: Add support for Intel GLK
      mmc: block: Restore line inadvertently removed with packed commands
      mmc: block: Fix 4K native sector check
      mmc: queue: Fix queue thread wake-up
      mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
      mmc: queue: Factor out mmc_queue_alloc_bounce_sgs()
      mmc: queue: Factor out mmc_queue_alloc_sgs()
      mmc: queue: Factor out mmc_queue_reqs_free_bufs()
      mmc: queue: Introduce queue depth and use it to allocate and free
      mmc: mmc: Add Command Queue definitions
      mmc: mmc: Relax checking for switch errors after HS200 switch
      Revert "mmc: sdhci: Reset cmd and data circuits after tuning failure"
      mmc: sdhci: Fix recovery from tuning timeout
      mmc: sdhci: Fix tuning reset after exhausting the maximum number of loops
      mmc: sdhci: Always allow tuning to fall back to fixed sampling
      mmc: mmc: Introduce mmc_abort_tuning()
      mmc: sdhci: Use mmc_abort_tuning()
      mmc: sdhci: Factor out tuning helper functions
      mmc: sdhci: Simplify tuning block size logic
      mmc: sdhci: Tidy tuning loop

Ai Kyuse (3):
      mmc: tmio: enhance illegal sequence handling
      mmc: tmio: Add hw reset support
      mmc: tmio: Add tuning support

Alexey Khoroshilov (1):
      mmc: wbsd: implement check for dma mapping error

Arnd Bergmann (1):
      base: soc: Introduce soc_device_match() interface

Chris Brandt (3):
      mmc: sh_mobile_sdhi: add ocr_mask option
      mmc: tmio-mmc: add support for 32bit data port
      mmc: sh_mobile_sdhi: Add r7s72100 support

Colin Ian King (1):
      mmc: dw_mmc: fix spelling mistake in dev_dbg message

Dan Carpenter (1):
      mmc: mmc_test: Uninitialized return value

Daniel Drake (1):
      mmc: sdhci-acpi: support 80860F14 UID 2 SDIO bus

David E. Box (1):
      mmc: sdhci-pci: Allow deferred probe for sd card detect gpio

Geert Uytterhoeven (3):

      base: soc: Early register bus when needed
      base: soc: Check for NULL SoC device attributes
      base: soc: Provide a dummy implementation of soc_device_match()

Jaehoon Chung (14):
      mmc: sdhci: put together into one condition checking
      mmc: dw_mmc: display the real register value on debugfs
      mmc: dw_mmc: fix the debug message for checking card's present
      mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
      mmc: dw_mmc: use the hold register when send stop command
      mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
      mmc: dw_mmc: use the cookie's enum values for post/pre_req()
      mmc: dw_mmc: remove the unnecessary mmc_data structure
      mmc: dw_mmc: The "clock-freq-min-max" property was deprecated
      Documentation: synopsys-dw-mshc: remove the unused properties
      mmc: dw_mmc: check the "present" variable before checking flags
      mmc: dw_mmc: add the debug message for polling and non-removable
      mmc: dw_mmc: display the clock message only one time when card is polling
      mmc: sdhci-s3c: add spin_unlock_irq() before calling clk_round_rate

Javier Martinez Canillas (2):
      mmc: mediatek: Fix module autoload
      mmc: sdhci-of-at91: Fix module autoload

Jeonghan Kim (1):
      mmc: block: Change MMC_IOC_MAX_BYTES

Joonyoung Shim (2):
      mmc: dw_mmc: exynos: fix to call suspend callback
      mmc: dw_mmc: add missing codes for runtime resume

Kevin Hilman (2):
      MMC: meson: initial support for GX platforms
      Documentation: DT: MMC: meson-gx: new bindings doc

Linus Walleij (10):
      mmc: mmci: clean up header defines
      mmc: mmci: refactor ST Micro busy detection
      mmc: block: make gen_err a bool variable
      mmc: block: convert ecc_err to a bool
      mmc: core: use enum mmc_blk_status properly
      mmc: block: use mmc_req_is_special()
      mmc: block: rename data to blkdata
      mmc: block: move packed command struct init
      mmc: delete is_first_req parameter from pre-request callback
      mmc: block: delete packed command support

Masahiro Yamada (4):
      mmc: sdhci: remove unneeded (void *) casts in sdhci_(pltfm_)priv()
      mmc: sdhci-of-at91: remove bogus MMC_SDHCI_IO_ACCESSORS select
      mmc: sdhci: export sdhci_execute_tuning()
      mmc: sdhci-cadence: add Cadence SD4HC support

Maxime Ripard (1):
      mmc: sunxi: Prevent against null dereference for vmmc

Pramod Gurav (1):
      mmc: sdhci-msm: Add pm_runtime and system PM support

Ritesh Harjani (10):
      mmc: sdhci-msm: Change poor style writel/readl of registers
      dt-bindings: sdhci-msm: Add xo value
      mmc: sdhci-msm: Add get_min_clock() and get_max_clock() callback
      mmc: sdhci-msm: Enable few quirks
      mmc: sdhci: Factor out sdhci_enable_clk
      mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
      mmc: sdhci-msm: Add clock changes for DDR mode.
      mmc: sdhci-msm: Save the calculated tuning phase
      mmc: sdhci-msm: Add calibration tuning for CDCLP533 circuit
      sdhci: sdhci-msm: update dll configuration

Scott Branden (2):
      mmc: sdhci-iproc: Add brcm, sdhci-iproc compat string in bindings document
      mmc: sdhci-iproc: support standard byte register accesses

Shawn Lin (17):
      mmc: dw_mmc: add runtime PM callback
      mmc: dw_mmc-rockchip: add runtime PM support
      mmc: core: expose the capability of gpio card detect
      mmc: dw_mmc: disable biu clk if possible
      mmc: dw_mmc-k3: deploy runtime PM facilities
      mmc: dw_mmc-exynos: deploy runtime PM facilities
      mmc: dw_mmc-pci: deploy runtime PM facilities
      mmc: dw_mmc-pltfm: deploy runtime PM facilities
      mmc: dw_mmc: remove system PM callback
      mmc: core: remove BUG_ONs from sdio
      mmc: debugfs: remove BUG_ON from mmc_ext_csd_open
      mmc: core: remove BUG_ONs from mmc
      mmc: core: remove BUG_ONs from sd
      mmc: core: remove BUG_ONs from core.c
      mmc: sdio_uart: remove meaningless BUG_ON
      mmc: queue: remove BUG_ON for bounce_sg
      mmc: mmc_test: remove BUG_ONs and deploy error handling

Simon Horman (5):
      mmc: core: Add helper to see if a host can be retuned
      mmc: tmio: document mandatory and optional callbacks
      mmc: sh_mobile_sdhi: Add tuning support
      mmc: sh_mobile_sdhi: remove support for sh7372
      mmc: sh_mmcif: Document r8a73a4, r8a7778 and sh73a0 DT bindings

Sudeep Holla (1):
      soc: fsl: fix section mismatch build warnings

Sylwester Nawrocki (1):
      mmc: s3cmci: Use DMA slave map rather than exported DMA filter

Ulf Hansson (14):
      mmc: rtsx_usb_sdmmc: Enable runtime PM autosuspend
      mmc: core: Make mmc_switch_status() available for mmc core
      mmc: core: Clarify code which deals with polling in __mmc_switch()
      mmc: core: Factor out code related to polling in __mmc_switch()
      mmc: core: Don't use ->card_busy() and CMD13 in combination when polling
      mmc: core: Don't power off the card when starting the host
      mmc: core: Retry instead of ignore at CRC errors when polling for busy
      mmc: core: Remove redundant __mmc_send_status()
      mmc: core: Rename ignore_crc to retry_crc_err to reflect its purpose
      mmc: core: Check SWITCH_ERROR bit from each CMD13 response when polling
      mmc: core: Enable __mmc_switch() to change bus speed timing for the host
      mmc: core: Allow CMD13 polling when switching to HS mode for mmc
      mmc: core: Update CMD13 polling policy when switch to HS DDR mode
      Merge tag 'soc-device-match-tag1' into next

Venkat Gopalakrishnan (2):
      mmc: sdhci-msm: Update DLL reset sequence
      mmc: sdhci-msm: Add HS400 platform support

Wolfram Sang (2):
      mmc: tmio: fix wrong bitmask for SDIO irqs
      mmc: tmio: remove SDIO from TODO list

Zach Brown (4):
      mmc: sdhci: dt: Add device tree properties sdhci-caps and sdhci-caps-mask
      mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the
caps read during __sdhci_read_caps
      mmc: sdhci-pci: Add PCI ID for Intel NI byt sdio
      mmc: sdhci-pci: Use ACPI to get max frequency for Intel NI byt sdio

ahaslam@baylibre.com (2):
      mmc: davinci: use mmc_of_parse to parse common mmc configuration
      mmc: davinci: request gpios using gpio descriptors

yangbo lu (5):
      ARM64: dts: ls2080a: add device configuration node
      dt: bindings: move guts devicetree doc out of powerpc directory
      soc: fsl: add GUTS driver for QorIQ platforms
      MAINTAINERS: add entry for Freescale SoC drivers
      mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |  32 +
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |   9 +
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   3 +
 .../devicetree/bindings/mmc/sdhci-cadence.txt      |  30 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
 Documentation/devicetree/bindings/mmc/sdhci.txt    |  13 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   8 +-
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   2 +-
 .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
 MAINTAINERS                                        |  12 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 +
 drivers/base/Kconfig                               |   1 +
 drivers/base/soc.c                                 |  79 ++
 drivers/mmc/card/block.c                           | 499 ++----------
 drivers/mmc/card/mmc_test.c                        |  58 +-
 drivers/mmc/card/queue.c                           | 312 +++-----
 drivers/mmc/card/queue.h                           |  29 +-
 drivers/mmc/card/sdio_uart.c                       |   2 -
 drivers/mmc/core/core.c                            |  97 +--
 drivers/mmc/core/debugfs.c                         |   6 +-
 drivers/mmc/core/mmc.c                             | 113 +--
 drivers/mmc/core/mmc_ops.c                         | 220 +++---
 drivers/mmc/core/mmc_ops.h                         |   7 +-
 drivers/mmc/core/sd.c                              |  14 -
 drivers/mmc/core/sd_ops.c                          |  27 +-
 drivers/mmc/core/sdio.c                            |  17 +-
 drivers/mmc/core/sdio_cis.c                        |   3 +-
 drivers/mmc/core/sdio_irq.c                        |  12 +-
 drivers/mmc/core/slot-gpio.c                       |   8 +
 drivers/mmc/host/Kconfig                           |  23 +-
 drivers/mmc/host/Makefile                          |   2 +
 drivers/mmc/host/davinci_mmc.c                     | 130 ++--
 drivers/mmc/host/dw_mmc-exynos.c                   |  52 +-
 drivers/mmc/host/dw_mmc-k3.c                       |  39 +-
 drivers/mmc/host/dw_mmc-pci.c                      |  29 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |  28 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  42 +-
 drivers/mmc/host/dw_mmc.c                          | 181 +++--
 drivers/mmc/host/dw_mmc.h                          |   7 +-
 drivers/mmc/host/jz4740_mmc.c                      |   3 +-
 drivers/mmc/host/meson-gx-mmc.c                    | 851 +++++++++++++++++++++
 drivers/mmc/host/mmci.c                            | 128 +++-
 drivers/mmc/host/mmci.h                            |  71 +-
 drivers/mmc/host/mtk-sd.c                          |   4 +-
 drivers/mmc/host/omap_hsmmc.c                      |   3 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   3 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   3 +
 drivers/mmc/host/s3cmci.c                          |  15 +-
 drivers/mmc/host/sdhci-acpi.c                      |   1 +
 drivers/mmc/host/sdhci-cadence.c                   | 283 +++++++
 drivers/mmc/host/sdhci-iproc.c                     |  35 +-
 drivers/mmc/host/sdhci-msm.c                       | 694 +++++++++++++++--
 drivers/mmc/host/sdhci-of-at91.c                   |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  20 +
 drivers/mmc/host/sdhci-pci-core.c                  |  98 ++-
 drivers/mmc/host/sdhci-pci.h                       |   3 +
 drivers/mmc/host/sdhci-pltfm.h                     |   2 +-
 drivers/mmc/host/sdhci-s3c.c                       |   2 +
 drivers/mmc/host/sdhci.c                           | 362 +++++----
 drivers/mmc/host/sdhci.h                           |   4 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 274 ++++++-
 drivers/mmc/host/sunxi-mmc.c                       |  15 +-
 drivers/mmc/host/tmio_mmc.h                        |  32 +-
 drivers/mmc/host/tmio_mmc_pio.c                    | 119 ++-
 drivers/mmc/host/wbsd.c                            |  11 +-
 drivers/soc/Kconfig                                |   3 +-
 drivers/soc/fsl/Kconfig                            |  18 +
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/guts.c                             | 239 ++++++
 include/linux/fsl/guts.h                           | 125 +--
 include/linux/mfd/tmio.h                           |   5 +
 include/linux/mmc/card.h                           |  14 +-
 include/linux/mmc/core.h                           |  16 +-
 include/linux/mmc/dw_mmc.h                         |   6 +
 include/linux/mmc/host.h                           |  17 +-
 include/linux/mmc/mmc.h                            |  17 +
 include/linux/mmc/slot-gpio.h                      |   1 +
 include/linux/sys_soc.h                            |   9 +
 include/uapi/linux/mmc/ioctl.h                     |   2 +-
 79 files changed, 4092 insertions(+), 1574 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
 create mode 100644 drivers/mmc/host/meson-gx-mmc.c
 create mode 100644 drivers/mmc/host/sdhci-cadence.c
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c
