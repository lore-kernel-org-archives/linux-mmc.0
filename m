From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v4.19
Date: Fri, 17 Aug 2018 12:23:14 +0200
Message-ID: <20180817102314.3979-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with the updates for MMC for v4.19. Details about the highlights are
as usual found in the signed tag.

Note, this time I have also merged an immutable branch/tag for switching the
pxa platforms to DMA slave maps, by Robert Jarzmik. This was needed due to
dependency for additional changes of the pxamci mmc driver.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3b1074bf9817bf43d4da375aa5f4b6c88f1d953e:

  mmc: mxcmmc: Fix missing parentheses and brace (2018-07-16 11:45:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19

for you to fetch changes up to 7f38abf220e2c800a2c451372e9f07ed5fd0ea49:

  mmc: core: improve reasonableness of bus width setting for HS400es (2018-08-01 14:15:28 +0200)

----------------------------------------------------------------
MMC core:
 - Add some fine-grained hooks to further support HS400 tuning
 - Improve error path for bus width setting for HS400es
 - Use a common method when checking R1 status

MMC host:
 - renesas_sdhi: Add r8a77990 support
 - renesas_sdhi: Add eMMC HS400 mode support
 - tmio/renesas_sdhi: Improve tuning/clock management
 - tmio: Add eMMC HS400 mode support
 - sunxi: Add support for 3.3V eMMC DDR mode
 - mmci: Initial support to manage variant specific callbacks
 - sdhci: Don't try 3.3V I/O voltage if not supported
 - sdhci-pci-dwc-mshc: Add driver to support Synopsys dwc mshc SDHCI PCI
 - sdhci-of-dwcmshc: Add driver to support Synopsys DWC MSHC SDHCI
 - sdhci-msm: Add support for new version sdcc V5
 - sdhci-pci-o2micro: Add support for O2 eMMC HS200 mode
 - sdhci-pci-o2micro: Add support for O2 hardware tuning
 - sdhci-pci-o2micro: Add MSI interrupt support for O2 SD host
 - sdhci-pci: Add support for Intel ICP
 - sdhci-tegra: Prevent ACMD23 and HS200 mode on Tegra 3
 - sdhci-tegra: Fix eMMC DDR52 mode
 - sdhci-tegra: Improve clock management
 - dw_mmc-rockchip: Document compatible string for px30
 - sdhci-esdhc-imx: Add support for 3.3V eMMC DDR mode
 - sdhci-of-esdhc: Set proper DMA mask for ls104x chips
 - sdhci-of-esdhc: Improve clock management
 - sdhci-of-arasan: Add a quirk to manage unstable clocks
 - dw_mmc-exynos: Address potential external abort during system resume
 - pxamci: Add support for common MMC DT bindings
 - pxamci: Several cleanups and improvements
 - pxamci: Merge immutable branch for pxa to switch to DMA slave maps

----------------------------------------------------------------
Aapo Vienamo (3):
      mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
      mmc: tegra: Add and use tegra_sdhci_get_max_clock()
      mmc: tegra: Force correct divider calculation on DDR50/52

Adrian Hunter (1):
      mmc: sdhci-pci: Add support for Intel ICP

Andre Przywara (1):
      mmc: sunxi: remove output of virtual base address

Daniel Mack (9):
      mmc: pxamci: remove irq from private context
      mmc: pxamci: remove dma resources from private context
      mmc: pxamci: remove dead code from pxamci_remove()
      mmc: pxamci: fix indenting
      mmc: pxamci: call mmc_of_parse()
      mmc: pxamci: remove pxa-mmc, gpio-power from devicetree bindings
      mmc: pxamci: let mmc core handle regulators
      mmc: pxamci: make GPIO lookups from pdata optional
      mmc: pxamci: provide a short-hand for &pdev->dev

Fabio Estevam (1):
      mmc: sdhci-esdhc-imx: Switch to SPDX identifier

Gustavo A. R. Silva (1):
      mmc: sdhci-xenon: mark expected switch fall-through

Helmut Grohne (2):
      dt-bindings: mmc: broken clock stable indicator on arasan controllers
      mmc: sdhci-of-arasan: Add quirk for unstable clocks

Hongjie Fang (1):
      mmc: core: improve reasonableness of bus width setting for HS400es

Icenowy Zheng (1):
      mmc: sunxi: allow 3.3V DDR when DDR is available

Jisheng Zhang (2):
      dt: bindings: Add bindings for SDHCI Synopsys DWC MSHC
      mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver

Laurentiu Tudor (1):
      mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips

Liang Chen (1):
      dt-bindings: mmc: rockchip-dw-mshc: add description for px30

Marek Szyprowski (1):
      mmc: dw_mmc-exynos: fix potential external abort in resume_noirq()

Masaharu Hayakawa (3):
      mmc: tmio: add eMMC HS400 mode support
      mmc: renesas_sdhi: add eMMC HS400 mode support
      mmc: tmio: Fix tuning flow

Masahiro Yamada (1):
      mmc: tmio: remove unneeded variable in tmio_mmc_start_command()

Niklas Söderlund (1):
      mmc: renesas_sdhi: Fix sampling clock position selecting

Prabu Thangamuthu (1):
      mmc: sdhci-pci-dwc-mshc: synopsys dwc mshc support

Robert Jarzmik (10):
      dmaengine: pxa: use a dma slave map
      ARM: pxa: add dma slave map
      dmaengine: pxa: add a default requestor policy
      mmc: pxamci: remove the dmaengine compat need
      media: pxa_camera: remove the dmaengine compat need
      mtd: rawnand: marvell: remove the dmaengine compat need
      ata: pata_pxa: remove the dmaengine compat need
      dmaengine: pxa: document pxad_param
      ARM: pxa: remove the DMA IO resources
      ARM: pxa: change SSP DMA channels allocation

Sayali Lokhande (3):
      mmc: sdhci-msm: Define new Register address map
      Documentation: sdhci-msm: Add new compatible string for SDCC v5
      mmc: host: Register changes for sdcc V5

Shawn Lin (1):
      mmc: core: Adjust and reuse the macro of R1_STATUS(x)

Simon Horman (1):
      mmc: core: more fine-grained hooks for HS400 tuning

Stefan Agner (8):
      mmc: sdhci-esdhc-imx: support eMMC DDR mode when running at 3.3V
      mmc: sdhci-esdhc-imx: get rid of support_vsel
      mmc: sdhci: do not try to use 3.3V signaling if not supported
      mmc: tegra: prevent HS200 on Tegra 3
      mmc: tegra: fix eMMC DDR52 mode
      mmc: tegra: prevent ACMD23 on Tegra 3
      mmc: sdhci-esdhc-imx: disable clocks before changing frequency
      mmc: sdhci-esdhc-imx: fix indent

Ulf Hansson (6):
      Merge tag 'pxa-for-4.19-dma_slave_map' of https://github.com/rjarzmik/linux
      Merge branch 'next_pxa_dma' into next
      mmc: core: Drop the unused mmc_power_save|restore_host()
      Merge branch 'fixes' into next
      mmc: mmci: Initial support to manage variant specific callbacks
      mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml

Vijay Viswanath (1):
      mmc: sdhci-msm: Add msm version specific ops and data structures

Wolfram Sang (1):
      mmc: renesas_sdhi: Add r8a77990 support

ernest.zhang (5):
      mmc: sdhci: Add support for O2 eMMC HS200 mode
      mmc: sdhci: Change O2 Host HS200 mode clock frequency to 200MHz
      mmc: sdhci: Export sdhci tuning function symbol
      mmc: sdhci: Add support for O2 hardware tuning
      mmc: sdhci: Add MSI interrupt support for O2 SD host

weiyongjun (A) (1):
      mmc: sdhci-msm: Remove redundant dev_err call in sdhci_msm_probe()

yinbo.zhu (1):
      mmc: sdhci-of-esdhc: modify the sd clock in of_match_node way

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   2 +
 Documentation/devicetree/bindings/mmc/pxa-mmc.txt  |   6 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   |  20 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/mach-pxa/devices.c                        | 148 +-----
 arch/arm/mach-pxa/devices.h                        |   6 +-
 arch/arm/mach-pxa/pxa25x.c                         |  38 +-
 arch/arm/mach-pxa/pxa27x.c                         |  39 +-
 arch/arm/mach-pxa/pxa3xx.c                         |  41 +-
 arch/arm/plat-pxa/ssp.c                            |  47 --
 drivers/ata/pata_pxa.c                             |  10 +-
 drivers/dma/pxa_dma.c                              |  15 +-
 drivers/media/platform/pxa_camera.c                |  22 +-
 drivers/mmc/core/core.c                            |  48 +-
 drivers/mmc/core/core.h                            |   2 -
 drivers/mmc/core/mmc.c                             |  16 +-
 drivers/mmc/core/mmc_ops.c                         |   2 +-
 drivers/mmc/core/sdio.c                            |   1 -
 drivers/mmc/host/Kconfig                           |  11 +
 drivers/mmc/host/Makefile                          |   4 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  33 +-
 drivers/mmc/host/mmci.c                            |  82 +---
 drivers/mmc/host/mmci.h                            |  81 +++-
 drivers/mmc/host/mmci_qcom_dml.c                   |  18 +-
 drivers/mmc/host/mmci_qcom_dml.h                   |   5 +-
 drivers/mmc/host/pxamci.c                          | 236 ++++------
 drivers/mmc/host/renesas_sdhi_core.c               | 139 +++++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  20 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  17 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  29 +-
 drivers/mmc/host/sdhci-msm.c                       | 510 ++++++++++++++++-----
 drivers/mmc/host/sdhci-of-arasan.c                 |  16 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 116 +++++
 drivers/mmc/host/sdhci-of-esdhc.c                  |  91 ++--
 drivers/mmc/host/sdhci-pci-core.c                  |   3 +
 drivers/mmc/host/sdhci-pci-dwc-mshc.c              |  84 ++++
 drivers/mmc/host/sdhci-pci-o2micro.c               | 129 +++++-
 drivers/mmc/host/sdhci-pci.h                       |   5 +
 drivers/mmc/host/sdhci-tegra.c                     |  37 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |   1 +
 drivers/mmc/host/sdhci.c                           |  25 +-
 drivers/mmc/host/sdhci.h                           |   5 +
 drivers/mmc/host/sunxi-mmc.c                       |   7 +-
 drivers/mmc/host/tmio_mmc.h                        |   6 +
 drivers/mmc/host/tmio_mmc_core.c                   |  52 ++-
 drivers/mtd/nand/raw/marvell_nand.c                |  17 +-
 include/linux/dma/pxa-dma.h                        |   9 +
 include/linux/mfd/tmio.h                           |   3 +
 include/linux/mmc/host.h                           |  10 +-
 include/linux/mmc/mmc.h                            |   2 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   2 -
 include/linux/platform_data/mmp_dma.h              |   4 +
 include/linux/pxa2xx_ssp.h                         |   2 -
 sound/soc/pxa/pxa-ssp.c                            |   5 +-
 57 files changed, 1531 insertions(+), 764 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c
 create mode 100644 drivers/mmc/host/sdhci-pci-dwc-mshc.c
