From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.1
Date: Mon, 13 Apr 2015 10:46:10 +0200
Message-ID: <CAPDyKFr+Y0EEMx8Ope5CUYH3hptVnWXmqVamF+4w+KOVMOBMGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are the PR for MMC for v4.1.

Details about the MMC highlights are found in the signed tag. Please
pull this in!

Kind regards
Ulf Hansson


The following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f62d6:

  Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.1

for you to fetch changes up to 69f0fb2a592fc9ebc5e3e55178055d1cff31d479:

  mmc: sdhci-st: Update ST SDHCI binding documentation. (2015-04-10
12:55:40 +0200)

----------------------------------------------------------------
MMC core:
- Add support for marking HPI as broken through devicetree
- Enable runtime PM management of host devices
- Remove the ->enable|disable() callbacks
- Restructure code and cleanups
- Refreshed some of the MMC sections in MAINTAINERS

MMC host:
- dw_mmc: HS400 mode support
- dw_mmc: Add the cmd11 timer to detect a timeout
- dw_mmc: Endian agnostic IO accessors
- dw_mmc: Bugfixes
- sh_mmcif: Add exclusion between cmd and interrupt
- omap_hsmmc: Hibernation support
- omap_hsmmc: Rework and simplify cover/card detect
- omap_hsmmc: Stop using ->enable|disable() callbacks
- atmel-mci: Endian agnostic IO
- sunxi: Enable MMC_CAP_SDIO_IRQ
- sdhci-st: Add support for the stih407 family silicon
- sdhci-st: UHS card support in SDR104 mode
- sdhci-st: HS200 mode support
- sdhci-esdhc-imx: Use common mmc DT parser
- sdhci-of-arasan: Use common mmc DT parser
- sdhci-iproc: Add new driver for Broadcom IPROC SDHCI controller
- sdhci-tegra: Convert to GPIO descriptors
- sdhci-tegra: Optmize write_w path for tegra114 and later
- sdhci-sirf: Update tuning procedure
- sdhci: Fix card presence logic
- sdhci: Cleanups and consolidation

----------------------------------------------------------------
Alexandre Courbot (1):
      mmc: pwrseq: simplify alloc/free hooks

Andreas Fenkart (6):
      mmc: omap_hsmmc: remove unused fields from struct omap_hsmmc_host
      mmc: omap_hsmmc: use slot-gpio functions to manage read-only pin directly
      mmc: omap_hsmmc: use distinctive code paths for cover / card detect logic
      ARM: OMAP2: HSMMC: explicit fields to declare cover/card detect pin
      mmc: omap_hsmmc: simplify card/cover detect isr
      mmc: omap_hsmmc: use generic slot-gpio isr to manage card detect pin

Arnd Bergmann (1):
      mmc: sunxi: avoid invalid pointer calculation

Ben Dooks (4):
      mmc: atmel-mci: use endian agnostic IO
      mmc: dw_mmc: make IO accessors endian agnostic
      mmc: dw_mmc: change idmac descriptor files to __le32
      mmc: dw_mmc: fix fifo ordering in big endian

Bjorn Andersson (1):
      mmc: mmci: Cascade EPROBE_DEFER from regulators.

Chen-Yu Tsai (1):
      mmc: sunxi: Use devm_reset_control_get_optional() for reset control

Corneliu Doban (1):
      mmc: sdhci: do not set AUTO_CMD12 for multi-block CMD53

Dan Carpenter (1):
      mmc: sdhci-esdhc-imx: silence a false curly braces warning

Dmitry Torokhov (1):
      mmc: sdhci-iproc: fix oops in sdhci_iproc_writew

Doug Anderson (10):
      mmc: dw_mmc: Make sure we only adjust the clock when power is on
      mmc: dw_mmc: Give a good reset after we give power
      mmc: dw_mmc: Don't start commands while busy
      mmc: dw_mmc: Only enable CD after setup and only if needed
      mmc: dw_mmc: Don't crash if we get an interrupt before slot has initted
      mmc: dw_mmc: Add a timeout for sending CMD11
      mmc: dw_mmc: Don't try to enable the CD until we're sure we're
