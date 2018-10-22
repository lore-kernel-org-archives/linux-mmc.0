From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v4.20
Date: Mon, 22 Oct 2018 14:13:46 +0200
Message-ID: <20181022121346.3508-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus <torvalds@linux-foundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Greg,

Here's a PR with the MMC updates for v4.20. Details about the highlights are as
usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 4f666675cdff0b986195413215eb062b7da6586f:

  libertas: call into generic suspend code before turning off power (2018-10-10 14:01:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20

for you to fetch changes up to fd82cc3020a024fc97fbc0a5242c26d06bb5e203:

  mmc: mediatek: drop too much code of tuning method (2018-10-15 15:00:29 +0200)

----------------------------------------------------------------
MMC core:
 - Introduce a host helper function to share re-tuning progress

MMC host:
 - sdhci: Add support for v4 host mode
 - sdhci-of-arasan: Add Support for AM654 MMC and PHY
 - sdhci-sprd: Add support for Spreadtrum's host controller
 - sdhci-tegra: Add support for HS400 enhanced strobe
 - sdhci-tegra: Enable UHS/HS200 modes for Tegra186/210
 - sdhci-tegra: Add support for HS400 delay line calibration
 - sdhci-tegra: Add support for pad calibration
 - sdhci-of-dwcmshc: Address 128MB DMA boundary limitation
 - sdhci-of-esdhc: Add support for tuning erratum A008171
 - sdhci-iproc: Add ACPI support
 - mediatek: Add support for MT8183
 - mediatek: Improve the support for tuning
 - mediatek: Add bus clock control for MT2712
 - jz4740: Add support for the JZ4725B
 - mmci: Add support for the stm32 sdmmc variant
 - mmci: Add support for an optional reset control
 - mmci: Add some new variant specific properties/callbacks
 - mmci: Re-structure DMA code to prepare for new variants
 - renesas_sdhi: Add support for r8a77470, r8a7744 and r8a774a1
 - renesas_sdhi_internal_dmac: Whitelist r8a77970 and r8a774a1
 - tmio/uniphier-sd: Add new UniPhier SD/eMMC controller driver
 - tmio/renesas_sdhi: Deal properly with SCC detection during re-tune
 - tmio/renesas_sdhi: Refactor/consolidate clock management
 - omap_hsmmc: Drop cover detection and some unused platform data
 - dw_mmc-exynos: Enable tuning for more speed modes
 - sunxi: Clarify the new timing mode and enable it for the A64 controller
 - various: Convert to slot GPIO descriptors

----------------------------------------------------------------
Aapo Vienamo (26):
      mmc: sdhci: Export sdhci_request()
      dt-bindings: mmc: tegra: Add pad voltage control properties
      dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
      dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
      mmc: tegra: Reconfigure pad voltages during voltage switching
      mmc: tegra: Poll for calibration completion
      mmc: tegra: Set calibration pad voltage reference
      mmc: tegra: Power on the calibration pad
      mmc: tegra: Disable card clock during pad calibration
      mmc: tegra: Program pad autocal offsets from dt
      mmc: tegra: Perform pad calibration after voltage switch
      mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
      mmc: tegra: Add a workaround for tap value change glitch
      mmc: tegra: Parse default trim and tap from dt
      mmc: tegra: Configure default tap values
      mmc: tegra: Configure default trim value on reset
      mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
      mmc: tegra: Remove tegra_sdhci_writew() from tegra210_sdhci_ops
      mmc: tegra: Disable card clock during tuning cmd on Tegra210
      mmc: tegra: Enable UHS and HS200 modes for Tegra210
      mmc: tegra: Enable UHS and HS200 modes for Tegra186
      dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
      mmc: tegra: Parse and program DQS trim value
      mmc: tegra: Implement HS400 enhanced strobe
      mmc: tegra: Implement HS400 delay line calibration
      mmc: tegra: Implement periodic pad calibration

Adrian Hunter (1):
      mmc: sdhci-pltfm: Convert DT properties to generic device properties

Anand Moon (1):
      mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

Biju Das (2):
      dt-bindings: mmc: renesas_sdhi: Add r8a7744 support
      dt-bindings: mmc: sh_mmcif: Document r8a7744 DT bindings

Chaotian Jing (8):
      mmc: dt-bindings: add "bus-clk" for MT2712
      mmc: mediatek: add bus_clk control
      mmc: dt-bindings: add support for MT8183 SoC
      mmc: mediatek: fill the actual clock for mmc debugfs
      mmc: mediatek: fix cannot receive new request when msdc_cmd_is_ready fail
      mmc: mediatek: tune CMD/DATA together
      mmc: mediatek: add MT8183 MMC driver support
      mmc: mediatek: drop too much code of tuning method

Chen-Yu Tsai (2):
      mmc: sunxi: Clarify new timing mode usage and implementation
      mmc: sunxi: Use new timing mode for A64 eMMC controller

Chunyan Zhang (9):
      mmc: sdhci: Add version V4 definition
      mmc: sdhci: Add sd host v4 mode
      mmc: sdhci: Change SDMA address register for v4 mode
      mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
      mmc: sdhci: Add 32-bit block count support for v4 mode
      mmc: sdhci: Add Auto CMD Auto Select support
      mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
      dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
      mmc: sdhci-sprd: Add Spreadtrum's initial host controller

Fabrizio Castro (4):
      mmc: renesas_sdhi_internal_dmac: Whitelist r8a774a1
      mmc: renesas_sdhi: Add r8a774a1 support
      dt-bindings: mmc: renesas_sdhi: Add r8a77470 support
      mmc: renesas_sdhi: Add r8a77470 SDHI1 support

Faiz Abbas (3):
      dt-bindings: mmc: sdhci-of-arasan: Add new compatible for AM654 MMC PHY
      mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata and soc_ctl_map
      mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY

Gustavo A. R. Silva (2):
      mmc: tifm_sd: Mark expected switch fall-through
      mmc: meson-mx-sdio: mark expected switch fall-through

Igor Opaniuk (1):
      mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 cap

Jisheng Zhang (4):
      mmc: sdhci: add adma_table_cnt member to struct sdhci_host
      mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
      mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation
      mmc: sdhci: fix __sdhci_adma_write_desc

Linus Walleij (6):
      mmc: mmci: Drop support for pdata GPIO numbers
      mmc: sdhci: spear: Use the slot GPIO descriptor
      mmc: sdhci: pxav3: Delete GPIO handling
      mmc: sdhci: sirf: Use the slot GPIO descriptor
      mmc: omap_hsmmc: Kill off cover detection
      mmc: omap_hsmmc: Delete platform data GPIO CD and WP

Lubomir Rintel (1):
      mmc: core: Allow building PWRSEQ_SD8787 with LIBERTAS_SDIO

Ludovic Barre (26):
      mmc: mmci: internalize dma map/unmap into mmci dma functions
      mmc: mmci: internalize dma_inprogress into mmci dma functions
      mmc: mmci: Change struct members from bool to u8
      mmc: mmci: create common mmci_dma_setup/release
      mmc: mmci: introduce dma_priv pointer to mmci_host
      mmc: mmci: merge prepare data functions
      mmc: mmci: add prepare/unprepare_data callbacks
      mmc: mmci: add get_next_data callback
      mmc: mmci: add dma_start callback
      mmc: mmci: add dma_finalize callback
      mmc: mmci: add dma_error callback
      mmc: mmci: add validate_data callback
      mmc: mmci: add set_clk/pwrreg callbacks
      mmc: mmci: add datactrl block size variant property
      mmc: mmci: expand startbiterr to irqmask and error check
      mmc: mmci: add variant properties to define cpsm & cmdresp bits
      mmc: mmci: add variant property to define dpsm bit
      mmc: mmci: add variant property to define irq pio mask
      mmc: mmci: add variant property to write datactrl before command
      mmc: mmci: add variant property to not read datacnt
      dt-bindings: mmci: add optional reset property
      mmc: mmci: add optional reset property
      mmc: mmci: add clock divider for stm32 sdmmc
      mmc: mmci: add stm32 sdmmc registers
      dt-bindings: mmci: add stm32 sdmmc variant
      mmc: mmci: add stm32 sdmmc variant

Masaharu Hayakawa (2):
      mmc: renesas_sdhi: skip SCC error check when retuning
      mmc: tmio: Fix SCC error detection

Masahiro Yamada (11):
      mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
      mmc: tmio: move tmio_mmc_set_clock() to platform hook
      dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
      mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
      mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
      mmc: tmio: refactor CLK_CTL bit calculation
      mmc: tmio: move MFD variant reset to a platform hook
      mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
      mmc: tmio: simplify the DMA mode test
      mmc: uniphier-sd: fix DMA disabling
      mmc: uniphier-sd: avoid using broken DMA RX channel

Michal Simek (1):
      mmc: sdhci-of-arasan: Do now show error message in case of deffered probe

Niklas Söderlund (2):
      mmc: core: add helper to see if a host is doing a retune
      mmc: renesas_sdhi_internal_dmac: set scatter/gather max segment size

Paul Cercueil (2):
      mmc: jz4740: Drop dependency on MACH_JZ4740/80
      mmc: jz4740: Add support for the JZ4725B

Rob Herring (1):
      mmc: Convert to using %pOFn instead of device_node.name

Sergei Shtylyov (3):
      mmc: renesas_sdhi_internal_dmac: Fix a few typos
      mmc: renesas_sdhi_internal_dmac: add R8A77970 to whitelist
      dt-bindings: mmc: tmio_mmc: document Renesas R8A77970 bindings

Srinath Mannam (1):
      mmc: sdhci-iproc: Add ACPI support

Ulf Hansson (2):
      Merge branch 'fixes' into next
      Merge branch 'fixes' into next

Wang Dongsheng (2):
      sdhci: acpi: add free_slot callback
      sdhci: acpi: add qcom sdhci host reset quirk fix

Wolfram Sang (3):
      mmc: use SPDX identifier for Renesas drivers
      mmc: tmio: more concise clk calculation
      mmc: tmio: remove now unused variable

Yinbo Zhu (2):
      mmc: sdhci: add tuning error codes
      mmc: sdhci-of-esdhc: add erratum A008171 support

Yu Zhao (1):
      mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01

YueHaibing (1):
      mmc: tegra: fix inconsistent IS_ERR and PTR_ERR

jun qian (1):
      mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in ISR

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   1 +
 Documentation/devicetree/bindings/mmc/jz4740.txt   |   1 +
 Documentation/devicetree/bindings/mmc/mmci.txt     |  11 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |   2 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  72 +++
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   4 +-
 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  10 +-
 .../devicetree/bindings/mmc/uniphier-sd.txt        |  55 ++
 MAINTAINERS                                        |   1 +
 arch/arm/mach-integrator/integrator_cp.c           |   2 -
 arch/arm/mach-omap2/hsmmc.h                        |   2 -
 arch/arm/mach-omap2/pdata-quirks.c                 |   2 -
 arch/arm/mach-versatile/versatile_dt.c             |   4 -
 drivers/mmc/core/Kconfig                           |   2 +-
 drivers/mmc/host/Kconfig                           |  40 +-
 drivers/mmc/host/Makefile                          |   3 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  11 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   8 +
 drivers/mmc/host/jz4740_mmc.c                      |   5 +-
 drivers/mmc/host/meson-mx-sdio.c                   |   2 +-
 drivers/mmc/host/mmci.c                            | 698 ++++++++++++++-------
 drivers/mmc/host/mmci.h                            | 174 +++--
 drivers/mmc/host/mmci_qcom_dml.c                   |  17 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                | 282 +++++++++
 drivers/mmc/host/mtk-sd.c                          | 298 +++++++--
 drivers/mmc/host/mxcmmc.c                          |   5 +-
 drivers/mmc/host/omap_hsmmc.c                      | 171 +----
 drivers/mmc/host/renesas_sdhi.h                    |   5 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  66 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  30 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  15 +-
 drivers/mmc/host/sdhci-acpi.c                      |  68 ++
 drivers/mmc/host/sdhci-esdhc.h                     |   1 +
 drivers/mmc/host/sdhci-iproc.c                     |  59 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  96 ++-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  39 ++
 drivers/mmc/host/sdhci-of-esdhc.c                  |  44 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   3 +
 drivers/mmc/host/sdhci-pltfm.c                     |  68 +-
 drivers/mmc/host/sdhci-pltfm.h                     |   7 +-
 drivers/mmc/host/sdhci-pxav3.c                     |  14 -
 drivers/mmc/host/sdhci-sirf.c                      |  28 +-
 drivers/mmc/host/sdhci-spear.c                     |  33 +-
 drivers/mmc/host/sdhci-sprd.c                      | 498 +++++++++++++++
 drivers/mmc/host/sdhci-tegra.c                     | 675 ++++++++++++++++++--
 drivers/mmc/host/sdhci-xenon-phy.c                 |   4 +-
 drivers/mmc/host/sdhci.c                           | 289 ++++++---
 drivers/mmc/host/sdhci.h                           |  37 +-
 drivers/mmc/host/sh_mmcif.c                        |   7 +-
 drivers/mmc/host/sunxi-mmc.c                       |  24 +-
 drivers/mmc/host/tifm_sd.c                         |   3 +-
 drivers/mmc/host/tmio_mmc.c                        |  80 ++-
 drivers/mmc/host/tmio_mmc.h                        |  16 +-
 drivers/mmc/host/tmio_mmc_core.c                   | 129 +---
 drivers/mmc/host/uniphier-sd.c                     | 698 +++++++++++++++++++++
 drivers/mmc/host/usdhi6rol0.c                      |   5 +-
 include/linux/amba/mmci.h                          |  11 +-
 include/linux/mfd/tmio.h                           |   7 -
 include/linux/mmc/host.h                           |   5 +
 include/linux/platform_data/hsmmc-omap.h           |   3 -
 include/linux/platform_data/pxa_sdhci.h            |   4 -
 62 files changed, 4047 insertions(+), 948 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
 create mode 100644 drivers/mmc/host/mmci_stm32_sdmmc.c
 create mode 100644 drivers/mmc/host/sdhci-sprd.c
 create mode 100644 drivers/mmc/host/uniphier-sd.c
