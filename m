From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.4
Date: Mon, 2 Nov 2015 10:35:37 +0100
Message-ID: <CAPDyKFqEUeaA3HuPw9HPCKT3dUFpt54=0t7DLW2zyBErP=mwsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35650 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbKBJfh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2015 04:35:37 -0500
Received: by ykek133 with SMTP id k133so134688739yke.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2015 01:35:37 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>

Hi Linus,

Here are the PR for MMC for v4.4.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 32b88194f71d6ae7768a29f87fbba454728273ee:

  Linux 4.3-rc7 (2015-10-25 10:39:47 +0900)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.4

for you to fetch changes up to 7cc8d580228cc712edcf7a1856a3bdb38c164e83:

  mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode (2015-10-29
11:00:43 +0100)

----------------------------------------------------------------
MMC core:
 - Add new API to set VCCQ voltage - mmc_regulator_set_vqmmc()
 - Add new ioctl to allow userspace to send multi commands
 - Wait for card busy signalling before starting SDIO requests
 - Remove MMC_CLKGATE
 - Enable tuning for DDR50 mode
 - Some code clean-up/improvements to mmc pwrseq
 - Use highest priority for eMMC restart handler
 - Add DT bindings for eMMC hardware reset support
 - Extend the mmc_send_tuning() API
 - Improve ios show for debugfs
 - A couple of code optimizations

MMC host:
 - Some generic OF improvements
 - Various code clean-ups
 - sirf: Add support for DDR50
 - sunxi: Add support for card busy detection
 - mediatek: Use MMC_CAP_RUNTIME_RESUME
 - mediatek: Add support for eMMC HW-reset
 - mediatek: Add support for HS400
 - dw_mmc: Convert to use the new mmc_regulator_set_vqmmc() API
 - dw_mmc: Add external DMA interface support
 - dw_mmc: Some various improvements
 - dw_mmc-rockchip: MMC tuning with the clock phase framework
 - sdhci: Properly clear IRQs during resume
 - sdhci: Enable tuning for DDR50 mode
 - sdhci-of-esdhc: Use IRQ mode for card detection
 - sdhci-of-esdhc: Support both BE and LE host controller
 - sdhci-pci: Build o2micro support in the same module
 - sdhci-pci: Support for new Intel host controllers
 - sdhci-acpi: Support for new Intel host controllers

----------------------------------------------------------------
Adrian Hunter (3):
      mmc: sdhci-pci: Add another PCI ID for an Intel eMMC host controller
      mmc: sdhci-pci: Add more PCI IDs for Intel controllers
      mmc: sdhci-acpi: Add more ACPI HIDs for Intel controllers

Alexandru M Stan (3):
      mmc: dw_mmc-rockchip: dt-binding: Add tuning related things
      mmc: dw_mmc-rockchip: MMC tuning with the clock phase framework
      ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices

Ben Hutchings (2):
      mmc: sdhci-pci: Build o2micro support in the same module
      mmc: sdhci-pci: Make sdhci_pci_o2_fujin2_pci_init() static

Chaotian Jing (9):
      mmc: mediatek: Add MMC_CAP_RUNTIME_RESUME support
      mmc: core: Add DT bindings for eMMC hardware reset support
      mmc: dt-bindings: update Mediatek MMC bindings
      mmc: mediatek: make cmd_ints_mask to const
      mmc: mediatek: change the argument "ddr" to "timing"
      mmc: mediatek: fix got GPD checksum error interrupt when data transfer
      mmc: mediatek: add implement of ops->hw_reset()
      mmc: mmc: extend the mmc_send_tuning()
      mmc: mediatek: add HS400 support

Dan Carpenter (2):
      mmc: sdhci-of-at91: remove a line of dead code
      mmc: dw_mmc: NULL dereference in error message

Douglas Anderson (4):
      clk: rockchip: Allow more precision for some mmc clock phases
      clk: rockchip: Make calculations use rounding
      mmc: core: Add mmc_regulator_set_vqmmc()
      mmc: dw_mmc: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch

Grant Grundler (1):
      mmc: block: copy resp[] data on err for MMC_IOC_MULTI_CMD

Haibo Chen (1):
      mmc: sdhci: call sdhci_init() before request irq

Hans de Goede (3):
      mmc: Add mmc_is_io_op helper function
      mmc: Wait for card_busy before starting sdio requests
      mmc: sunxi: Add card busy detection

Heiko Stuebner (2):
      mmc: core: move ocr-bit to voltage translation into separate function
      ARM: dts: rockchip: add tuning related settings to veyron devices

Jaehoon Chung (2):
      mmc: dw_mmc: fix the CardThreshold boundary at CardThrCtl register
      mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode

Javier Martinez Canillas (7):
      mmc: wbsd: Remove unneded semicolon
      mmc: vub300: Remove unneded semicolons
      mmc: pwrseq: use gpiod_get() instead of index 0
      mmc: sdhci-bcm-kona: fix logic to check for 8-bit data width
      mmc: mmc_spi: Export OF module alias information
      mmc: pwrseq_simple: use GPIO descriptors array API
      mmc: pwrseq: Use highest priority for eMMC restart handler

Jon Hunter (1):
      mmc: block: Add new ioctl to send multi commands

Lokesh Vutla (1):
      mmc: omap_hsmmc: Enable omap_hsmmc for Keystone 2

Luis de Bethencourt (3):
      mmc: moxart: Fix module autoload for OF platform driver
      mmc: omap: Fix module autoload for OF platform driver
      mmc: android-goldfish: Allow compiling the driver with COMPILE_TEST

Michele Curti (1):
      mmc: sdhci-acpi: detect sd card reader on asus x205ta