not deferring
      mmc: dw_mmc: Increase cmd11 timeout to 500ms
      mmc: dw_mmc: Add a return in an unexpected cmd11 timeout
      mmc: dw_mmc: Add locking around cmd11 timer

Fabian Frederick (1):
      mmc: constify of_device_id array

Fabio Estevam (1):
      mmc: sdhci-esdhc-imx: Call mmc_of_parse()

Geert Uytterhoeven (1):
      mmc: tmio: Remove bogus un-initialization in tmio_mmc_host_free()

Georgi Djakov (1):
      mmc: sdhci-msm: Add support for vendor capabilities registers

Hans de Goede (2):
      mmc: sunxi: add MMC_CAP_SDIO_IRQ capability
      mmc: Add support for marking hpi as broken through devicetree

Jaehoon Chung (1):
      mmc: dw_mmc: enable card read threshold when mode is HS400

Jean Delvare (1):
      mmc: Fix hardware dependencies for sdhci-pxav3

Kevin Hao (9):
      mmc: sdhci-dove: remove the unneeded error check
      mmc: sdhci-dove: kill the driver specific private struct
      mmc: tegra: use devm help functions to get the clk and gpio
      mmc: sdhci-sirf: kill the "clk" member in driver private struct
      mmc: sdhci-bcm-kona: kill the "external_clk" member in driver
private struct
      mmc: sdhci: disable the clock in sdhci_pltfm_unregister()
      mmc: sdhci: set the .remove to sdhci_pltfm_unregister()
      mmc: kconfig: replace PPC_OF with PPC
      mmc: sdhci-pltfm: remove the unneeded check of disabled device

Kouichi Tomita (2):
      mmc: sh_mmcif: Move dev_err() of mmcif_timeout_work()
      mmc: sh_mmcif: Add exclusion between cmd and interrupt

Michal Simek (1):
      mmc: sdhci-of-arasan: Call OF parsing for MMC

Micky Ching (1):
      mmc: sdhci-pci: fix 64 BIT DMA quirks for rtsx

Mylene JOSSERAND (1):
      mmc: sdhci-tegra: convert to use GPIO descriptors

NeilBrown (3):
      mmc: core: fold mmc_set_bus_width calls into sdio_enable_4bit_bus.
      mmc: omap_hsmmc: stop using ->enable|disable() callbacks
      mmc: core: Remove the ->enable|disable() callbacks

Peter Griffin (7):
      mmc: sdhci-st: Add macros for register offsets and bitfields for
mmcss glue regs
      mmc: sdhci-st: Add support for de-asserting reset signal and top
regs resource
      mmc: sdhci-st: Add delay management functions for top registers (eMMC).
      mmc: sdhci-st: Add st_mmcss_cconfig function to configure mmcss
glue registers.
      mmc: sdhci-st: Add sdhci_st_set_uhs_signaling function.
      mmc: sdhci-st: Update the quirks for this controller.
      mmc: sdhci-st: Update ST SDHCI binding documentation.

Rhyland Klein (1):
      mmc: tegra: Optimize write_w path for tegra114 and later

Russ Dill (1):
      mmc: omap_hsmmc: add hibernation support

Sascha Hauer (1):
      mmc: sdhci-esdhc-imx: support voltage-range property

Scott Branden (4):
      mmc: sdhci: add quirk for ACMD23 broken
      mmc: sdhci-iproc: add device tree bindings
      mmc: sdhci-iproc: add IPROC SDHCI driver
      mmc: sdhci: fix card presence logic in sdhci_request function

Seungwon Jeon (1):
      mmc: dw_mmc: exynos: Support eMMC's HS400 mode

Ulf Hansson (8):
      mmc: sdhci: Remove the sdhci exported header file
      mmc: sdhci-spear: Simplify by adding build dependency to CONFIG_OF
      mmc: sdhci-spear: Remove exported header
      MAINTAINERS: mmc: Remove the SDHCI-OF section
      MAINTAINERS: mmc: Cleanup MMC/SD/SDIO section and SDHCI driver section
      MAINTAINERS: mmc: Add Jaehoon as co-maintainer for SDHCI SAMSUNG DRIVER
      mmc: core: Enable runtime PM management of host devices
      mmc: core: Convert the error field in struct mmc_command|data into an int

