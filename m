From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.15
Date: Mon, 13 Nov 2017 12:01:33 +0100
Message-ID: <1510570893-6181-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR for MMC for v4.15. Details about the highlights are as usual found
in the signed tag.

Just to let you know, this PR also contains a merged tag from Mark Brown's
regulator tree, as we needed those changes for omap_hsmmc.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0b07194bb55ed836c2cc7c22e866b87a14681984:

  Linux 4.14-rc7 (2017-10-29 13:58:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.15

for you to fetch changes up to 06641e8deae68ee2769c734158bc9170be257bb9:

  sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute (2017-11-07 13:43:23 +0100)

----------------------------------------------------------------
MMC core:
 - Introduce host claiming by context to support blkmq
 - Preparations for enabling CQE (eMMC CMDQ) requests
 - Re-factorizations to prepare for blkmq support
 - Re-factorizations to prepare for CQE support
 - Fix signal voltage switch for SD cards without power cycle
 - Convert RPMB to a character device
 - Export eMMC revision via sysfs
 - Support eMMC DT binding for fixed driver type
 - Document mmc_regulator_get_supply() API

MMC host:
 - omap_hsmmc: Updated regulator management for PBIAS
 - sdhci-omap: Add new OMAP SDHCI driver
 - meson-mx-sdio: New driver for the Amlogic Meson8 and Meson8b SoCs
 - sdhci-pci: Add support for Intel CDF
 - sdhci-acpi: Fix voltage switch for some Intel host controllers
 - sdhci-msm: Enable delay circuit calibration clocks
 - sdhci-msm: Manage power IRQ properly
 - mediatek: Add support of mt2701/mt2712
 - mediatek: Updates management of clocks and tunings
 - mediatek: Upgrade eMMC HS400 support
 - rtsx_pci: Update tuning for gen3 PCI-Express
 - renesas_sdhi: Support R-Car Gen[123] fallback compatibility strings
 - Catch all errors when getting regulators
 - Various additional improvements and cleanups

----------------------------------------------------------------
Adrian Hunter (17):
      mmc: sdhci-pci: Add support for Intel CDF
      mmc: core: Remove unnecessary host claim
      mmc: core: Introduce host claiming by context
      mmc: core: Add support for handling CQE requests
      mmc: mmc: Enable Command Queuing
      mmc: mmc: Enable CQE's
      mmc: block: Use local variables in mmc_blk_data_prep()
      mmc: block: Prepare CQE data
      mmc: block: Factor out mmc_setup_queue()
      mmc: core: Export a few functions needed for blkmq support
      mmc: core: Factor out mmc_host_set_uhs_voltage()
      mmc: sd: Fix signal voltage when there is no power cycle
      mmc: sdhci-acpi: Use helper function acpi_device_uid()
      mmc: sdhci-acpi: Tidy Intel slot probe functions into one
      mmc: sdhci-pci: Tidy o2micro definitions
      mmc: sdhci-acpi: Let devices define their own private data
      mmc: sdhci-acpi: Fix voltage switch for some Intel host controllers

Allen (4):
      mmc-host: wbsd: use setup_timer() helper.
      mmc-host: via: use setup_timer() helper.
      mmc-host: vub300: use setup_timer() helper.
      mmc-host: mxcmmc: use setup_timer() helper.

Ard Biesheuvel (2):
      dt-bindings: sdhci-fujitsu: document cmd-dat-delay property
      sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute

Arnd Bergmann (1):
      mmc: sdhci-msm: fix x86 build error

Bjorn Andersson (2):
      mmc: sdhci-msm: Utilize bulk clock API
      mmc: sdhci-msm: Enable delay circuit calibration clocks

Carlo Caione (2):
      dt-bindings: mmc: Document the Amlogic Meson8 and Meson8b SDIO bindings
      mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs

Chaotian Jing (12):
      mmc: dt-bindings: Add reg/source_cg/latch-ck for Mediatek MMC bindings
      mmc: mediatek: add support of mt2701/mt2712
      arm64: dts: mt8173: remove "mediatek, mt8135-mmc" from mmc nodes
      mmc: mediatek: make hs400_tune_response only for mt8173
      mmc: mediatek: add pad_tune0 support
      mmc: mediatek: add async fifo and data tune support
      mmc: mediatek: add busy_check support
      mmc: mediatek: add stop_clk fix and enhance_rx support
      mmc: mediatek: add support of source_cg clock
      mmc: mediatek: add latch-ck support
      mmc: mediatek: improve eMMC hs400 mode read performance
      mmc: mediatek: perfer to use rise edge latching for cmd line

Colin Ian King (4):
      mmc: sdhci-omap: make three functions static, fixes warnings
      mmc: dw_mmc: make const arrays mszs static
      mmc: dw_mmc-k3: make array hs_timing_cfg static
      mmc: sdhci-of-at91: make function sdhci_at91_set_uhs_signaling static

Dan Carpenter (2):
      mmc: meson-mx-sdio: return correct error code
      mmc: meson-mx-sdio: Cleanup IS_ERR() checks

Douglas Anderson (5):
      mmc: dw_mmc: cancel the CTO timer after a voltage switch
      mmc: dw_mmc: Fix the CTO timeout calculation
      mmc: dw_mmc: Add locking to the CTO timer
      mmc: dw_mmc: Fix the DTO timeout calculation
      mmc: dw_mmc: Cleanup the DTO timer like the CTO one

Fabrizio Castro (1):
      mmc: tmio: check mmc_regulator_get_supply return value

Jan Glauber (1):
      mmc: cavium: Depend on GPIO driver

Jin Qian (1):
      mmc: core: export emmc revision

Kees Cook (2):
      mmc: Convert timers to use timer_setup()
      mmc: dw_mmc: Convert timers to use timer_setup()

Kishon Vijay Abraham I (4):
      mmc: host: omap_hsmmc: Remove setting PBIAS voltage
      dt-bindings: sdhci-omap: Add bindings for the sdhci-omap controller
      mmc: sdhci-omap: Add OMAP SDHCI driver
      MAINTAINERS: Add TI OMAP SDHCI Maintainer

Krishna Reddy (1):
      mmc: tegra: Mark 64 bit dma broken on Tegra186

Linus Walleij (3):
      mmc: block: Convert RPMB to a character device
      mmc: block: Delete mmc_access_rpmb()
      mmc: block: Fix bug when removing RPMB chardev

Marek Szyprowski (1):
      mmc: sdhci-s3c: Fix driver data for Exynos4 SoCs

Markus Elfring (2):
      mmc: tmio: Use common error handling code in tmio_mmc_host_probe()
      mmc: vub300: Use common code in __download_offload_pseudocode()

Masaharu Hayakawa (1):
      mmc: tmio: Replace msleep() of 20ms or less with usleep_range()

Masahiro Yamada (1):
      mmc: sdhci-cadence: use bitfield access macros for cleanup

Ravikumar Kattekola (1):
      regulator: pbias: Select voltage table based on max-voltage

Sahitya Tummala (1):
      mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset

Simon Horman (3):
      dt-bindings: mmc: renesas_sdhi: provide example in bindings documentation
      dt-bindings: mmc: renesas_sdhi: add R-Car Gen[123] fallback compatibility strings
      mmc: renesas_sdhi: implement R-Car Gen[123] fallback compatibility strings

Subhash Jadavani (1):
      mmc: sdhci-msm: fix issue with power irq

Ulf Hansson (4):
      Merge tag 'regulator-pbias-variants'
      Merge branch 'omap_hsmmc' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Vijay Viswanath (2):
      mmc: Kconfig: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
      mmc: sdhci-msm: Add sdhci msm register write APIs which wait for pwr irq

Wolfram Sang (15):
      mmc: sdhci-pci: remove outdated declaration
      mmc: sunxi: drop superfluous error message
      mmc: add kerneldoc to mmc_regulator_get_supply()
      mmc: cavium: catch all errors when getting regulators
      mmc: dw_mmc: catch all errors when getting regulators
      mmc: meson-gx-mmc: catch all errors when getting regulators
      mmc: meson-mx-sdio: catch all errors when getting regulators
      mmc: mmci: catch all errors when getting regulators
      mmc: mtk-sd: catch all errors when getting regulators
      mmc: mxcmmc: catch all errors when getting regulators
      mmc: omap_hsmmc: catch all errors when getting regulators
      mmc: sdhci: catch all errors when getting regulators
      mmc: usdhi6rol0: catch all errors when getting regulators
      dt-bindings: mmc: describe new eMMC binding for fixed driver type
      mmc: parse new binding for eMMC fixed driver type

Yoshihiro Shimoda (2):
      mmc: tmio: fix swiotlb buffer is full
      mmc: renesas_sdhi: fix kernel panic in _internal_dmac.c

Ziyuan (1):
      mmc: dw_mmc: correct outdated comment for use_dma

rui_feng (1):
      mmc: rtsx: fix tuning fail on gen3 PCI-Express

yangbo lu (1):
      mmc: sdhci-of-esdhc: disable SD clock for clock value 0

 Documentation/ABI/testing/sysfs-bus-mmc            |   4 +
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         |  54 ++
 Documentation/devicetree/bindings/mmc/mmc.txt      |   3 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |  18 +-
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |   2 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   2 +
 .../devicetree/bindings/mmc/sdhci-omap.txt         |  16 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  70 +-
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  12 +-
 drivers/mmc/core/block.c                           | 346 ++++++++--
 drivers/mmc/core/bus.c                             |   7 +
 drivers/mmc/core/core.c                            | 262 ++++++-
 drivers/mmc/core/core.h                            |  16 +-
 drivers/mmc/core/host.c                            |  20 +-
 drivers/mmc/core/host.h                            |   7 +-
 drivers/mmc/core/mmc.c                             |  46 +-
 drivers/mmc/core/mmc_ops.c                         |   6 +-
 drivers/mmc/core/queue.c                           |  41 +-
 drivers/mmc/core/queue.h                           |   4 +-
 drivers/mmc/core/sd.c                              |  51 +-
 drivers/mmc/core/sdio_irq.c                        |   3 +-
 drivers/mmc/host/Kconfig                           |  28 +-
 drivers/mmc/host/Makefile                          |   2 +
 drivers/mmc/host/atmel-mci.c                       |  13 +-
 drivers/mmc/host/cavium.c                          |   2 +-
 drivers/mmc/host/dw_mmc-k3.c                       |   2 +-
 drivers/mmc/host/dw_mmc.c                          | 191 ++++-
 drivers/mmc/host/dw_mmc.h                          |   3 +-
 drivers/mmc/host/jz4740_mmc.c                      |   7 +-
 drivers/mmc/host/meson-gx-mmc.c                    |   2 +-
 drivers/mmc/host/meson-mx-sdio.c                   | 768 +++++++++++++++++++++
 drivers/mmc/host/mmci.c                            |   2 +-
 drivers/mmc/host/mtk-sd.c                          | 285 +++++++-
 drivers/mmc/host/mvsdio.c                          |   6 +-
 drivers/mmc/host/mxcmmc.c                          |  11 +-
 drivers/mmc/host/omap.c                            |  20 +-
 drivers/mmc/host/omap_hsmmc.c                      |  35 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  18 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   5 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  38 +-
 drivers/mmc/host/sdhci-acpi.c                      | 174 +++--
 drivers/mmc/host/sdhci-cadence.c                   |  28 +-
 drivers/mmc/host/sdhci-msm.c                       | 326 +++++++--
 drivers/mmc/host/sdhci-of-at91.c                   |   3 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  58 +-
 drivers/mmc/host/sdhci-omap.c                      | 607 ++++++++++++++++
 drivers/mmc/host/sdhci-pci-core.c                  |  11 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  35 +-
 drivers/mmc/host/sdhci-pci-o2micro.h               |  73 --
 drivers/mmc/host/sdhci-pci.h                       |  13 +
 drivers/mmc/host/sdhci-s3c.c                       |  18 +-
 drivers/mmc/host/sdhci-tegra.c                     |  10 +-
 drivers/mmc/host/sdhci.c                           |  15 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |  14 +
 drivers/mmc/host/sunxi-mmc.c                       |   5 +-
 drivers/mmc/host/tifm_sd.c                         |   6 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  49 +-
 drivers/mmc/host/usdhi6rol0.c                      |   2 +-
 drivers/mmc/host/via-sdmmc.c                       |   8 +-
 drivers/mmc/host/vub300.c                          |  41 +-
 drivers/mmc/host/wbsd.c                            |   8 +-
 drivers/regulator/pbias-regulator.c                |  21 +-
 include/linux/mfd/rtsx_pci.h                       |   1 +
 include/linux/mmc/host.h                           |  11 +-
 include/linux/mmc/sdhci-pci-data.h                 |   3 -
 66 files changed, 3373 insertions(+), 601 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-mmc
 create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
 create mode 100644 drivers/mmc/host/meson-mx-sdio.c
 create mode 100644 drivers/mmc/host/sdhci-omap.c
 delete mode 100644 drivers/mmc/host/sdhci-pci-o2micro.h
