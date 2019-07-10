From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.3
Date: Wed, 10 Jul 2019 16:01:16 +0200
Message-ID: <20190710140116.457-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC and MEMSTICK for v5.3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 83293386bc95cf5e9f0c0175794455835bd1cb4a:

  mmc: core: Prevent processing SDIO IRQs when the card is suspended (2019-06-18 14:06:32 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3

for you to fetch changes up to 59592cc1f5937ced72e11e681c3e358a0375f7ae:

  mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654 (2019-07-10 13:17:30 +0200)

----------------------------------------------------------------
MMC core:
 - Let the dma map ops deal with bouncing and drop dma_max_pfn() from the
   dma-mapping interface for ARM
 - Convert the generic MMC DT doc to YAML schemas
 - Drop questionable support for powered-on re-init of SDIO cards at
   runtime resume and for SDIO HW reset
 - Prevent questionable re-init of powered-on removable SDIO cards at
   system resume
 - Cleanup and clarify some SDIO core code

MMC host:
 - tmio: Make runtime PM enablement more flexible for variants
 - tmio/renesas_sdhi: Rename DT doc tmio_mmc.txt to renesas,sdhi.txt to clarify
 - sdhci-pci: Add support for Intel EHL
 - sdhci-pci-o2micro: Enable support for 8-bit bus
 - sdhci-msm: Prevent acquiring a mutex while holding a spin_lock
 - sdhci-of-esdhc: Improve clock management and tuning
 - sdhci_am654: Enable support for 4 and 8-bit bus on J721E
 - sdhci-sprd: Use pinctrl for a proper signal voltage switch
 - sdhci-sprd: Add support for HS400 enhanced strobe mode
 - sdhci-sprd: Enable PHY DLL and allow delay config to stabilize the clock
 - sdhci-sprd: Add support for optional gate clock
 - sunxi-mmc: Convert DT doc to YAML schemas
 - meson-gx: Add support for broken DRAM access for DMA

MEMSTICK core:
 - Fixup error path of memstick_init()

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Add support for Intel EHL

Baolin Wang (11):
      mmc: sdhci-sprd: Check the enable clock's return value correctly
      dt-bindings: mmc: sprd: Add another optional clock documentation
      mmc: sdhci-sprd: Add optional gate clock support
      mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
      mmc: sdhci-sprd: Add HS400 enhanced strobe mode
      mmc: sdhci-sprd: Enable PHY DLL to make clock stable
      dt-bindings: mmc: sprd: Add PHY DLL delay documentation
      mmc: sdhci-sprd: Add PHY DLL delay configuration
      mmc: sdhci-sprd: Add start_signal_voltage_switch ops
      dt-bindings: mmc: sprd: Add pinctrl support
      mmc: sdhci-sprd: Add pin control support for voltage switch

Christoph Hellwig (2):
      mmc: core: let the dma map ops handle bouncing
      dma-mapping: remove dma_max_pfn

Colin Ian King (2):
      mmc: sdhci-pci: remove redundant check of slots == 0
      mmc: alcor: remove a redundant greater or equal to zero comparison

Faiz Abbas (5):
      mmc: sdhci_am654: Improve whitespace utilisation with regmap_*() calls
      mmc: sdhci_am654: Print error message if the DLL fails to lock
      dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's J721E devices.
      mmc: sdhci_am654: Add Support for 8 bit IP on J721E
      mmc: sdhci_am654: Add Support for 4 bit IP on J721E

Greg Kroah-Hartman (4):
      mmc: core: no need to check return value of debugfs_create functions
      mmc: host: atmel-mci: no need to check return value of debugfs_create functions
      mmc: host: dw_mmc: no need to check return value of debugfs_create functions
      mmc: host: s3cmci: no need to check return value of debugfs_create functions

Jorge Ramirez-Ortiz (1):
      mmc: sdhci-msm: fix mutex while in spinlock

Kamlesh Gurudasani (1):
      mmc: android-goldfish: Drop pointer to mmc_host from goldfish_mmc_host

Masahiro Yamada (1):
      dt-binding: mmc: rename tmio_mmc.txt to renesas,sdhi.txt

Maxime Ripard (2):
      dt-bindings: mmc: Add YAML schemas for the generic MMC options
      dt-bindings: mmc: sun4i: Add YAML schemas

Neil Armstrong (3):
      mmc: meson-gx-mmc: update with SPDX Licence identifier
      dt-bindings: mmc: meson-gx: add dram-access-quirk property
      mmc: meson-gx: add dram-access-quirk

Niklas Söderlund (1):
      mmc: tmio: move runtime PM enablement to the driver implementations

Raul E Rangel (2):
      mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
      mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS

Thierry Reding (1):
      sdhci: tegra: Do not log error message on deferred probe

Ulf Hansson (12):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next
      mmc: sdio: Turn sdio_run_irqs() into static
      mmc: sdio: Drop mmc_claim|release_host() in mmc_sdio_power_restore()
      mmc: sdio: Move comment about re-initialization to mmc_sdio_reinit_card()
      mmc: sdio: Drop powered-on re-init at runtime resume and HW reset
      mmc: sdio: Don't re-initialize powered-on removable SDIO cards at resume
      mmc: sdio: Drop unused in-parameter to mmc_sdio_reinit_card()
      mmc: sdio: Drop unused in-parameter from mmc_sdio_init_card()

Wang Hai (1):
      memstick: Fix error cleanup path of memstick_init

Wolfram Sang (2):
      mmc: sdhi: improve quirk descriptions
      mmc: sdhi: remove unneeded initialization

Yangbo Lu (2):
      mmc: sdhci-of-esdhc: set the sd clock divisor value above 3
      mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1028a

Yoshihiro Shimoda (1):
      mmc: tmio: Use dma_max_mapping_size() instead of a workaround

YueHaibing (2):
      mmc: sdhci_am654: Make some symbols static
      mmc: sdhci_am654: Add dependency on MMC_SDHCI_AM654

 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |  98 ++++++
 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |   4 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    | 374 +++++++++++++++++++++
 Documentation/devicetree/bindings/mmc/mmc.txt      | 178 +---------
 .../mmc/{tmio_mmc.txt => renesas,sdhi.txt}         |  11 +-
 .../devicetree/bindings/mmc/sdhci-am654.txt        |   9 +-
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  26 ++
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  52 ---
 arch/arm/include/asm/dma-mapping.h                 |   7 -
 drivers/memstick/core/memstick.c                   |  13 +-
 drivers/mmc/core/debugfs.c                         |  56 +--
 drivers/mmc/core/mmc_test.c                        |  10 +-
 drivers/mmc/core/queue.c                           |   7 +-
 drivers/mmc/core/sdio.c                            |  92 ++---
 drivers/mmc/core/sdio_irq.c                        |   3 +-
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/mmc/host/alcor.c                           |   2 +-
 drivers/mmc/host/android-goldfish.c                |  31 +-
 drivers/mmc/host/atmel-mci.c                       |  38 +--
 drivers/mmc/host/dw_mmc.c                          |  36 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  85 +++--
 drivers/mmc/host/renesas_sdhi_core.c               |  19 +-
 drivers/mmc/host/s3cmci.c                          |  27 +-
 drivers/mmc/host/s3cmci.h                          |   2 -
 drivers/mmc/host/sdhci-msm.c                       |   9 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  17 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   4 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |  12 +-
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci-sprd.c                      | 249 +++++++++++++-
 drivers/mmc/host/sdhci-tegra.c                     |   5 +-
 drivers/mmc/host/sdhci.h                           |   2 +-
 drivers/mmc/host/sdhci_am654.c                     | 293 +++++++++++-----
 drivers/mmc/host/tmio_mmc.c                        |   5 +
 drivers/mmc/host/tmio_mmc_core.c                   |  29 +-
 drivers/mmc/host/uniphier-sd.c                     |   3 +
 include/linux/dma-mapping.h                        |   7 -
 include/linux/mmc/host.h                           |   1 -
 38 files changed, 1188 insertions(+), 632 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-controller.yaml
 rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas,sdhi.txt} (87%)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