Sergei Shtylyov (3):
      mmc: skip reclaiming host on mmc_add_card() error
      DT: mmc: sh_mmcif: fix "compatible" property text
      DT: mmc: sh_mmcif: document R8A7794 support

Shawn Lin (10):
      mmc: debugfs: implement ios show for driver type
      mmc: debugfs: implement ios show for SDR12 and SDR25
      mmc: dw_mmc: Add external dma interface support
      mmc: dw_mmc: use macro for HCON register operations
      Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
      mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
      arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC

Tobias Klauser (1):
      mmc: sdhci-pltfm: Use of_property_read_u32 instead of open-coding it

Ulf Hansson (3):
      mmc: core: Keep host claimed while invoking mmc_power_off|up()
      mmc: core: Convert __mmc_switch() into an internal core function
      mmc: core: Remove MMC_CLKGATE

Weijun Yang (3):
      mmc: core: enable CMD19 tuning for DDR50 mode
      mmc: sdhci: enable tuning for DDR50
      mmc: sirf: fix the capbility to support DDR50

Yangbo Lu (1):
      mmc: sdhci-pltfm: enable interrupt mode to detect card for ls1021a

Yousong Zhou (1):
      mmc: sd: Remove superfluous error code assignment

kbuild test robot (1):
      mmc: sdhci-pci: fix simple_return.cocci warnings

yangbo lu (5):
      mmc: dt: add DT binding for little-endian eSDHC host controller
      mmc: sdhci-of-esdhc: support both BE and LE host controller
      mmc: kconfig: reconfigure MMC_SDHCI_OF_ESDHC option
      mmc: sdhci-of-esdhc: add quirk SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a
      mmc: sdhci-of-esdhc: avoid writing power control register

 .../devicetree/bindings/mmc/fsl-esdhc.txt          |   2 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |   1 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |  11 +-
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   5 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  13 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
 Documentation/mmc/mmc-dev-attrs.txt                |  10 -
 arch/arc/configs/axs101_defconfig                  |   1 -
 arch/arc/configs/axs103_defconfig                  |   1 -
 arch/arc/configs/axs103_smp_defconfig              |   1 -
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |   7 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   6 +
 arch/arm/boot/dts/rk3288.dtsi                      |  20 +-
 arch/arm/configs/exynos_defconfig                  |   1 -
 arch/arm/configs/hisi_defconfig                    |   1 -
 arch/arm/configs/lpc18xx_defconfig                 |   1 -
 arch/mips/configs/pistachio_defconfig              |   1 -
 drivers/clk/rockchip/clk-mmc-phase.c               |  54 ++-
 drivers/mmc/card/block.c                           | 199 ++++++---
 drivers/mmc/core/Kconfig                           |  10 -
 drivers/mmc/core/core.c                            | 291 ++++++-------
 drivers/mmc/core/core.h                            |   3 -
 drivers/mmc/core/debugfs.c                         |  30 +-
 drivers/mmc/core/host.c                            | 247 +----------
 drivers/mmc/core/mmc.c                             |   5 +-
 drivers/mmc/core/mmc_ops.c                         |   9 +-
 drivers/mmc/core/mmc_ops.h                         |   3 +
 drivers/mmc/core/pwrseq_emmc.c                     |   8 +-
 drivers/mmc/core/pwrseq_simple.c                   |  45 +-
 drivers/mmc/core/quirks.c                          |  18 -
 drivers/mmc/core/sd.c                              |  27 +-
 drivers/mmc/core/sdio.c                            |  27 +-
 drivers/mmc/core/sdio_irq.c                        |  14 +-
 drivers/mmc/core/sdio_ops.h                        |   7 +
 drivers/mmc/host/Kconfig                           |  21 +-
 drivers/mmc/host/Makefile                          |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
 drivers/mmc/host/dw_mmc-rockchip.c                 | 162 +++++++
 drivers/mmc/host/dw_mmc.c                          | 290 ++++++++++---
 drivers/mmc/host/dw_mmc.h                          |  13 +-
 drivers/mmc/host/mmc_spi.c                         |   1 +
 drivers/mmc/host/moxart-mmc.c                      |   1 +
 drivers/mmc/host/mtk-sd.c                          | 306 ++++++++++++--
 drivers/mmc/host/omap.c                            |   1 +
 drivers/mmc/host/sdhci-acpi.c                      |  11 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   6 +-
 drivers/mmc/host/sdhci-esdhc.h                     |   2 +
 drivers/mmc/host/sdhci-msm.c                       |   2 +-
 drivers/mmc/host/sdhci-of-at91.c                   |   1 -
 drivers/mmc/host/sdhci-of-esdhc.c                  | 463 ++++++++++++++++-----
 drivers/mmc/host/{sdhci-pci.c => sdhci-pci-core.c} |  62 ++-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   6 +-
 drivers/mmc/host/sdhci-pci-o2micro.h               |   2 -
 drivers/mmc/host/sdhci-pci.h                       |   7 +
 drivers/mmc/host/sdhci-pltfm.c                     |   6 +-
 drivers/mmc/host/sdhci-sirf.c                      |   5 +-
 drivers/mmc/host/sdhci.c                           |  29 +-
 drivers/mmc/host/sunxi-mmc.c                       |   8 +
 drivers/mmc/host/vub300.c                          |   6 +-
 drivers/mmc/host/wbsd.c                            |   2 +-
 include/linux/mmc/card.h                           |   1 -
 include/linux/mmc/core.h                           |   4 +-
 include/linux/mmc/dw_mmc.h                         |  23 +-
 include/linux/mmc/host.h                           |  39 +-
 include/uapi/linux/mmc/ioctl.h                     |  19 +-
 67 files changed, 1703 insertions(+), 910 deletions(-)
 rename drivers/mmc/host/{sdhci-pci.c => sdhci-pci-core.c} (96%)
