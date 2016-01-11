From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.5
Date: Mon, 11 Jan 2016 16:42:52 +0100
Message-ID: <CAPDyKFoq5kUGK6wPdX3kWXO-M_d-12gnCS=6KOvbMVBMD72gVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR for MMC v4.5.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4ef7675344d687a0ef5b0d7c0cee12da005870c0:

  Linux 4.4-rc6 (2015-12-20 16:06:09 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.5

for you to fetch changes up to 01a999e48995a35faaa513f811c335bce72917d6:

  mmc: dw_mmc: remove the unused quirks (2016-01-05 18:04:58 +0100)

----------------------------------------------------------------
MMC core:
 - Optimize boot time by detecting cards simultaneously
 - Make runtime resume default behavior for MMC/SD
 - Enable MMC/SD/SDIO devices to suspend/resume asynchronously
 - Allow more than 8 partitions per card
 - Introduce MMC_CAP2_NO_SDIO to prevent unsupported SDIO commands
 - Support the standard DT wakeup-source property
 - Fix driver strength switching for HS200 and HS400
 - Fix switch command timeout
 - Fix invalid vdd in voltage switch power cycle for SDIO

MMC host:
 - sdhci: Restore behavior when setting VDD via external regulator
 - sdhci: A couple of changes/fixes related to the dma support
 - sdhci-tegra: Add Tegra210 support
 - sdhci-tegra: Support for UHS-I cards including tuning support
 - sdhci-of-at91: Add PM support
 - sh_mmcif: Rework dma channel handling
 - mvsdio: Delete platform data code path

----------------------------------------------------------------
Adrian Hunter (7):
      mmc: sdhci-pci: Do not default to 33 Ohm driver strength for Intel SPT
      mmc: sdhci: Do not BUG on invalid vdd
      mmc: sdio: Fix invalid vdd in voltage switch power cycle
      mmc: sdhci: Fix DMA descriptor with zero data length
      mmc: sdhci: 64-bit DMA actually has 4-byte alignment
      mmc: sdhci: Fix sdhci_runtime_pm_bus_on/off()
      mmc: It is not an error for the card to be removed while suspended

Adrien Schildknecht (1):
      mmc: kconfig: replace FAULT_INJECTION with FAULT_INJECTION_DEBUG_FS

Arnd Bergmann (3):
      mmc: sh_mmcif: rework dma channel handling
      mmc: fix mmc_{un,}register_pm_notifier prototypes
      mmc: dw_mmc: use resource_size_t to store physical address

Carlo Caione (1):
      mmc: core: Introduce MMC_CAP2_NO_SDIO cap

Chaotian Jing (2):
      mmc: mediatek: change some dev_err to dev_dbg
      mmc: core: fix __mmc_switch timeout caused by preempt

Colin Cross (1):
      mmc: block: Allow more than 8 partitions per card

Fu, Zhonghui (1):
      mmc: enable MMC/SD/SDIO device to suspend/resume asynchronously

Geliang Tang (2):
      mmc: cb710: use to_platform_device()
      mmc: sdhci-pci: use to_pci_dev()

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: correct the tuning-step setting

Jaehoon Chung (1):
      mmc: dw_mmc: remove the unused quirks

Jisheng Zhang (1):
      mmc: sdhci: restore behavior when setting VDD via external regulator

Julia Lawall (1):
      mmc: pwrseq: constify mmc_pwrseq_ops structures

Linus Walleij (2):
      mmc: mvsdio: delete platform data header
      mmc: mvsdio: delete platform data code path

Lucas Stach (5):
      mmc: tegra: implement module external clock change
      mmc: tegra: disable SPI_MODE_CLKEN
      mmc: tegra: implement UHS tuning
      mmc: tegra: enable UHS-I modes
      mmc: tegra: use correct accessor for misc ctrl register

Marek Vasut (1):
      mmc: sdhci: Fix strings broken across multiple lines

Peter Ujfalusi (1):
      mmc: omap_hsmmc: No need to check DMA channel validity at module remove

Rabin Vincent (1):
      mmc: usdhi6rol0: handle NULL data in timeout

Sudeep Holla (1):
      mmc: core: enable support for the standard "wakeup-source" property

Thierry Reding (2):
      mmc: tegra: Constify SoC data
      mmc: tegra: Add Tegra210 support

Ulf Hansson (7):
      mmc: core: Invoke ->card_event() callback only when needed
      mmc: core: Keep host claimed in mmc_rescan() while calling host ops
      mmc: core: Make runtime resume default behavior for MMC/SD
      mmc: core: Remove MMC_CAP_RUNTIME_RESUME as it's redundant
      mmc: core: Refactor code to register the MMC PM notifier
      mmc: core: Check for non-removable cards earlier in the error path
      mmc: core: Optimize boot time by detecting cards simultaneously

Ulrich Hecht (1):
      mmc: sh_mmcif: Document r8a7793 DT bindings

Wenkai Du (1):
      mmc: mmc: Fix incorrect use of driver strength switching HS200 and HS400

ludovic.desroches@atmel.com (5):
      mmc: core: set regulator not found message as debug
      mmc: sdhci-of-at91: add PM support
      mmc: atmel-mci: move atmel-mci-regs.h content in atmel-mci.c
      MAINTAINERS: remove atmel-mci-regs.h file
      mmc: atmel-mci: atmci_convert_chksize depends on controller version

saurabh (1):
      mmc: of_mmc_spi: Add IRQF_ONESHOT to interrupt flags

yalin wang (1):
      mmc: block: change to use kmalloc when copy data from userspace

yangbo lu (1):
      mmc: sdhci-of-esdhc: add/remove some quirks according to vendor version

 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   1 +
 MAINTAINERS                                        |   1 -
 drivers/mmc/card/block.c                           |  11 +-
 drivers/mmc/core/bus.c                             |   2 +
 drivers/mmc/core/core.c                            |  85 +++++-----
 drivers/mmc/core/core.h                            |   8 +
 drivers/mmc/core/host.c                            |  11 +-
 drivers/mmc/core/mmc.c                             |  23 +--
 drivers/mmc/core/mmc_ops.c                         |   9 +-
 drivers/mmc/core/pwrseq.h                          |   2 +-
 drivers/mmc/core/pwrseq_emmc.c                     |   2 +-
 drivers/mmc/core/pwrseq_simple.c                   |   2 +-
 drivers/mmc/core/sd.c                              |  17 +-
 drivers/mmc/core/sdio.c                            |   2 +-
 drivers/mmc/core/sdio_bus.c                        |   1 +
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/atmel-mci-regs.h                  | 171 --------------------
 drivers/mmc/host/atmel-mci.c                       | 165 ++++++++++++++++++-
 drivers/mmc/host/cb710-mmc.h                       |   3 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   8 -
 drivers/mmc/host/dw_mmc.c                          |  21 +--
 drivers/mmc/host/mtk-sd.c                          |   9 +-
 drivers/mmc/host/mvsdio.c                          |  58 ++-----
 drivers/mmc/host/of_mmc_spi.c                      |   4 +-
 drivers/mmc/host/omap_hsmmc.c                      |   6 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   7 +-
 drivers/mmc/host/sdhci-of-at91.c                   |  75 ++++++++-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  10 ++
 drivers/mmc/host/sdhci-pci-core.c                  |   6 +-
 drivers/mmc/host/sdhci-pltfm.c                     |   3 +-
 drivers/mmc/host/sdhci-tegra.c                     | 178 +++++++++++++++++----
 drivers/mmc/host/sdhci.c                           | 124 ++++++--------
 drivers/mmc/host/sdhci.h                           |  21 +--
 drivers/mmc/host/sh_mmcif.c                        |  84 +++++-----
 drivers/mmc/host/usdhi6rol0.c                      |   3 +-
 include/linux/mmc/dw_mmc.h                         |  12 +-
 include/linux/mmc/host.h                           |   6 +-
 include/linux/platform_data/mmc-mvsdio.h           |  18 ---
 lib/Kconfig.debug                                  |   3 +-
 40 files changed, 626 insertions(+), 549 deletions(-)
 delete mode 100644 drivers/mmc/host/atmel-mci-regs.h
 delete mode 100644 include/linux/platform_data/mmc-mvsdio.h
