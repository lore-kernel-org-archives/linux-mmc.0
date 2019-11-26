From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v5.5
Date: Tue, 26 Nov 2019 16:48:51 +0100
Message-ID: <20191126154851.14737-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's the PR with updates for MMC and MEMSTICK for v5.5. Details about the
highlights are as usual found in the signed tag.

However, note at this time the PR contains quite some additional changes
reaching beyond both the MMC and MEMSTICK subsystems. This is primarily because
of fixing an old regression for a WiFi driver based on the SDIO interface on an
OMAP openpandora board.

I haven't noticed any reports about merge conflicts in linux-next, but just let
me know if you encounter any issues.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fed23c5829ecab4ddc712d7b0046e59610ca3ba4:

  mmc: sdhci-of-at91: fix quirk2 overwrite (2019-11-14 14:57:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5

for you to fetch changes up to def7bd940f8cceb41ec3d1383acd8ab937056dcb:

  dt-bindings: mmc: Correct the type of the clk phase properties (2019-11-22 08:43:43 +0100)

----------------------------------------------------------------
MMC core:
 - Add CMD13 polling for MMC IOCTLS with R1B response.
 - Add common DT properties for clk-phase-delays for various speed modes.
 - Fix size overflow for mmc gp-partitions.
 - Re-work HW reset for SDIO cards, which also includes a re-work for
   Marvell's WiFi mwifiex SDIO func driver.

MMC host:
 - jz4740: Add support for X1000 and JZ4760.
 - jz4740: Add support for 8-bit bus and for low power mode.
 - mmci: Add support for HW busy timeout for the stm32_sdmmc variant.
 - owl-mmc: Add driver for Actions Semi Owl SoCs SD/MMC controller.
 - renesas_sdhi: Add support for r8a774b1.
 - sdhci_am654: Add support for Command Queuing Engine for J721E.
 - sdhci-milbeaut: Add driver for the Milbeaut SD controller.
 - sdhci-of-arasan: Add support for ZynqMP tap-delays.
 - sdhci-of-arasan: Add support for clk-phase-delays for SD cards.
 - sdhci-of-arasan: Add support for Intel LGM SDXC.
 - sdhci-of-aspeed: Allow inversion of the internal card detect signal.
 - sdhci-of-esdhc: Fixup workaround for erratum A-008171 for tunings.
 - sdhci-of-at91: Improve support for calibration.
 - sdhci-pci: Add support for Intel JSL.
 - sdhci-pci: Add quirk for AMD SDHC Device 0x7906.
 - tmio: Enable support for erase/discard/trim requests.

MMC/OMAP/pandora/wl1251:
The TI wl1251 WiFi driver for SDIO on the OMAP openpandora board has been
broken since v4.7. To fix the problems, changes have been made cross
subsystems, but also to OMAP2 machine code and to openpandora DTS files, as
summarized below. Note that, relevant changes have been tagged for stable.

 - mmc/wl1251: Re-introduce lost SDIO quirks and vendor-id for wl1251
 - omap/omap_hsmmc: Remove redundant platform config for openpandora
 - omap_hsmmc: Initialize non-std SDIO card for wl1251 for pandora
 - omap/dts/pandora: Specify wl1251 through a child node of mmc3
 - wl1251: Add devicetree support for TI wl1251 SDIO

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Add support for Intel JSL

Ben Dooks (2):
      mmc: mmci: make unexported functions static
      mmc: mmci: stm32: make sdmmc_idma_validate_data static

Biju Das (2):
      dt-bindings: mmc: renesas_sdhi: Add r8a774b1 support
      mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support

Bradley Bolen (1):
      mmc: core: Fix size overflow for mmc partitions

Chaotian Jing (2):
      mmc: block: Make card_busy_detect() a bit more generic
      mmc: block: Add CMD13 polling for MMC IOCTLS with R1B response

Colin Ian King (2):
      memstick: jmb38x_ms: clean up indentation issue
      mmc: dw_mmc: fix indentation issue

Eugeniu Rosca (1):
      mmc: tmio: Add MMC_CAP_ERASE to allow erase/discard/trim requests

Fabio Estevam (1):
      mmc: sdhci: Fix grammar in warning message

Faiz Abbas (1):
      mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E

H. Nikolaus Schaller (12):
      Documentation: dt: wireless: update wl1251 for sdio
      net: wireless: ti: wl1251 add device tree support
      ARM: dts: pandora-common: define wl1251 as child node of mmc3
      mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card
      omap: pdata-quirks: revert pandora specific gpiod additions
      omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251
      omap: remove omap2_hsmmc_info in old hsmmc.[ch] and update Makefile
      mmc: host: omap-hsmmc: remove init_card pdata callback from pdata
      mmc: sdio: fix wl1251 vendor id
      mmc: core: fix wl1251 sdio quirks
      net: wireless: ti: wl1251 use new SDIO_VENDOR_ID_TI_WL1251 definition
      net: wireless: ti: remove local VENDOR_ID and DEVICE_ID definitions

Ivan Mikhaylov (2):
      mmc: sdhci-of-aspeed: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
      mmc: sdhci-of-aspeed: add inversion signal presence

Krzysztof Kozlowski (1):
      memstick: Fix Kconfig indentation

Ludovic Barre (3):
      mmc: mmci: add hardware busy timeout feature
      mmc: mmci: add busy_complete callback
      mmc: mmci: sdmmc: add busy_complete callback

Manish Narani (9):
      mmc: sdhci-of-arasan: Separate out clk related data to another structure
      dt-bindings: mmc: arasan: Update Documentation for the input clock
      mmc: sdhci-of-arasan: Add sampling clock for a phy to use
      dt-bindings: mmc: Add optional generic properties for mmc
      mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
      firmware: xilinx: Add SDIO Tap Delay nodes
      dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
      mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup
      dt-bindings: mmc: Correct the type of the clk phase properties

Manivannan Sadhasivam (3):
      dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
      mmc: Add Actions Semi Owl SoCs SD/MMC driver
      MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding

Markus Elfring (1):
      mmc: cavium-octeon: Use devm_platform_ioremap_resource()

Nicolas Ferre (2):
      dt-bindings: sdhci-of-at91: add the microchip,sdcal-inverted property
      mmc: sdhci-of-at91: add DT property to enable calibration on full reset

Peng Fan (1):
      dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible string

Peter Ujfalusi (2):
      mmc: atmel-mci: Use dma_request_chan() directly for channel request
      mmc: moxart: Use dma_request_chan() directly for channel request

Ramuthevar Vadivel Murugan (2):
      dt-bindings: mmc: sdhci-of-arasan: Add new compatible for Intel LGM SDXC
      mmc: sdhci-of-arasan: Add Support for Intel LGM SDXC

Raul E Rangel (2):
      mmc: sdhci: Check card status after reset
      mmc: sdhci-pci: Quirk for AMD SDHC Device 0x7906

Saiyam Doshi (1):
      mmc: bcm2835: Use devm_platform_ioremap_resource wrapper

Takao Orito (2):
      dt-bindings: mmc: add DT bindings for Milbeaut SD controller
      mmc: sdhci-milbeaut: add Milbeaut SD controller driver

Thierry Reding (1):
      mmc: mmc_spi: Use proper debounce time for CD GPIO

Ulf Hansson (6):
      mmc: vub300: Drop redundant host ops ->init_card()
      MAINTAINERS: Mark vub300 mmc driver as orphan
      mwifiex: Re-work support for SDIO HW reset
      mmc: core: Drop check for mmc_card_is_removable() in mmc_rescan()
      mmc: core: Re-work HW reset for SDIO cards
      Merge branch 'fixes' into next

Wolfram Sang (2):
      mmc: tmio: remove workaround for NON_REMOVABLE
      Revert "mmc: tmio: remove workaround for NON_REMOVABLE"

Yangbo Lu (2):
      mmc: sdhci-of-esdhc: poll ESDHC_FLUSH_ASYNC_FIFO bit until completion
      mmc: sdhci-of-esdhc: fix up erratum A-008171 workaround

Zhou Yanjie (6):
      mmc: jz4740: Add 8bit mode support
      dt-bindings: mmc: jz4740: Add bindings for JZ4760
      mmc: jz4740: Add support for JZ4760
      dt-bindings: mmc: jz4740: Add bindings for X1000
      mmc: jz4740: Add support for X1000
      mmc: jz4740: Add support for Low Power Mode (LPM)

zhengbin (1):
      mmc: sdhci-pci: Make function amd_sdhci_reset static

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  42 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   3 +
 Documentation/devicetree/bindings/mmc/jz4740.txt   |   8 +-
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  14 +
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |  59 ++
 .../devicetree/bindings/mmc/renesas,sdhi.txt       |   1 +
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |   5 +
 .../devicetree/bindings/mmc/sdhci-milbeaut.txt     |  30 +
 .../devicetree/bindings/net/wireless/ti,wl1251.txt |  26 +
 MAINTAINERS                                        |   6 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        |  36 +-
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/common.h                       |   1 -
 arch/arm/mach-omap2/hsmmc.c                        | 171 -----
 arch/arm/mach-omap2/hsmmc.h                        |  32 -
 arch/arm/mach-omap2/pdata-quirks.c                 | 105 ----
 drivers/memstick/core/Kconfig                      |  18 +-
 drivers/memstick/host/Kconfig                      |   4 +-
 drivers/memstick/host/jmb38x_ms.c                  |  12 +-
 drivers/mmc/core/block.c                           | 151 ++---
 drivers/mmc/core/core.c                            |  12 +-
 drivers/mmc/core/core.h                            |   2 +
 drivers/mmc/core/mmc.c                             |   9 +-
 drivers/mmc/core/quirks.h                          |   7 +
 drivers/mmc/core/sdio.c                            |  28 +-
 drivers/mmc/core/sdio_bus.c                        |   9 +-
 drivers/mmc/host/Kconfig                           |  21 +
 drivers/mmc/host/Makefile                          |   2 +
 drivers/mmc/host/atmel-mci.c                       |   3 +-
 drivers/mmc/host/bcm2835.c                         |   4 +-
 drivers/mmc/host/cavium-octeon.c                   |  15 +-
 drivers/mmc/host/dw_mmc.c                          |   4 +-
 drivers/mmc/host/jz4740_mmc.c                      |  41 +-
 drivers/mmc/host/mmc_spi.c                         |   2 +-
 drivers/mmc/host/mmci.c                            | 198 +++---
 drivers/mmc/host/mmci.h                            |   5 +
 drivers/mmc/host/mmci_stm32_sdmmc.c                |  46 +-
 drivers/mmc/host/moxart-mmc.c                      |   4 +-
 drivers/mmc/host/omap_hsmmc.c                      |  31 +-
 drivers/mmc/host/owl-mmc.c                         | 696 +++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   1 +
 drivers/mmc/host/sdhci-esdhc.h                     |  14 +
 drivers/mmc/host/sdhci-milbeaut.c                  | 362 +++++++++++
 drivers/mmc/host/sdhci-of-arasan.c                 | 493 ++++++++++++++-
 drivers/mmc/host/sdhci-of-aspeed.c                 |  12 +
 drivers/mmc/host/sdhci-of-at91.c                   |  19 +
 drivers/mmc/host/sdhci-of-esdhc.c                  | 257 ++++++--
 drivers/mmc/host/sdhci-pci-core.c                  |  53 +-
 drivers/mmc/host/sdhci-pci.h                       |   2 +
 drivers/mmc/host/sdhci.c                           |  15 +-
 drivers/mmc/host/sdhci_am654.c                     |  71 ++-
 drivers/mmc/host/sdhci_f_sdh30.c                   |  26 +-
 drivers/mmc/host/sdhci_f_sdh30.h                   |  32 +
 drivers/mmc/host/tmio_mmc_core.c                   |   2 +-
 drivers/mmc/host/vub300.c                          |   7 -
 drivers/net/wireless/marvell/mwifiex/main.c        |   5 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |   1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  33 +-
 drivers/net/wireless/ti/wl1251/sdio.c              |  25 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   8 -
 include/linux/firmware/xlnx-zynqmp.h               |  13 +-
 include/linux/mmc/card.h                           |   3 +-
 include/linux/mmc/sdio_ids.h                       |   2 +
 include/linux/platform_data/hsmmc-omap.h           |   3 -
 64 files changed, 2631 insertions(+), 694 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
 delete mode 100644 arch/arm/mach-omap2/hsmmc.c
 delete mode 100644 arch/arm/mach-omap2/hsmmc.h
 create mode 100644 drivers/mmc/host/owl-mmc.c
 create mode 100644 drivers/mmc/host/sdhci-milbeaut.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
