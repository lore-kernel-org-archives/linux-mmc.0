From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.17
Date: Tue,  3 Apr 2018 11:07:44 +0200
Message-ID: <1522746464-25574-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with MMC updates for v.4.17. Details about the highlights are as
usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.17

for you to fetch changes up to 4472f0fc248e3f0573301f725eff9dc9cde5cb62:

  mmc: renesas_sdhi: replace EXT_ACC with HOST_MODE (2018-03-22 10:53:12 +0100)

----------------------------------------------------------------
MMC core:
 - Export host capabilities through debugfs
 - Export card RCA register via sysfs
 - Improve card initializing sequence while enabling 4-bit bus
 - Export a function to enable/disable wakeup for card detect IRQ

MMC host:
 - dw_mmc: Add support for new hi3798cv200 variant
 - dw_mmc: Remove support for some deprecated DT properties
 - mediatek: Add support for new variant used on MT7622 SoC
 - sdhci: Improve wakeup support for SDIO IRQs
 - sdhci: Improve wakeup support for card detect IRQs
 - sdhci-omap: Add tuning support
 - sdhci_omap: Add UHS-I mode support
 - sunxi: Prepare for runtime PM support via a few re-factorings
 - tmio: deprecate "toshiba,mmc-wrprotect-disable" DT property
 - tmio/renesas_sdhi: Consolidate code supporting write protect
 - tmio: Improve DMA vs PIO handling
 - tmio: Add support for IP-builtin card detection logic

----------------------------------------------------------------
Abbas Raza (1):
      mmc: Export host capabilities to debugfs.

Adrian Hunter (7):
      mmc: sdhci-pci: Get rid of glk_cqe_enable()
      mmc: sdhci: Do not unnecessarily enable wakeup for card detect interrupt
      mmc: sdhci: Do not unnecessarily enable wakeup for SDIO card interrupt
      mmc: slot-gpio: Add a function to enable/disable card detect IRQ wakeup
      mmc: sdhci-pci: Respect PM flags when enabling card detect GPIO IRQ wakeup
      mmc: core: Fix tracepoint print of blk_addr and blksz
      mmc: sdhci-acpi: Fix IRQ 0

Alexey Roslyakov (1):
      mmc: dw_mmc: update kernel-doc comments for dw_mci

Andy Shevchenko (1):
      mmc: core: Re-use DEFINE_SHOW_ATTRIBUTE() macro

Bastian Stender (2):
      mmc: block: fix updating ext_csd caches on ioctl call
      mmc: block: fix updating ext_csd caches on ioctl call

Dirk Behme (2):
      mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards
      mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards

Evgeniy Didin (2):
      mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems
      mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs

Harish Jenny K N (1):
      mmc: core: Export card RCA register via sysfs

Jaehoon Chung (7):
      mmc: dw_mmc: remove the deprecated "clock-freq-min-max" property
      mmc: dw_mmc: remove the deprecated "num-slots"
      ARM: dts: socfpga: remove 'num-slots' property for dwmmc
      arm64: dts: stratix10: remove 'num-slots' property for dwmmc
      ARM: dts: lpc18xx: remove 'num-slots' property for dwmmc
      arm64: dts: hi3660: remove 'num-slots' property for dwmmc
      mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433

Joel Cunningham (1):
      mmc: update sdio_claim_irq documentation

John Keeping (1):
      mmc: dw_mmc-rockchip: correct property names in debug

Kishon Vijay Abraham I (7):
      mmc: sdhci-omap: Update 'power_mode' outside sdhci_omap_init_74_clocks
      mmc: sdhci-omap: Add card_busy host ops
      mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
      mmc: sdhci-omap: Add tuning support
      mmc: sdhci-omap: Workaround for Errata i802
      mmc: sdhci_omap: Add support to set IODELAY values
      mmc: sdhci_omap: Fix sdhci-omap quirks

Markus Elfring (1):
      mmc: core: Use memdup_user() rather than duplicating its implementation

Masaharu Hayakawa (1):
      mmc: renesas_sdhi: replace EXT_ACC with HOST_MODE

