From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.18
Date: Tue,  5 Jun 2018 10:59:34 +0200
Message-ID: <20180605085934.22787-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with MMC updates for v4.18. Details about the highlights are as
usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3de06d5a1f05c11c94cbb68af14dbfa7fb81d78b:

  mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus (2018-05-21 13:27:22 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.18

for you to fetch changes up to ef5332c10d4f332a2ac79e9ad5452f4e89d1815a:

  mmc: renesas_sdhi: really fix WP logic regressions (2018-06-04 11:16:58 +0200)

----------------------------------------------------------------
MMC core:
 - Decrease polling rate for erase/trim/discard
 - Allow non-sleeping GPIOs for card detect
 - Improve mmc block removal path
 - Enable support for mmc_sw_reset() for SDIO cards
 - Add mmc_sw_reset() to allow users to do a soft reset of the card
 - Allow power delay to be tunable via DT
 - Allow card detect debounce delay to be tunable via DT
 - Enable new quirk to limit clock rate for Marvell 8887 chip
 - Don't show eMMC RPMB and BOOT areas in /proc/partitions
 - Add capability to avoid 3.3V signaling for fragile HWs

MMC host:
 - Improve/fixup support for handle highmem pages
 - Remove depends on HAS_DMA in case of platform dependency
 - mvsdio: Enable support for erase/trim/discard
 - rtsx_usb: Enable support for erase/trim/discard
 - renesas_sdhi: Fix WP logic regressions
 - renesas_sdhi: Add r8a77965 support
 - renesas_sdhi: Add R8A77980 to whitelist
 - meson: Add optional support for device reset
 - meson: Add support for the Meson-AXG platform
 - dw_mmc: Add new driver for BlueField DW variant
 - mediatek: Add support for 64G DRAM DMA
 - sunxi: Deploy runtime PM support
 - jz4740: Add support for JZ4780
 - jz4740: Enable support for DT based platforms
 - sdhci: Various improvement to timeout handling
 - sdhci: Disable support for HS200/HS400/UHS when no 1.8V support
 - sdhci-omap: Add support for controller in k2g SoC
 - sdhci-omap: Add workarounds for a couple of Erratas
 - sdhci-omap: Enable support for generic sdhci DT properties
 - sdhci-cadence: Re-send tune request to deal with errata
 - sdhci-pci: Fix 3.3V voltage switch for some BYT-based Intel controllers
 - sdhci-pci: Avoid 3.3V signaling on some NI 904x
 - sdhci-esdhc-imx: Use watermark levels for PIO access
 - sdhci-msm: Improve card detection handling
 - sdhci-msm: Add support voltage pad switching

----------------------------------------------------------------
Aapo Vienamo (1):
      mmc: tegra: remove redundant return statement

Adrian Hunter (3):
      mmc: sdhci-pci: Fix 3.3V voltage switch for some BYT-based Intel controllers
      mmc: sdhci: Add quirk to disable HW timeout
      mmc: sdhci: Factor out target_timeout calculation

Alex Smith (2):
      mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
      mmc: jz4740: Add support for the JZ4780

Andrew Gabbasov (2):
      mmc: card: Don't show eMMC RPMB and BOOT areas in /proc/partitions
      mmc: sdhci-esdhc-imx: Set maximum watermark levels for PIO access

Arnd Bergmann (2):
      mmc: sunxi: mark PM functions as __maybe_unused
      mmc: mxmmc: include linux/highmem.h

Chaotian Jing (1):
      mmc: mediatek: add 64G DRAM DMA support

Christoph Hellwig (6):
      mmc: android-goldfish: use sg_copy_{from,to}_buffer
      mmc: atmel-mci: use sg_copy_{from,to}_buffer
      mmc: mxcmmc: handle highmem pages
      mmc: ushc: handle highmem pages
      mmc: wbsd: handle highmem pages
      mmc: au1xmmc: handle highmem pages

Diwakar Sharma (1):
      mmc: core: sdio: Set SDIO clock of SDR104 to 150MHz for Marvell 8887 chip

Evan Green (1):
      mmc: Allow non-sleeping GPIO cd

Ezequiel Garcia (10):
      mmc: jz4780: Order headers alphabetically
      mmc: jz4740: Use dev_get_platdata
      mmc: jz4740: Introduce devicetree probe
      mmc: dt-bindings: add MMC support to JZ4740 SoC
      mmc: jz4740: Use dma_request_chan()
      MIPS: dts: jz4780: Add DMA controller node to the devicetree
      MIPS: dts: jz4780: Add MMC controller node to the devicetree
      MIPS: dts: ci20: Enable MMC in the devicetree
      MIPS: configs: ci20: Enable DMA and MMC support
      MIPS: configs: ci20: Enable ext4

Geert Uytterhoeven (1):
      mmc: Remove depends on HAS_DMA in case of platform dependency

Georgi Djakov (1):
      mmc: sdhci-msm: Remove NO_CARD_NO_RESET quirk

Gustavo A. R. Silva (1):
      mmc: sdhci-cadence: fix logically and structurally dead code

Jerome Brunet (2):
      dt-bindings: mmc: meson-gx: add reset
      mmc: meson-gx: add device reset

Jisheng Zhang (1):
      mmc: sdhci-*: Don't emit error msg if sdhci_add_host() fails

Kishon Vijay Abraham I (12):
      mmc: sdhci-omap: Fix when capabilities are obtained from SDHCI_CAPABILITIES reg
      mmc: sdhci-omap: Remove setting ADMA capability in driver
      mmc: sdhci-omap: Workaround for Errata i843
      mmc: sdhci-omap: Invoke sdhci_get_of_property to read sdhci dt properties
      mmc: sdhci: Disable 1.8v modes (HS200/HS400/UHS) if controller can't support 1.8v
      mmc: sdhci: Program a relatively accurate SW timeout value
      mmc: sdhci-omap: Workaround for Errata i834
      dt-bindings: sdhci-omap: Add K2G specific binding
      mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
      mmc: sdhci-omap: Add sdhci_omap specific ops for enable_sdio_irq
      dt-bindings: sdhci-omap: Add pinctrl bindings
      mmc: sdhci-omap: Get IODelay values for 3.3v DDR mode

Kyle Roeschley (2):
      mmc: core: Add capability to avoid 3.3V signaling
      mmc: sdhci-pci: Avoid 3.3V signaling on some NI 904x

Liming Sun (2):
      mmc: dw_mmc-bluefield: Add driver extension
      dt-bindings: mmc: Add binding for BlueField SoC

Martin Hicks (1):
      mmc: Throttle calls to MMC_SEND_STATUS during mmc_do_erase()

Masaharu Hayakawa (2):
      mmc: renesas_sdhi: Fix alignment check of sg buffer
      mmc: renesas_sdhi: Add r8a77965 support

Masahiro Yamada (1):
      mmc: sdhci-cadence: send tune request twice to work around errata

Maxime Ripard (7):
      mmc: sunxi: Reorder the headers
      mmc: sunxi: Change sunxi_mmc_init_host argument type
      mmc: sunxi: Move bus width configuration to a function
      mmc: sunxi: Move clock configuration to a function
      mmc: sunxi: Move the card power configuration to a function
      mmc: sunxi: Add runtime_pm support
      mmc: sunxi: Drop the init / reset of the controller from set_ios

Nan Li (3):
      mmc: dt-bindings: update bindings doc to support Meson-AXG SoC
      mmc: meson-axg: add support for the Meson-AXG platform
      mmc: meson: update doc to support Meson-AXG platform

Niklas Söderlund (1):
      mmc: renesas_sdhi: use helpers to access struct scatterlist members

Paul Cercueil (1):
      mmc: jz4740: Fix error exit path in driver's probe

Phil Edworthy (1):
      mmc: sdhci-of-arasan: Add quirk to avoid unexpected interrupt msgs

Ryder Lee (1):
      mmc: mediatek: use of_device_get_match_data()

Sergei Shtylyov (2):
      mmc: dt: tmio_mmc: document R8A77980 bindings
      mmc: renesas_sdhi_internal_dmac: add R8A77980 to whitelist

Shawn Lin (7):
      mmc: dw_mmc: update actual clock for mmc debugfs
      mmc: dw_mmc: fix misleading comment in dw_mci_rk3288_set_ios
      mmc: dt-bindings: Add optional cd-debounce-delay-ms
      mmc: core: Add tunable delay before detecting card after card is inserted
      Documentation: mmc: addtional description for post-power-on-delay-ms
      mmc: core: add tunable delay waiting for power to be stable
      mmc: block: Don't switch to the same partition type in mmc_blk_remove()

Thomas Gleixner (1):
      mmc: mmci: Remove bogus local_irq_save()

Tobin C. Harding (1):
      mmc: pwrseq: Use kmalloc_array instead of stack VLA

Ulf Hansson (16):
      Merge branch 'sdhci_omap' into next
      mmc: core: Re-factor some code for SDIO re-initialization
      mmc: core: Rename ->reset() bus ops to ->hw_reset()
      mmc: core: Export a function mmc_sw_reset() to allow soft reset of cards
      mmc: core: Share internal function to set initial signal voltage
      mmc: core: Implement ->sw_reset bus ops for SDIO
      mmc: rtsx_usb: Use MMC_CAP2_NO_SDIO
      mmc: rtsx_usb: Use the provided busy timeout from the mmc core
      mmc: rtsx_usb: Enable MMC_CAP_ERASE to allow erase/discard/trim requests
      mmc: core: Drop unused define for timeout
      Merge branch 'fixes' into next
      mmc: core: Move calls to ->prepare_hs400_tuning() closer to mmc code
      mmc: mxmmc: Use ifdef rather than __maybe_unused
      mmc: sunxi: Use ifdef rather than __maybe_unused
      mmc: mvsdio: Respect card busy time out from mmc core
      mmc: mvsdio: Enable MMC_CAP_ERASE

Vijay Viswanath (2):
      mmc: sdhci-msm: Add support to store supported vdd-io voltages
      mmc: sdhci-msm: support voltage pad switching

Wolfram Sang (4):
      mmc: renesas_sdhi_internal_dmac: use more generic whitelisting
      mmc: renesas_sdhi_internal_dmac: remove superfluous WARN
      mmc: host: simplify getting .drvdata
      mmc: renesas_sdhi: really fix WP logic regressions

Xie Yisheng (1):
      mmc: sdhci-xenon: use match_string() helper

Zubair Lutfullah Kakakhel (1):
      mmc: jz4740: Reset the device requesting the interrupt

harish_kandiga@mentor.com (1):
      mmc: core: Add a new quirk for limiting clock rate

yinbo.zhu (1):
      mmc: sd: Define name for default speed dtr

 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |   3 +
 .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  |  29 +++
 Documentation/devicetree/bindings/mmc/jz4740.txt   |  38 ++++
 Documentation/devicetree/bindings/mmc/mmc.txt      |   6 +
 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   2 +
 arch/mips/boot/dts/ingenic/ci20.dts                |  34 ++++
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  52 ++++++
 arch/mips/configs/ci20_defconfig                   |   4 +
 drivers/mmc/core/block.c                           |  11 +-
 drivers/mmc/core/card.h                            |   6 +
 drivers/mmc/core/core.c                            |  67 +++++--
 drivers/mmc/core/core.h                            |   4 +-
 drivers/mmc/core/host.c                            |  16 +-
 drivers/mmc/core/mmc.c                             |  16 +-
 drivers/mmc/core/pwrseq_simple.c                   |  14 +-
 drivers/mmc/core/quirks.h                          |   3 +
 drivers/mmc/core/sd.c                              |  12 +-
 drivers/mmc/core/sdio.c                            |  70 ++++---
 drivers/mmc/core/slot-gpio.c                       |  22 ++-
 drivers/mmc/host/Kconfig                           |  32 ++--
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/android-goldfish.c                |   8 +-
 drivers/mmc/host/atmel-mci.c                       |  21 +--
 drivers/mmc/host/au1xmmc.c                         |  12 +-
 drivers/mmc/host/davinci_mmc.c                     |   6 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |  81 ++++++++
 drivers/mmc/host/dw_mmc-rockchip.c                 |   5 +-
 drivers/mmc/host/dw_mmc.c                          |   4 +
 drivers/mmc/host/jz4740_mmc.c                      | 203 ++++++++++++++-------
 drivers/mmc/host/meson-gx-mmc.c                    |  72 ++++++--
 drivers/mmc/host/mmci.c                            |   5 -
 drivers/mmc/host/mtk-sd.c                          |  63 +++++--
 drivers/mmc/host/mvsdio.c                          |   6 +-
 drivers/mmc/host/mxcmmc.c                          |  22 ++-
 drivers/mmc/host/renesas_sdhi_core.c               |   5 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  32 ++--
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   3 +
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |  19 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   4 +-
 drivers/mmc/host/sdhci-cadence.c                   |  22 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  22 +++
 drivers/mmc/host/sdhci-msm.c                       |  85 ++++++++-
 drivers/mmc/host/sdhci-of-arasan.c                 |   9 +-
 drivers/mmc/host/sdhci-omap.c                      |  92 ++++++++--
 drivers/mmc/host/sdhci-pci-core.c                  |  38 +++-
 drivers/mmc/host/sdhci-pci.h                       |   1 +
 drivers/mmc/host/sdhci-pic32.c                     |   4 +-
 drivers/mmc/host/sdhci-pxav2.c                     |   4 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   4 +-
 drivers/mmc/host/sdhci-s3c.c                       |   4 +-
 drivers/mmc/host/sdhci-spear.c                     |   4 +-
 drivers/mmc/host/sdhci-st.c                        |   4 +-
 drivers/mmc/host/sdhci-tegra.c                     |   2 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |  11 +-
 drivers/mmc/host/sdhci.c                           | 148 ++++++++++++---
 drivers/mmc/host/sdhci.h                           |  15 ++
 drivers/mmc/host/sunxi-mmc.c                       | 187 ++++++++++++-------
 drivers/mmc/host/ushc.c                            |   4 +-
 drivers/mmc/host/wbsd.c                            |  68 +++----
 drivers/mmc/host/wmt-sdmmc.c                       |   6 +-
 include/dt-bindings/dma/jz4780-dma.h               |  49 +++++
 include/linux/mmc/card.h                           |   2 +
 include/linux/mmc/core.h                           |   1 +
 include/linux/mmc/host.h                           |   6 +
 include/linux/mmc/sdio_ids.h                       |   1 +
 66 files changed, 1382 insertions(+), 431 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
 create mode 100644 drivers/mmc/host/dw_mmc-bluefield.c
 create mode 100644 include/dt-bindings/dma/jz4780-dma.h
