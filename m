From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.12
Date: Tue, 2 May 2017 12:39:27 +0200
Message-ID: <CAPDyKFpxDSrsckF8ax5jg0-Qi6S=U-DSmmUKV5u5FcHfT3Xg3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33849 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdEBKj2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 06:39:28 -0400
Received: by mail-qk0-f172.google.com with SMTP id r189so12467797qkf.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 May 2017 03:39:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi Linus,

Here's the PR for MMC for v4.12. Details about the highlights are as
usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5a7ad1146caa895ad718a534399e38bd2ba721b7=
:

  Linux 4.11-rc8 (2017-04-23 16:53:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.12

for you to fetch changes up to a627f025eb0534052ff451427c16750b3530634c:

  mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a (2017-04-28
14:53:13 +0200)

----------------------------------------------------------------
MMC core:
 - Continue to re-factor code to prepare for eMMC CMDQ and blkmq support
 - Introduce queue semantics to prepare for eMMC CMDQ and blkmq support
 - Add helper functions to manage temporary enable/disable of eMMC CMDQ
 - Improve wait-busy detection for SDIO

MMC host:
 - cavium: Add driver to support Cavium controllers
 - cavium: Extend Cavium driver to support Octeon SOCs and ThunderX SOCs
 - bcm2835: Add new driver for Broadcom BCM2835 controller
 - sdhci-xenon: Add driver to support Marvell Xenon SDHCI controller
 - sdhci-tegra: Add support for the Tegra186 variant
 - sdhci-of-esdhc: Support for UHS-I SD cards
 - sdhci-of-esdhc: Support for eMMC HS200 cards
 - sdhci-cadence: Add eMMC HS400 enhanced strobe support
 - sdhci-esdhc-imx: Reset tuning circuit when needed
 - sdhci-pci: Modernize and clean-up some PM related code
 - sdhci-pci: Avoid re-tuning at runtime PM for some Intel devices
 - sdhci-pci|acpi: Use aggressive PM for some Intel BYT controllers
 - sdhci: Re-factoring and modernizations
 - sdhci: Optimize delay loops
 - sdhci: Improve register dump print format
 - sdhci: Add support for the Command Queue Engine
 - meson-gx: Various improvements and clean-ups
 - meson-gx: Add support for CMD23
 - meson-gx: Basic tuning support to avoid CRC errors
 - s3cmci: Enable probing via DT
 - mediatek: Improve tuning support for eMMC HS200 and HS400 mode
 - tmio: Improve DMA support
 - tmio: Use correct response for CMD12
 - dw_mmc: Minor improvements and clean-ups

----------------------------------------------------------------
Adrian Hunter (35):
      mmc: sdhci: Optimize delay loops
      mmc: sdhci: Let drivers decide whether to use mmc_retune_needed() wit=
h pm
      mmc: sdhci-pci: Let devices define their own private data
      mmc: sdhci-pci: Don't re-tune with runtime pm for some Intel devices
      mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel de=
vices
      mmc: sdhci: Remove ->select_drive_strength() callback
      mmc: sdhci: Do not use spin lock in set_ios paths
      mmc: sdhci: Reduce spin lock usage in sdhci_execute_tuning
      mmc: sdhci: Improve debug print format
      mmc: sdhci: Add response register to register dump
      mmc: sdhci: Use sdhci_readl() not readl() in sdhci_dumpregs()
      mmc: sdhci: Improve register dump print format
      mmc: sdhci: Export sdhci_dumpregs
      mmc: sdhci: Get rid of 'extern' in header file
      mmc: sdhci: Add sdhci_cleanup_host
      mmc: sdhci: Factor out sdhci_set_default_irqs
      mmc: sdhci: Add CQE support
      mmc: sdhci-pci: Let devices define how to add the host
      mmc: sdhci-pci: Do not use suspend/resume callbacks with runtime pm
      mmc: sdhci-pci: Conditionally compile pm sleep functions
      mmc: sdhci-pci: Let suspend/resume callbacks replace default callback=
s
      mmc: sdhci-pci: Add runtime suspend/resume callbacks
      mmc: sdhci-pci: Move a function to avoid later forward declaration
      mmc: block: Use local var for mqrq_cur
      mmc: block: Introduce queue semantics
      mmc: queue: Share mmc request array between partitions
      mmc: mmc: Add functions to enable / disable the Command Queue
      mmc: mmc_test: Disable Command Queue while mmc_test is used
      mmc: block: Disable Command Queue while RPMB is used
      mmc: block: Change mmc_apply_rel_rw() to get block address from
the request
      mmc: block: Factor out data preparation
      mmc: core: Factor out debug prints from mmc_start_request()
      mmc: core: Factor out mrq preparation from mmc_start_request()
      mmc: sdhci-pci: Allow for 3 bytes from Intel DSM
      mmc: sdhci: Control the delay between tuning commands

Alexey Khoroshilov (1):
      mmc: sdhci-pxav2: add error handling of clk_prepare_enable()

Azhar Shaikh (2):
      mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel
controllers
      mmc: sdhci-pci: Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel
controllers

Chris Brandt (1):
      mmc: sh_mmcif: Document r7s72100 DT bindings

Colin Ian King (1):
      clk: apn806: fix spelling mistake: "mising" -> "missing"

Dan Carpenter (2):
      mmc: host: omap_hsmmc: checking for NULL instead of IS_ERR()
      mmc: cavium: Fix a shift wrapping bug

Eric Anholt (2):
      dt-bindings: Add binding for brcm,bcm2835-sdhost.
      mmc: bcm2835: Add new driver for the sdhost controller.

Gregory CLEMENT (1):
      clk: apn806: Turn the eMMC clock as optional for dts backwards compat=
ible

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: reset tuning circuit when power on mmc card

Heiner Kallweit (28):
      mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
      mmc: meson-gx: make two functions return void
      mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_=
host
      mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
      mmc: meson-gx: remove member parent_mux from struct meson_host
      mmc: meson-gx: fix error path in meson_mmc_clk_init / meson_mmc_probe
      mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
      mmc: meson-gx: improve initial configuration
      mmc: meson-gx: remove member mrq from struct meson_host
      mmc: meson-gx: replace magic timeout numbers with constants
      mmc: sdio: improve mmc_io_rw_extended
      mmc: meson-gx: remove unneeded configuration bit resets
      mmc: meson-gx: replace cmd->data in meson_mmc_start_cmd
      mmc: meson-gx: improve variable usage in meson_mmc_start_cmd
      mmc: meson-gx: improve response reading
      mmc: meson-gx: improve setting data->bytes_xfered
      mmc: meson-gx: simplify setting timeout configuration parameters
      mmc: meson-gx: use bitfield macros
      mmc: meson-gx: use per port interrupt names
      mmc: meson-gx: switch to dynamic timeout values
      mmc: meson-gx: add CMD23 mode
      mmc: core: add mmc_get_dma_dir
      mmc: use new core function mmc_get_dma_dir
      mmc: meson-gx: factor out setting block size
      mmc: meson-gx: factor out setting response configuration bits
      mmc: meson-gx: introduce struct meson_tuning_params
      mmc: meson-gx: add basic tuning for rx clock phase
      mmc: meson-gx: add support for descriptor chain mode

Hu Ziji (10):
      mmc: sdhci: Export sdhci_set_ios() from sdhci.c
      mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
      mmc: sdhci: Export sdhci_enable_sdio_irq() from sdhci.c
      dt: bindings: Add bindings for Marvell Xenon SD Host Controller
      mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
      mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC
      mmc: sdhci-xenon: Add SoC PHY PAD voltage control
      MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
      mmc: sdhci-xenon: Fix the work flow in xenon_remove().
      mmc: sdhci-xenon: Fix default value of LOGIC_TIMING_ADJUST for eMMC5.=
0 PHY

Icenowy Zheng (1):
      mmc: sunxi: change controller error info to debug level

Jan Glauber (8):
      dt-bindings: mmc: Add Cavium SOCs MMC bindings
      mmc: cavium: Add core MMC driver for Cavium SOCs
      mmc: cavium: Add MMC PCI driver for ThunderX SOCs
      mmc: cavium: Add scatter-gather DMA support
      mmc: cavium: Support DDR mode for eMMC devices
      MAINTAINERS: Add entry for Cavium MMC driver
      mmc: cavium: Remove redundant pointer check
      mmc: cavium: Check pointer before de-reference

Jisheng Zhang (3):
      mmc: sdhci-pxav3: remove unnecessary platform_set_drvdata() call
      mmc: sdhci-pxav2: remove unnecessary platform_set_drvdata() call
      mmc: sdhci-st: remove unnecessary platform_set_drvdata() call

Konstantin Porotchkin (1):
      clk: apn806: Add eMMC clock to system controller driver

Linus Walleij (3):
      mmc: core: move some code in mmc_start_areq()
      mmc: core: refactor asynchronous request finalization
      mmc: core: refactor mmc_request_done()

Masaharu Hayakawa (1):
      mmc: tmio: always get number of taps

Micha=C5=82 Zegan (2):
      mmc: meson-gx: remove mmc host on device removal
      mmc: meson-gx: fix error path when driver initialization fails
before enabling clocks

Piotr Sroka (6):
      mmc: sdhci-cadence: add HS400 enhanced strobe support
      mmc: sdhci-cadence: Fix writing PHY delay
      dt-bindings: mmc: add description of PHY delays for sdhci-cadence
      mmc: sdhci-cadence: Update PHY delay configuration
      mmc: sdhci-cadence: refactor probe function
      mmc: sdhci-cadence: add parsing sdhci properties

Sergio Prado (2):
      dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
      mmc: host: s3cmci: allow probing from device tree

Shawn Lin (8):
      mmc: dw_mmc: improve the timeout polling code
      mmc: dw_mmc: move dw_mci_reset forward to avoid declaration
      mmc: dw_mmc: move dw_mci_ctrl_reset forward to avoid declaration
      mmc: dw_mmc: move dw_mci_get_cd forward to avoid declaration
      mmc: dw_mmc: remove declaration of dw_mci_card_busy
      mmc: dw_mmc: move mci_send_cmd forward to avoid declaration
      mmc: dw_mmc: improve dw_mci_reset a bit
      mmc: sdhci: clarify the get_timeout_clock callback

Stefan Wahren (1):
      mmc: bcm2835: Fix possible NULL ptr dereference in bcm2835_request

Steven J. Hill (3):
      mmc: cavium: Fix detection of block or byte addressing.
      mmc: cavium: Add MMC support for Octeon SOCs.
      MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC

Thierry Reding (4):
      mmc: tegra: Support module reset
      mmc: tegra: Add Tegra186 support
      dt-bindings: mmc: tegra: Reformat compatible string list
      dt-bindings: mmc: tegra: Document Tegra186 compatible string

Ulf Hansson (1):
      mmc: core: Export API to allow hosts to get the card address

Wei Yongjun (2):
      mmc: cavium: Use module_pci_driver to simplify the code
      mmc: sdhci-xenon: Remove redundant dev_err call in get_dt_pad_ctrl_da=
ta()

Winkler, Tomas (1):
      mmc: core: add proper be32 annotation

Wolfram Sang (6):
      mmc: tmio: ensure end of DMA and SD access are in sync
      mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
      mmc: host: tmio: fix minor typos in comments
      mmc: host: tmio: don't BUG on unsupported stop commands
      mmc: host: tmio: fill in response from auto cmd12
      mmc: tmio: always unmap DMA before waiting for interrupt

jiajie.hao@mediatek.com (1):
      mmc: sdio: Fix sdio wait busy implement limitation

tcharding (2):
      mmc: core: guard dereference of optional parameter
      mmc: core: simplify return code

yangbo lu (6):
      mmc: sdhci-of-esdhc: add peripheral clock support
      mmc: sdhci-of-esdhc: add support for signal voltage switch
      mmc: sdhci-of-esdhc: add tuning support
      mmc: sdhci-of-esdhc: add delay between tuning cycles
      mmc: sdhci-of-esdhc: poll ESDHC_CLOCK_STABLE bit with udelay
      mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a

yong mao (2):
      mmc: dt-bindings: update Mediatek MMC bindings
      mmc: mediatek: Use data tune for CMD line tune

 .../bindings/mmc/brcm,bcm2835-sdhost.txt           |   23 +
 .../devicetree/bindings/mmc/cavium-mmc.txt         |   57 +
 .../bindings/mmc/marvell,xenon-sdhci.txt           |  170 +++
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |   12 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |   12 +-
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |    8 +
 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |   42 +
 .../devicetree/bindings/mmc/sdhci-cadence.txt      |   48 +
 Documentation/mmc/mmc-dev-attrs.txt                |    1 +
 MAINTAINERS                                        |   15 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |    3 +-
 arch/mips/configs/cavium_octeon_defconfig          |    5 +
 drivers/clk/mvebu/ap806-system-controller.c        |   21 +-
 drivers/mmc/core/block.c                           |  300 ++--
 drivers/mmc/core/core.c                            |  193 +--
 drivers/mmc/core/mmc.c                             |    9 +
 drivers/mmc/core/mmc_ops.c                         |   36 +-
 drivers/mmc/core/mmc_ops.h                         |    2 +
 drivers/mmc/core/mmc_test.c                        |   14 +
 drivers/mmc/core/queue.c                           |  307 ++--
 drivers/mmc/core/queue.h                           |   12 +-
 drivers/mmc/core/sd.c                              |    4 +-
 drivers/mmc/core/sd_ops.c                          |   19 +-
 drivers/mmc/core/sd_ops.h                          |    2 +-
 drivers/mmc/core/sdio_io.c                         |   54 +-
 drivers/mmc/core/sdio_ops.c                        |    9 +-
 drivers/mmc/core/sdio_ops.h                        |   10 +-
 drivers/mmc/host/Kconfig                           |   43 +
 drivers/mmc/host/Makefile                          |    8 +
 drivers/mmc/host/android-goldfish.c                |   10 +-
 drivers/mmc/host/atmel-mci.c                       |   30 +-
 drivers/mmc/host/bcm2835.c                         | 1466 ++++++++++++++++=
++++
 drivers/mmc/host/cavium-octeon.c                   |  351 +++++
 drivers/mmc/host/cavium-thunderx.c                 |  187 +++
 drivers/mmc/host/cavium.c                          | 1090 +++++++++++++++
 drivers/mmc/host/cavium.h                          |  215 +++
 drivers/mmc/host/davinci_mmc.c                     |   14 +-
 drivers/mmc/host/dw_mmc.c                          |  397 +++---
 drivers/mmc/host/jz4740_mmc.c                      |    9 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  590 +++++---
 drivers/mmc/host/mmc_spi.c                         |    5 +-
 drivers/mmc/host/mmci.c                            |   20 +-
 drivers/mmc/host/moxart-mmc.c                      |    8 +-
 drivers/mmc/host/mtk-sd.c                          |  176 ++-
 drivers/mmc/host/mvsdio.c                          |   11 +-
 drivers/mmc/host/omap_hsmmc.c                      |   21 +-
 drivers/mmc/host/s3cmci.c                          |  261 ++--
 drivers/mmc/host/sdhci-acpi.c                      |   18 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |    3 +
 drivers/mmc/host/sdhci-cadence.c                   |  129 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   32 +
 drivers/mmc/host/sdhci-esdhc.h                     |    7 +
 drivers/mmc/host/sdhci-msm.c                       |    8 -
 drivers/mmc/host/sdhci-of-arasan.c                 |   26 +-
 drivers/mmc/host/sdhci-of-at91.c                   |    5 +-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  194 ++-
 drivers/mmc/host/sdhci-pci-core.c                  |  562 ++++----
 drivers/mmc/host/sdhci-pci-data.c                  |    3 -
 drivers/mmc/host/sdhci-pci-o2micro.c               |    4 +-
 drivers/mmc/host/sdhci-pci.h                       |   24 +-
 drivers/mmc/host/sdhci-pltfm.c                     |    3 +
 drivers/mmc/host/sdhci-pxav2.c                     |    9 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   12 +-
 drivers/mmc/host/sdhci-s3c.c                       |   10 +-
 drivers/mmc/host/sdhci-sirf.c                      |    3 +
 drivers/mmc/host/sdhci-spear.c                     |    3 +
 drivers/mmc/host/sdhci-st.c                        |    8 +-
 drivers/mmc/host/sdhci-tegra.c                     |   59 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |  837 +++++++++++
 drivers/mmc/host/sdhci-xenon.c                     |  548 ++++++++
 drivers/mmc/host/sdhci-xenon.h                     |  101 ++
 drivers/mmc/host/sdhci.c                           |  453 +++---
 drivers/mmc/host/sdhci.h                           |   65 +-
 drivers/mmc/host/sunxi-mmc.c                       |   16 +-
 drivers/mmc/host/tmio_mmc.h                        |   12 +-
 drivers/mmc/host/tmio_mmc_dma.c                    |   61 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |   36 +-
 include/linux/mmc/card.h                           |   10 +
 include/linux/mmc/host.h                           |    6 +
 79 files changed, 7948 insertions(+), 1619 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/cavium-mmc.txt
 create mode 100644
Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.tx=
t
 create mode 100644 drivers/mmc/host/bcm2835.c
 create mode 100644 drivers/mmc/host/cavium-octeon.c
 create mode 100644 drivers/mmc/host/cavium-thunderx.c
 create mode 100644 drivers/mmc/host/cavium.c
 create mode 100644 drivers/mmc/host/cavium.h
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h