Masahiro Yamada (10):
      mmc: renesas_sdhi: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
      sh: kfr2r09: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
      mmc: tmio: use MMC_CAP2_NO_WRITE_PROTECT instead of TMIO own flag
      mmc: tmio: remove TMIO_MMC_WRPROTECT_DISABLE
      mmc: tmio: deprecate "toshiba, mmc-wrprotect-disable" DT property
      mmc: tmio: support IP-builtin card detection logic
      mmc: tmio: fix never-detected card insertion bug
      mmc: tmio: move TMIO_MASK_{READOP, WRITEOP} handling to correct place
      mmc: tmio: clear force_pio flag before starting data transfer
      mmc: tmio: remove useless TMIO_MASK_CMD handling in tmio_mmc_host_probe()

Maxime Ripard (3):
      mmc: sunxi: Move resources management to separate functions
      mmc: sunxi: Move the reset deassertion before enabling the clocks
      mmc: sunxi: Set our device drvdata earlier

Sean Wang (2):
      mmc: dt-bindings: add support for MT7622 SoC
      mmc: mediatek: add support for MT7622 SoC

Sergio Valverde (1):
      mmc: core: optimize mmc_calc_max_discard

Shawn Lin (6):
      mmc: dw_mmc: Convert to use DEFINE_SHOW_ATTRIBUTE
      mmc: dw_mmc: Remove prev_state and state assignment for STATE_SENDING_CMD
      mmc: ushc: Remove bogus check of usb_submit_urb
      mmc: core: Don't try UHS-I mode if 4-bit mode isn't supported
      mmc: sdio: Check the return value of sdio_enable_4bit_bus
      mmc: sd: Remove redundant err assignment from mmc_read_switch

Stefan Wahren (1):
      mmc: sdhci-iproc: Disable preset values for BCM2835

Ulf Hansson (4):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Wolfram Sang (2):
      mmc: sh_mmcif: remove some cruft
      mmc: renesas_sdhi: fix WP detection

tianshuliang (2):
      dt-bindings: mmc: add bindings for hi3798cv200-dw-mshc
      mmc: dw_mmc: add support for hi3798cv200 specific extensions of dw-mshc

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 +++
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |   1 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   9 -
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 -
 arch/arm/boot/dts/lpc18xx.dtsi                     |   1 -
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  |   1 -
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   1 -
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   1 -
 arch/arm/boot/dts/socfpga_vt.dts                   |   1 -
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |   1 -
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |   2 -
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 drivers/mmc/core/block.c                           |  34 +-
 drivers/mmc/core/card.h                            |   1 +
 drivers/mmc/core/core.c                            |   5 +-
 drivers/mmc/core/debugfs.c                         |  19 +-
 drivers/mmc/core/host.h                            |   3 +-
 drivers/mmc/core/mmc.c                             |   2 +
 drivers/mmc/core/quirks.h                          |   6 +
 drivers/mmc/core/sd.c                              |  20 +-
 drivers/mmc/core/sdio.c                            |   9 +-
 drivers/mmc/core/sdio_irq.c                        |   4 +-
 drivers/mmc/core/slot-gpio.c                       |  23 +-
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   8 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              | 202 +++++++++++
 drivers/mmc/host/dw_mmc-pci.c                      |   1 -
 drivers/mmc/host/dw_mmc-rockchip.c                 |   4 +-
 drivers/mmc/host/dw_mmc.c                          |  63 +---
 drivers/mmc/host/dw_mmc.h                          |  27 +-
 drivers/mmc/host/mtk-sd.c                          |  12 +
 drivers/mmc/host/renesas_sdhi_core.c               |   6 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  11 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  17 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sdhci-iproc.c                     |   1 +
 drivers/mmc/host/sdhci-omap.c                      | 378 ++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci-core.c                  |  43 ++-
 drivers/mmc/host/sdhci.c                           |  19 +-
 drivers/mmc/host/sh_mmcif.c                        |   8 -
 drivers/mmc/host/sunxi-mmc.c                       | 144 ++++----
 drivers/mmc/host/tmio_mmc_core.c                   |  66 ++--
 drivers/mmc/host/ushc.c                            |   2 -
 include/linux/mfd/tmio.h                           |   1 -
 include/linux/mmc/slot-gpio.h                      |   1 +
 include/trace/events/mmc.h                         |   4 +-
 47 files changed, 931 insertions(+), 286 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-hi3798cv200.c
