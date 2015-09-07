From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.3
Date: Mon, 7 Sep 2015 12:14:24 +0200
Message-ID: <CAPDyKFrc2YmVp=JGwZtHoYWWGcxeA9UV1ZzuY2JpkiyuLyEkow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are the PR for MMC for v4.3.

Details about the MMC highlights are as usual found in the signed tag.
Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2c6625cd545bdd66acff14f3394865d43920a5c7:

  Linux 4.2-rc7 (2015-08-16 16:34:13 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.3

for you to fetch changes up to 092b6dbe8a4a24c17f2ebfe86995dc994e61f420:

  mmc: android-goldfish: remove incorrect __iomem annotation
(2015-09-01 14:19:11 +0200)

----------------------------------------------------------------
MMC core:
 - Fix a race condition in the request handling
 - Skip trim commands for some buggy kingston eMMCs
 - An optimization and a correction for erase groups
 - Set CMD23 quirk for some Sandisk cards

MMC host:
 - sdhci: Give GPIO CD higher precedence and don't poll when it's used
 - sdhci: Fix DMA memory leakage
 - sdhci: Some updates for clock management
 - sdhci-of-at91: introduce driver for the Atmel SDMMC
 - sdhci-of-arasan: Add support for sdhci-5.1
 - sdhci-esdhc-imx: Add support for imx7d which also supports HS400
 - sdhci: A collection of fixes and improvements for various sdhci hosts
 - omap_hsmmc: Modernization of the regulator code
 - dw_mmc: A couple of fixes for DMA and PIO mode
 - usdhi6rol0: A few fixes and support probe deferral for regulators
 - pxamci: Convert to use dmaengine
 - sh_mmcif: Fix the suspend process in a short term solution
 - tmio: Adjust timeout for commands
 - sunxi: Fix timeout while gating/ungating clock

----------------------------------------------------------------
Adam Lee (1):
      mmc: sdhci-pci: set the clear transfer mode register quirk for O2Micro

Addy Ke (1):
      mmc: dw_mmc: add quirk for broken data transfer over scheme

Alexandre Belloni (1):
      mmc: atmel-mci: remove useless include

Alexey Brodkin (1):
      mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is used

Andreas Fenkart (3):
      Documentation: dt: update ti,am33xx-hsmmc swakeup workaround
      mmc: omap_hsmmc: call omap_hsmmc_set_power directly
      mmc: omap_hsmmc: regulator automatically released by devm

Andy Shevchenko (1):
      mmc: block: don't use parameter prefix if built as module

Barry Song (1):
      mmc: sdhci-sirf: corrent quirk according to real chips

Christoph Hellwig (1):
      mmc: android-goldfish: remove incorrect __iomem annotation

Daniel Mack (1):
      mmc: pxamci: switch over to dmaengine use

David Jander (1):
      mmc: core: Optimize case for exactly one erase-group budget

Fabian Frederick (1):
      mmc: omap: use for_each_sg() for scatterlist parsing

Haibo Chen (6):
      mmc: sdhci: fix dma memory leak in sdhci_pre_req()
      mmc: sdhci-esdhc-imx: Document new DT bindings for imx7d support
      mmc: sdhci-esdhc-imx: add imx7d support and support HS400
      mmc: sdhci-esdhc-imx: add tuning-step setting support
      mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
      mmc: sdhci-esdhc-imx: change default watermark level and burst length

Heiko Stuebner (1):
      mmc: dw_mmc: fix pio mode when internal dmac is enabled

Ivan T. Ivanov (4):
      mmc: sdhci-msm: Boost controller core clock
      mmc: sdhci: let GPIO based card detection have higher precedence
      mmc: sdhci: don't use card state polling when CD GPIO is defined
      mmc: sdhci: properly check card present state when quirk
NO_CARD_NO_RESET is set

Jaehoon Chung (3):
      mmc: dw_mmc: fix the wrong condition checking
      mmc: dw_mmc: remove the unused blk_setting
      mmc: dw_mmc: print the message for deprecated property

Jialing Fu (1):
      mmc: core: fix race condition in mmc_wait_data_done

Jisheng Zhang (1):
      mmc: sdhci: also get preset value and driver type for MMC_DDR52

Julia Lawall (2):
      mmc: omap: fix error return code
      mmc: usdhi6rol0: fix error return code

Kishon Vijay Abraham I (15):
      mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
      mmc: host: omap_hsmmc: return on fatal errors from omap_hsmmc_reg_get
      mmc: host: omap_hsmmc: cleanup omap_hsmmc_reg_get()
      mmc: host: omap_hsmmc: use the ocrmask provided by the vmmc regulator
      mmc: host: omap_hsmmc: use mmc_host's vmmc and vqmmc
      mmc: host: omap_hsmmc: remove unnecessary pbias set_voltage
      mmc: host: omap_hsmmc: return error if any of the regulator APIs fail
      mmc: host: omap_hsmmc: add separate functions for enable/disable supply
      mmc: host: omap_hsmmc: add separate function to set pbias
      mmc: host: omap_hsmmc: avoid pbias regulator enable on power off
      mmc: host: omap_hsmmc: don't use ->set_power to set initial
regulator state
      mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based
on previous state
      mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
      mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
      mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check

Koji Matsuoka (1):
      mmc: sh_mmcif: Fix suspend process

Michal Suchanek (1):
      mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff

Rabin Vincent (3):
      mmc: usdhi6rol0: handle probe deferral for regulator
      mmc: usdhi6rol0: fix NULL pointer deref in debug print
      mmc: usdhi6rol0: fix ack register write

Robin van der Gracht (1):
      mmc: core: Fixed bug in one erase-group budget TRIM

Sergei Shtylyov (1):
      mmc: host: use of_property_read_bool()

Shawn Lin (3):
      mmc: dw_mmc: Fix coding style issues
      mmc: block: skip trim for some kingston eMMCs
      mmc: sdhci-of-arasan: Add the support for sdhci-5.1

Suneel Garapati (2):
      mmc: sdhci: add quirk SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN
      mmc: sdhci-of-arasan: add quirks for broken clock base

Takeshi Kihara (1):
      mmc: tmio: Fix timeout value for command request

Yangbo Lu (4):
      mmc: sdio: avoid using NULL sdio_irq_thread pointer
      mmc: sdhci-esdhc: add default quirk SDHCI_QUIRK_NO_HISPD_BIT
      mmc: block: add fixup of broken CMD23 for Sandisk card
      mmc: sdhci-of-esdhc: add workaround for pre divider initial value

kbuild test robot (1):
      mmc: sdhci-of-at91: fix platform_no_drv_owner.cocci warnings

ludovic.desroches@atmel.com (3):
      mmc: sdhci: switch from programmable clock mode to divided one if needed
      mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC
      MAINTAINERS: add entry for Atmel sdhci-of-at91 driver

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   2 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 +
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  21 ++
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   2 +-
 MAINTAINERS                                        |   6 +
 drivers/mmc/card/block.c                           |  17 +
 drivers/mmc/core/core.c                            |  46 ++-
 drivers/mmc/core/host.c                            |  42 +--
 drivers/mmc/host/Kconfig                           |   8 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/android-goldfish.c                |   2 +-
 drivers/mmc/host/atmel-mci.c                       |   1 -
 drivers/mmc/host/dw_mmc-rockchip.c                 |   3 +
 drivers/mmc/host/dw_mmc.c                          | 284 +++++++++++------
 drivers/mmc/host/omap.c                            |   9 +-
 drivers/mmc/host/omap_hsmmc.c                      | 347 +++++++++++++--------
 drivers/mmc/host/pxamci.c                          | 200 +++++++-----
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 114 ++++++-
 drivers/mmc/host/sdhci-esdhc.h                     |   3 +-
 drivers/mmc/host/sdhci-msm.c                       |   5 +
 drivers/mmc/host/sdhci-of-arasan.c                 |   4 +
 drivers/mmc/host/sdhci-of-at91.c                   | 191 ++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c                  |   6 +
 drivers/mmc/host/sdhci-pci.c                       |   1 +
 drivers/mmc/host/sdhci-sirf.c                      |   4 +-
 drivers/mmc/host/sdhci.c                           | 123 ++++----
 drivers/mmc/host/sdhci.h                           |  10 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +
 drivers/mmc/host/sunxi-mmc.c                       |   2 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |   6 +-
 drivers/mmc/host/usdhi6rol0.c                      |  15 +-
 include/linux/mmc/card.h                           |   3 +
 include/linux/mmc/dw_mmc.h                         |   9 +-
 include/linux/mmc/host.h                           |   3 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 35 files changed, 1080 insertions(+), 419 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
 create mode 100644 drivers/mmc/host/sdhci-of-at91.c