Wu Fengguang (1):
      mmc: dw_mmc: exynos: dw_mci_exynos_prepare_hs400_tuning() can be static

addy ke (2):
      mmc: dw_mmc: rockchip: add support MMC_CAP_RUNTIME_RESUME capability
      mmc: dw_mmc: fix mmc_test by not sending abort for DRTO/EBE errors

weijun yang (1):
      mmc: sirf: update sdhci_sirf_execute_tuning procedure

 CREDITS                                            |   4 +
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  23 ++
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   7 +
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   4 +
 Documentation/devicetree/bindings/mmc/mmc-card.txt |  31 ++
 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 100 +++++-
 MAINTAINERS                                        |  16 +-
 arch/arm/mach-omap2/hsmmc.c                        |  33 +-
 drivers/mmc/core/core.c                            |  15 +-
 drivers/mmc/core/mmc.c                             |  10 +-
 drivers/mmc/core/pwrseq.c                          |  16 +-
 drivers/mmc/core/pwrseq.h                          |   6 +-
 drivers/mmc/core/pwrseq_emmc.c                     |  11 +-
 drivers/mmc/core/pwrseq_simple.c                   |  11 +-
 drivers/mmc/core/sdio.c                            |  32 +-
 drivers/mmc/host/Kconfig                           |  21 +-
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci-regs.h                  |  11 +-
 drivers/mmc/host/dw_mmc-exynos.c                   | 185 +++++++++--
 drivers/mmc/host/dw_mmc-exynos.h                   |  19 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   8 +
 drivers/mmc/host/dw_mmc.c                          | 281 ++++++++++++-----
 drivers/mmc/host/dw_mmc.h                          |  28 +-
 drivers/mmc/host/mmc_spi.c                         |   2 +-
 drivers/mmc/host/mmci.c                            |   5 +-
 drivers/mmc/host/omap_hsmmc.c                      | 119 ++-----
 drivers/mmc/host/sdhci-acpi.c                      |   1 -
 drivers/mmc/host/sdhci-bcm-kona.c                  |  61 +---
 drivers/mmc/host/sdhci-bcm2835.c                   |   7 +-
 drivers/mmc/host/sdhci-cns3xxx.c                   |   7 +-
 drivers/mmc/host/sdhci-dove.c                      |  39 +--
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  46 +--
 drivers/mmc/host/sdhci-iproc.c                     | 241 ++++++++++++++
 drivers/mmc/host/sdhci-msm.c                       |  29 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   7 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   7 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |   7 +-
 drivers/mmc/host/sdhci-pci.c                       |   1 +
 drivers/mmc/host/sdhci-pltfm.c                     |  56 ++--
 drivers/mmc/host/sdhci-sirf.c                      |  42 +--
 drivers/mmc/host/sdhci-spear.c                     |  47 +--
 drivers/mmc/host/sdhci-st.c                        | 346 ++++++++++++++++++++-
 drivers/mmc/host/sdhci-tegra.c                     | 105 +++----
 drivers/mmc/host/sdhci.c                           |  27 +-
 drivers/mmc/host/sdhci.h                           | 203 +++++++++++-
 drivers/mmc/host/sh_mmcif.c                        |  17 +-
 drivers/mmc/host/sunxi-mmc.c                       |  11 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |   2 -
 drivers/mmc/host/wmt-sdmmc.c                       |   2 +-
 include/linux/mmc/core.h                           |   4 +-
 include/linux/mmc/dw_mmc.h                         |   6 +-
 include/linux/mmc/host.h                           |   6 -
 include/linux/mmc/sdhci-spear.h                    |  34 --
 include/linux/mmc/sdhci.h                          | 218 -------------
 include/linux/platform_data/hsmmc-omap.h           |   6 +-
 55 files changed, 1692 insertions(+), 892 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
 create mode 100644 drivers/mmc/host/sdhci-iproc.c
 delete mode 100644 include/linux/mmc/sdhci-spear.h
 delete mode 100644 include/linux/mmc/sdhci.h
