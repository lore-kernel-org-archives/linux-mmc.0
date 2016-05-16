From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.7
Date: Mon, 16 May 2016 14:01:11 +0200
Message-ID: <CAPDyKFqtez7qAeBHVy1_pmHFWxzrU6hwS+d+6Ot4tu9ekyfpMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36629 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbcEPMBN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2016 08:01:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id n129so98270949wmn.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2016 05:01:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here's the PR for MMC v4.7. Details about the highlights are as usual
found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 04974df8049fc4240d22759a91e035082ccd18b4:

  Linux 4.6-rc6 (2016-05-01 15:52:31 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.7

for you to fetch changes up to 1c447116d017a98c90f8f71c8c5a611e0aa42178:

  mmc: mmc: Fix partition switch timeout for some eMMCs (2016-05-16
11:31:28 +0200)

----------------------------------------------------------------
MMC core:
 - Add TRACE support to be able to debug request flow
 - Extend/improve reset support for (e)MMC
 - Convert MMC pwrseq to platform device drivers
 - Use IDA for indexes
 - Some additional minor improvements

MMC host:
 - sdhci: Re-factoring, clean-ups and improvements
 - sdhci-acpi|pci: Use MMC_CAP_AGGRESSIVE_PM for Broxton
 - omap/omap_hsmmc: Convert to use dma_request_chan()
 - usdhi6rol0: Add support for UHS modes
 - sh_mmcif: Update runtime PM support
 - tmio: Wolfram Sang steps in as maintainer
 - tmio: Add UHS-I mode support
 - sh_mobile_sdhi: Add UHS-I mode support
 - tmio/sdhi: Re-factoring, clean-ups and improvements
 - dw_mmc: Re-factoring and clean-ups
 - davinci: Convert to use dma_request_chan()

----------------------------------------------------------------
Adrian Hunter (8):
      mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for Broxton controllers
      mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for Broxton controllers
      mmc: sdhci: Remove redundant condition
      mmc: sdhci: Fix error paths in sdhci_add_host()
      mmc: sdhci: Tidy together LED code
      mmc: sdhci: Remove SDHCI_SDR104_NEEDS_TUNING
      mmc: mmc: Attempt to flush cache before reset
      mmc: mmc: Fix partition switch timeout for some eMMCs

Andreas Fenkart (1):
      mmc: omap_hsmmc: pass omap_hsmmc_host pointer directly

Baolin Wang (1):
      mmc: core: Provide tracepoints for request processing

Ben Hutchings (2):
      mmc: tmio, sh_mobile_sdhi: Pass tmio_mmc_host ptr to
clk_{enable, disable} ops
      mmc: tmio, sh_mobile_sdhi: Add support for variable input clock frequency

David Lechner (4):
      mmc: davinci: remove matching string
      mmc: davinci: fix unwinding in probe
      mmc: davinci: prepare clock
      ARM: davinci: remove mmc dma resources

Dong Aisheng (3):
      mmc: core: fix using wrong io voltage if mmc_select_hs200 fails
      mmc: core: remove the invalid message in mmc_select_timing
      mmc: sdhci: removed unneeded function wrappers

Gwendal Grignou (1):
      mmc: core: Do regular power cycle when lacking eMMC HW reset support

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: add the function for controlling SMU

Ken Sumrall (1):
      mmc: block: improve logging of handling emmc timeouts

Lars Persson (4):
      mmc: dt: usdhi6rol0: add optional pinctrl binding
      mmc: usdhi6rol0: do not announce UHS capabilities
      mmc: usdhi6rol0: add support for UHS modes
      mmc: usdhi6rol0: add pinctrl to set pin drive strength

Ludovic Desroches (4):
      mmc: sdhci: Introduce sdhci_calc_clk()
      mmc: sdhci-of-at91: Implement specific ->set_clock() function
      mmc: sdhci: Remove SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
      mmc: sdhci-of-at91: add presets setup

Masahiro Yamada (11):
      mmc: sdhci-pic32: remove owner assignment
      mmc: core: drop unnecessary bit checking
      mmc: sdhci-pltfm: drop error message for too small MMIO resource size
      mmc: sdhci-pltfm: check return value of platform_get_irq()
      mmc: sdhci-pltfm: use devm_request_mem_region()
      mmc: sdhci-pltfm: use devm_ioremap()
      mmc: sdhci-pltfm: use devm_ioremap_resource()
      mmc: sdhci-pltfm: move devm_ioremap_resource() up
      mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()
      mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to enable LED code
      mmc: sdhci: use IS_ENABLE(CONFIG_LEDS_CLASS) to enable LED struct members

Peter Ujfalusi (3):
      mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel
      mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel
      mmc: omap: Use dma_request_chan() for requesting DMA channel

Shawn Lin (9):
      mmc: dw_mmc-rockchip: remove dw_mci_rockchip_pmops
      mmc: dw_mmc-rockchip: fix failing to mount partition with "discard"
      mmc: dw_mmc: fix warning reported by kernel-doc
      mmc: dw_mmc: avoid using dmaengine_terminate_all
      mmc: dw_mmc: remove unused EVENT_XFER_ERROR
      mmc: dw_mmc-rockchip: remove setup_clock for rockchip
      mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
      mmc: dw_mmc: remove setup_clock callback
      mmc: sdhci-of-arasan: fix set_clock when a phy is supported

Simon Horman (1):
      mmc: sdhci-st: correct name of sd-uhs-sdr50 property

Srinivas Kandagatla (3):
      mmc: pwrseq_simple: add to_pwrseq_simple() macro
      mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
      mmc: pwrseq: convert to proper platform device

Tony Lindgren (1):
      mmc: omap_hsmmc: Check if MMC slot name is passed in pdata

Ulf Hansson (15):
      mmc: sh_mmcif: Make sure the device stays active when needed in ->probe()
      mmc: sh_mmcif: Restructure ->set_ios()
      mmc: sh_mmci: Get rid of wrapper function for regulators
      mmc: atmel-mci: Remove redundant runtime PM calls
      mmc: mmci: Remove redundant runtime PM calls
      mmc: mediatek: Remove redundant runtime PM calls
      mmc: omap_hsmmc: Remove redundant runtime PM calls
      mmc: sdhci-acpi: Remove redundant runtime PM calls
      mmc: sdhci-pci: Remove redundant runtime PM calls
      mmc: tmio: Remove redundant runtime PM calls
      mmc: sdhci: Remove redundant runtime PM calls
      mmc: sdhci: Move sdhci_runtime_pm_bus_off|on() to avoid pre-definition
      mmc: core: Convert from IDR to IDA for host indexes
      mmc: block: Release index in partition allocation error path
      mmc: block: Convert to IDA for partition device indexes

Wolfram Sang (26):
      mmc: tmio: Add UHS-I mode support
      mmc: tmio: always start clock after frequency calculation
      mmc: tmio: stop clock when 0Hz is requested
      mmc: host: add note that set_ios needs to handle 0Hz properly
      mmc: sh_mobile_sdhi: Add UHS-I mode support
      mmc: sh_mobile_sdhi: don't use array for DT configs
      mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
      mmc: tmio: remove now unneeded seperate irq handlers
      mmc: tmio: simplify irq handler
      mmc: tmio: merge distributed include files
      mmc: sh_mobile_sdhi: simplify code for voltage switching
      mmc: sh_mmcif: remove obsolete support for sh7372
      mmc: sh_mobile_sdhi: remove obsolete support for sh7372
      mmc: tmio: give read32/write32 functions more descriptive names
      mmc: tmio: use BIT() within defines
      mmc: tmio: use CTL_STATUS consistently
      mmc: tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC
      mmc: tmio: document CTL_STATUS handling
      mmc: sh_mobile_sdhi: remove obsolete include file
      mmc: sh_mobile_sdhi: make clk_update function more compact
      mmc: tmio/sdhi: introduce flag for RCar 2+ specific features
      mmc: sh_mobile_sdhi: only change the clock on RCar Gen2+
      mmc: sh_mobile_sdhi: check return value when changing clk
      MAINTAINERS: update entry for TMIO MMC driver
      mmc: sdio: fall back to SDIO 1.0 for broken 1.1 cards
      mmc: sh_mobile_sdhi: enable SDIO IRQs for RCar Gen3

 Documentation/devicetree/bindings/mmc/sdhci-st.txt |   4 +-
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   3 +
 .../devicetree/bindings/mmc/usdhi6rol0.txt         |   6 +
 MAINTAINERS                                        |   9 +-
 arch/arm/mach-davinci/devices-da8xx.c              |  20 --
 arch/arm/mach-davinci/devices.c                    |  16 --
 arch/sh/boards/board-sh7757lcr.c                   |   1 -
 arch/sh/boards/mach-ap325rxa/setup.c               |   1 -
 arch/sh/boards/mach-ecovec24/setup.c               |   1 -
 arch/sh/boards/mach-kfr2r09/setup.c                |   1 -
 arch/sh/boards/mach-migor/setup.c                  |   1 -
 arch/sh/boards/mach-se/7724/setup.c                |   1 -
 drivers/mmc/card/block.c                           |  45 ++-
 drivers/mmc/core/Kconfig                           |  21 ++
 drivers/mmc/core/Makefile                          |   4 +-
 drivers/mmc/core/core.c                            |  12 +-
 drivers/mmc/core/host.c                            |  22 +-
 drivers/mmc/core/mmc.c                             |  64 +++--
 drivers/mmc/core/pwrseq.c                          | 108 ++++---
 drivers/mmc/core/pwrseq.h                          |  19 +-
 drivers/mmc/core/pwrseq_emmc.c                     |  81 ++++--
 drivers/mmc/core/pwrseq_simple.c                   |  91 +++---
 drivers/mmc/core/sdio_cis.c                        |   7 +-
 drivers/mmc/host/Kconfig                           |   4 +-
 drivers/mmc/host/atmel-mci.c                       |   9 -
 drivers/mmc/host/davinci_mmc.c                     | 151 ++++------
 drivers/mmc/host/dw_mmc-exynos.c                   |  23 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  43 +--
 drivers/mmc/host/dw_mmc.c                          |  11 +-
 drivers/mmc/host/dw_mmc.h                          |   2 -
 drivers/mmc/host/mmci.c                            |  20 --
 drivers/mmc/host/mtk-sd.c                          |  19 +-
 drivers/mmc/host/omap.c                            |  48 ++--
 drivers/mmc/host/omap_hsmmc.c                      |  90 ++----
 drivers/mmc/host/sdhci-acpi.c                      |   9 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  26 +-
 drivers/mmc/host/sdhci-of-at91.c                   |  74 ++++-
 drivers/mmc/host/sdhci-pci-core.c                  |   9 +-
 drivers/mmc/host/sdhci-pic32.c                     |   1 -
 drivers/mmc/host/sdhci-pltfm.c                     |  42 +--
 drivers/mmc/host/sdhci.c                           | 320 +++++++++------------
 drivers/mmc/host/sdhci.h                           |  10 +-
 drivers/mmc/host/sh_mmcif.c                        |  74 ++---
 drivers/mmc/host/sh_mobile_sdhi.c                  | 194 ++++++++-----
 drivers/mmc/host/tmio_mmc.h                        |  75 ++++-
 drivers/mmc/host/tmio_mmc_dma.c                    |   1 -
 drivers/mmc/host/tmio_mmc_pio.c                    | 196 +++++--------
 drivers/mmc/host/usdhi6rol0.c                      |  60 +++-
 include/linux/mfd/tmio.h                           |   4 +-
 include/linux/mmc/dw_mmc.h                         |  12 +-
 include/linux/mmc/host.h                           |  31 +-
 include/linux/mmc/sh_mobile_sdhi.h                 |  10 -
 include/linux/mmc/tmio.h                           |  71 -----
 include/trace/events/mmc.h                         | 182 ++++++++++++
 54 files changed, 1262 insertions(+), 1097 deletions(-)
 delete mode 100644 include/linux/mmc/sh_mobile_sdhi.h
 delete mode 100644 include/linux/mmc/tmio.h
 create mode 100644 include/trace/events/mmc.h
