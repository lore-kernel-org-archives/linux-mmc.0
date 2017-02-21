From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.11
Date: Tue, 21 Feb 2017 13:19:56 +0100
Message-ID: <CAPDyKFqREanoHV835og2NejMKLgtxJNRxZ4G=aG9-M1yanTsTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36499 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbdBUMT6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2017 07:19:58 -0500
Received: by mail-qk0-f179.google.com with SMTP id x71so53979113qkb.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Feb 2017 04:19:57 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi Linus,

Here's the PR for MMC v4.11. Details about the highlights are as usual
found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3d4ef329757cfd5e0b23cce97cdeca7e2df89c99:

  mmc: core: fix multi-bit bus width without high-speed mode
(2017-02-14 08:50:10 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.11

for you to fetch changes up to 8c7cdbf9272c300dc093da3c62fa3b4bc6dc960e:

  mmc: core: add mmc prefix for blk_fixups (2017-02-15 11:34:27 +0100)

----------------------------------------------------------------
MMC core:
 - Add support for Marvell SD8787 Wifi/BT chip
 - Improve UHS support for SDIO
 - Invent MMC_CAP_3_3V_DDR and a DT binding for eMMC DDR 3.3V mode
 - Detect Auto BKOPS enable bit
 - Export eMMC device lifetime information through sysfs
 - First take to slim down the public mmc headers to avoid abuse
 - Re-factoring of the mmc block device driver to prepare for blkmq
 - Cleanup code for the mmc block device driver
 - Clarify and cleanup code dealing with data requests
 - Cleanup some code by converting to ida_simple_ functions
 - Cleanup code dealing with card quirks
 - Cleanup private and public mmc header files

MMC host:
 - Don't rely on public mmc headers to include non-mmc related headers
 - meson: Add support for eMMC HS400 mode
 - meson: Various cleanups and improvements
 - omap_hsmmc: Use the proper provided busy timeout from the core
 - sunxi: Enable new timings for the A64 MMC controllers
 - sunxi: Improvements for clock management
 - tmio: Improvements for SDIO interrupts
 - mxs-mmc: Add CMD23 support
 - sdhci-msm: Enable HS400 enhanced strobe mode support
 - sdhci-msm: Correct HS400 tuning sequence
 - sdhci-acpi: Support deferred probe
 - sdhci-pci: Add support for eMMC HS200 tuning mode on AMD
 - mediatek: Correct the implementation of card busy detection
 - dw_mmc: Initial support for ZX mmc controller
 - sh_mobile_sdhi: Enable support for eMMC HS200 mode
 - sh_mmcif: Various cleanups and improvements

----------------------------------------------------------------
Alexey Khoroshilov (1):
      mmc: wbsd: safer check if dma_addr is valid DMA address

Andy Shevchenko (2):
      mmc: sdhci-pci: Remove unused member cd_con_id
      mmc: slot-gpio: Don't override con_id when request descriptor

Arnd Bergmann (1):
      mmc: s3cmci: include linux/interrupt.h for tasklet_struct

Chris Brandt (2):
      mmc: sh_mobile_sdhi: add support for 2 clocks
      mmc: sh_mobile_sdhi: explain clock bindings

Geert Uytterhoeven (2):
      mmc: block: Avoid uninitialized warning in mmc_blk_issue_discard_rq()
      mmc: block: Replace "goto retry" by a proper do / while loop

Heiner Kallweit (11):
      mmc: core: simplify ida handling
      mmc: core: fix error path in mmc_host_alloc
      mmc: core: switch to ida_simple_ functions in block.c
      mmc: meson-gx: minor improvements in meson_mmc_set_ios
      mmc: meson-gx: improve meson_mmc_clk_set
      mmc: meson-gx: improve meson_mmc_irq_thread
      mmc: meson-gx: improve interrupt handling
      mmc: meson-gx: set max block count and request size
      mmc: meson-gx: reduce bounce buffer size
      mmc: meson-gx: remove unneeded checks in remove
      mmc: meson-gx: add support for HS400 mode

Jaehoon Chung (2):
      mmc: sdhci-s3c: remove the sdhci-s3c-regs header file
      mmc: sdhci-s3c: use the bitops API for bit operation

Jun Nie (5):
      Documentation: synopsys-dw-mshc: add binding for fifo quirks
      mmc: dw_mmc: Add fifo address property
      mmc: dw_mmc: Add fifo watermark alignment property
      mmc: dt-bindings: add ZTE ZX296718 MMC bindings
      mmc: dw_mmc: zx: Initial support for ZX mmc controller

Jungseung Lee (1):
      mmc: core: Export device lifetime information through sysfs

Kevin Hilman (1):
      mmc: meson: cleanup stray debug messages

Kishon Vijay Abraham I (1):
      mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout
value for CMD6

Linus Walleij (16):
      mmc: block: break out mmc_blk_rw_cmd_abort()
      mmc: block: break out mmc_blk_rw_start_new()
      mmc: block: do not assign mq_rq when aborting command
      mmc: block: inline command abortions
      mmc: block: introduce new_areq and old_areq
      mmc: block: stop passing around pointless return values
      mmc: core/mmci: restore pre/post_req behaviour
      mmc: block: inline the command abort and start new goto:s
      mmc: block: rename rqc and req
      mmc: core: rename mmc_start_req() to *areq()
      mmc: block: refactor mmc_blk_rw_try_restart()
      mmc: block: rename mmc_active to areq
      mmc: queue: turn queue flags into bools
      mmc: block: return errorcode from mmc_sd_num_wr_blocks()
      mmc: block: respect bool returned from blk_end_request()
      mmc: core: start to break apart mmc_start_areq()

Markus Elfring (8):
      mmc: mmc_test: Use kmalloc_array() in mmc_test_area_init()
      mmc: mmc_test: Fix a typo in a comment line
      mmc: mmc_test: Use seq_puts() in mtf_testlist_show()
      mmc: mmc_test: Add some spaces for better code readability
      mmc: mmc_test: Combine substrings for 5 messages
      mmc: mmc_test: Improve a size determination in five functions
      mmc: mmc_test: Use kcalloc() in mmc_test_alloc_mem()
      mmc: core: Use kmalloc_array() in mmc_alloc_sg()

Masahiro Yamada (2):
      mmc: use empty initializer list to zero-clear structures
      mmc: sdhci-cadence: fix bit shift of read data from PHY port

Masanari Iida (1):
      mmc: dt-bindings: Fix typo in mmc

Matt Ranostay (2):
      devicetree: document new marvell-8xxx and pwrseq-sd8787 options
      mmc: pwrseq: add support for Marvell SD8787 chip

Maxime Ripard (8):
      mmc: sunxi: Fix clock frequency change sequence
      mmc: sunxi: Gate the clock when rate is 0
      mmc: sunxi: Always set signal delay to 0 for A64
      mmc: sunxi: Enable the new timings for the A64 MMC controllers
      mmc: sunxi: Mask DATA0 when updating the clock
      mmc: sunxi: Add EMMC (MMC2) controller compatible
      mmc: sunxi: Add more debug informations
      dt-bindings: mmc: sunxi: Document A64 eMMC compatible

Ravikumar Kattekola (2):
      mmc: host: omap_hsmmc: reset cmd line on ceb error
      mmc: host: omap_hsmmc: avoid possible overflow of timeout value

Ritesh Harjani (8):
      mmc: sdhci-msm: Factor out sdhci_msm_hc_select_mode
      mmc: sdhci-msm: Factor out function to set/get msm clock rate
      mmc: sdhci-msm: Factor out sdhci_msm_hs400
      mmc: sdhci: Clear SDHCI_HS400_TUNING flag after platform_execute_tuning
      mmc: sdhci-msm: Make HS400 tuning follow as per recommeneded HW sequence
      mmc: sdhci-msm: Provide enhanced_strobe mode feature support
      mmc: sdhci-msm: Remove platform_execute_tuning from sdhci_msm_ops
      mmc: sdhci-msm: Remove unnecessary comments of CDC init sequence

Shawn Lin (9):
      mmc: sdio: Factor out retry init card helper function
      mmc: sdio: don't use rocr to check if the card could support UHS mode
      mmc: vub300: Remove bogus check of irqs_queued
      mmc: dw_mmc: silent verbose log when calling from PM context
      mmc: core: change quirks.c to be a header file
      mmc: core: move some sdio IDs out of quirks file
      mmc: core: improve the quirks for sdio devices
      mmc: core: move all quirks together into quirks.h
      mmc: core: add mmc prefix for blk_fixups

Shyam Sundar S K (1):
      mmc: sdhci-pci: Add support for HS200 tuning mode on AMD, eMMC-4.5.1

Stefan Wahren (3):
      mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
      mmc: sdhci-iproc: Increase max_blk_size for bcm2835
      mmc: mxs-mmc: Implement CMD23 support

Subhash Jadavani (1):
      mmc: sdhci-msm: configure CORE_CSR_CDC_DELAY_CFG to recommended value

Ulf Hansson (35):
      sh: sh7724: Don't use a public mmc header for MMC_PROGRESS*
      mmc: Removed the unused public mmc boot.h header
      mmc: sh_mmcif: Remove unused use_cd_gpio/cd_gpio from platform data
      mmc: sh_mmcif: Remove unused ->get_cd() platform callback
      mmc: sh_mmcif: Remove unused ccs_unsupported from the platform data
      mmc: sh_mmcif: Remove unused clk_ctrl2_present from the platform data
      mmc: dw_mmc: Remove the public dw_mmc header file
      mmc: sdhci-cadence: Include mmc.h
      mmc: sdhci: Include leds.h
      mmc: host: Include interrupt.h in mmc host drivers that depends on it
      mmc: mxcmmc: Include interrupt.h in the platform data header
      mmc: tmio: Remove redundant check of mmc->slot.cd_irq
      ARM: pxa: Don't rely on public mmc header to include leds.h
      ARM: davinci: Don't rely on public mmc header to include leds.h
      ARM: davinci: Don't rely on public mmc header to include interrupt.h
      MIPS: Alchemy: Don't rely on public mmc header to include interrupt.h
      mmc: core: First step in cleaning up public mmc header files
      mmc: core: First step in cleaning up private mmc header files
      mmc: core: Move public functions from core.h to private headers
      mmc: core: Move some host specific public functions to host.h
      mmc: core: Move erase/trim/discard defines from public core.h to mmc.h
      mmc: core: Remove unused struct _mmc_csd from public mmc.h header
      mmc: omap: Don't use mmc_card_present() when validating for inserted card
      mmc: vub300: Don't use mmc_card_present() when validating for
inserted card
      mmc: core: Move public functions from card.h to private headers
      mmc: core: Move public functions from host.h to private headers
      mmc: core: Don't use extern declarations of public mmc functions
      mmc: core: Remove redundant code in mmc_set_signal_voltage()
      mmc: core: Clarify usage of mmc_set_signal_voltage()
      mmc: core: Rename __mmc_set_signal_voltage() to mmc_set_signal_voltage()
      mmc: core: Invent MMC_CAP_3_3V_DDR
      mmc: dt: Document binding for eMMC DDR 3.3V I/O voltage support
      mmc: core: Extend mmc_of_parse() to check for mmc-ddr-3_3v
      mmc: meson: Assign the minimum clk rate as close to 400KHz as possible
      Merge branch 'fixes' into next

Uri Yanai (2):
      mmc: MAN_BKOPS_EN inverse debug message logic
      mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support

Venkat Gopalakrishnan (1):
      mmc: sdhci-msm: Reset vendor specific func register on probe

Wolfram Sang (13):
      mmc: tmio: use SDIO master interrupt bit only when allowed
      mmc: sh_mobile_sdhi: simplify accessing DT data
      mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
      mmc: sh_mobile_sdhi: improve prerequisites for tuning
      mmc: sh_mobile_sdhi: remove superfluous check in hw_reset
      mmc: sh_mobile_sdhi: remove superfluous check in init_tuning
      mmc: sh_mobile_sdhi: remove superfluous check in SCC error check
      mmc: sh_mobile_sdhi: enable HS200
      mmc: host: tmio: drop superfluous exit path
      mmc: host: tmio: disable clocks when unbinding
      mmc: host: tmio: refactor calls to sdio irq
      mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
      mmc: tmio: discard obsolete SDIO irqs before enabling irqs

Zhang Rui (1):
      mmc: sdhci-acpi: support deferred probe

yangbo lu (3):
      mmc: sdhci-esdhc: clean up register definitions
      mmc: sdhci-of-esdhc: remove default broken-cd for ARM
      mmc: sdhci-of-esdhc: avoid clock glitch when frequency is changing

yong mao (1):
      mmc: mediatek: correct the implementation of msdc_card_busy

 .../devicetree/bindings/mmc/amlogic,meson-gx.txt   |   2 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  16 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |   1 +
 Documentation/devicetree/bindings/mmc/sdhci-st.txt |   2 +-
 Documentation/devicetree/bindings/mmc/sdhci.txt    |   2 +-
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   1 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  15 +-
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  13 +
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  33 ++
 .../bindings/net/wireless/marvell-8xxx.txt         |   7 +-
 MAINTAINERS                                        |   1 -
 arch/arm/mach-davinci/board-da850-evm.c            |   1 +
 arch/arm/mach-davinci/board-dm644x-evm.c           |   1 +
 arch/arm/mach-davinci/board-neuros-osd2.c          |   1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   1 +
 arch/arm/mach-pxa/balloon3.c                       |   1 +
 arch/arm/mach-pxa/colibri-pxa270-income.c          |   1 +
 arch/arm/mach-pxa/corgi.c                          |   1 +
 arch/arm/mach-pxa/trizeps4.c                       |   1 +
 arch/arm/mach-pxa/vpac270.c                        |   1 +
 arch/arm/mach-pxa/zeus.c                           |   1 +
 arch/arm/mach-pxa/zylonite.c                       |   1 +
 arch/mips/alchemy/devboards/db1300.c               |   1 +
 arch/sh/boot/romimage/mmcif-sh7724.c               |  16 +-
 drivers/mmc/core/Kconfig                           |  10 +
 drivers/mmc/core/Makefile                          |   3 +-
 drivers/mmc/core/block.c                           | 413 +++++++++------------
 drivers/mmc/core/block.h                           |  10 +-
 drivers/mmc/core/bus.c                             |   2 +
 drivers/mmc/core/bus.h                             |  16 +-
 drivers/mmc/core/card.h                            | 221 +++++++++++
 drivers/mmc/core/core.c                            | 116 +++---
 drivers/mmc/core/core.h                            |  45 ++-
 drivers/mmc/core/debugfs.c                         |   2 +
 drivers/mmc/core/host.c                            |  24 +-
 drivers/mmc/core/host.h                            |  48 +++
 drivers/mmc/core/mmc.c                             |  76 ++--
 drivers/mmc/core/mmc_ops.c                         |  44 +--
 drivers/mmc/core/mmc_ops.h                         |  14 +
 drivers/mmc/core/mmc_test.c                        | 116 +++---
 drivers/mmc/core/pwrseq.h                          |   6 +-
 drivers/mmc/core/pwrseq_sd8787.c                   | 117 ++++++
 drivers/mmc/core/queue.c                           |  16 +-
 drivers/mmc/core/queue.h                           |  13 +-
 drivers/mmc/core/quirks.c                          |  83 -----
 drivers/mmc/core/quirks.h                          | 148 ++++++++
 drivers/mmc/core/sd.c                              |   5 +-
 drivers/mmc/core/sd.h                              |   5 +-
 drivers/mmc/core/sd_ops.c                          |  30 +-
 drivers/mmc/core/sd_ops.h                          |   9 +
 drivers/mmc/core/sdio.c                            |  46 ++-
 drivers/mmc/core/sdio_bus.c                        |   1 +
 drivers/mmc/core/sdio_bus.h                        |   3 +
 drivers/mmc/core/sdio_cis.h                        |   3 +
 drivers/mmc/core/sdio_io.c                         |   2 +
 drivers/mmc/core/sdio_irq.c                        |   2 +
 drivers/mmc/core/sdio_ops.c                        |  10 +-
 drivers/mmc/core/sdio_ops.h                        |   5 +
 drivers/mmc/core/slot-gpio.c                       |   6 -
 drivers/mmc/core/slot-gpio.h                       |   2 +
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/davinci_mmc.c                     |   1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 -
 drivers/mmc/host/dw_mmc-k3.c                       |   1 -
 drivers/mmc/host/dw_mmc-pci.c                      |   1 -
 drivers/mmc/host/dw_mmc-pltfm.c                    |   1 -
 drivers/mmc/host/dw_mmc-rockchip.c                 |   1 -
 drivers/mmc/host/dw_mmc-zx.c                       | 241 ++++++++++++
 drivers/mmc/host/dw_mmc-zx.h                       |  31 ++
 drivers/mmc/host/dw_mmc.c                          |  30 +-
 drivers/mmc/host/dw_mmc.h                          | 263 +++++++++++++
 drivers/mmc/host/meson-gx-mmc.c                    | 118 +++---
 drivers/mmc/host/mmci.c                            |   7 +-
 drivers/mmc/host/mmci.h                            |   3 +-
 drivers/mmc/host/mtk-sd.c                          |   8 +-
 drivers/mmc/host/mxs-mmc.c                         |  16 +-
 drivers/mmc/host/omap.c                            |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |  29 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   2 +-
 drivers/mmc/host/s3cmci.c                          |   1 +
 drivers/mmc/host/sdhci-acpi.c                      |   5 +-
 drivers/mmc/host/sdhci-cadence.c                   |   3 +-
 drivers/mmc/host/sdhci-esdhc.h                     |  44 ++-
 drivers/mmc/host/sdhci-iproc.c                     |  11 +-
 drivers/mmc/host/sdhci-msm.c                       | 377 +++++++++++--------
 drivers/mmc/host/sdhci-of-esdhc.c                  |  39 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  97 ++++-
 drivers/mmc/host/sdhci-pci.h                       |   1 -
 drivers/mmc/host/sdhci-s3c-regs.h                  |  87 -----
 drivers/mmc/host/sdhci-s3c.c                       |  71 +++-
 drivers/mmc/host/sdhci.c                           |  10 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 drivers/mmc/host/sh_mmcif.c                        |  28 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |  95 ++---
 drivers/mmc/host/sunxi-mmc.c                       | 114 +++---
 drivers/mmc/host/tmio_mmc.h                        |   3 +
 drivers/mmc/host/tmio_mmc_pio.c                    |  61 +--
 drivers/mmc/host/via-sdmmc.c                       |   1 +
 drivers/mmc/host/vub300.c                          |   8 +-
 drivers/mmc/host/wbsd.c                            |   7 +-
 drivers/mmc/host/wmt-sdmmc.c                       |   1 +
 include/linux/mfd/tmio.h                           |   6 +-
 include/linux/mmc/boot.h                           |   7 -
 include/linux/mmc/card.h                           | 246 +-----------
 include/linux/mmc/core.h                           |  86 +----
 include/linux/mmc/dw_mmc.h                         | 274 --------------
 include/linux/mmc/host.h                           |  84 +----
 include/linux/mmc/mmc.h                            |  63 +---
 include/linux/mmc/sdio_ids.h                       |   7 +
 include/linux/mmc/sh_mmcif.h                       |   5 -
 include/linux/mmc/slot-gpio.h                      |   3 +
 include/linux/platform_data/mmc-mxcmmc.h           |   1 +
 114 files changed, 2591 insertions(+), 1818 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 create mode 100644 drivers/mmc/core/card.h
 create mode 100644 drivers/mmc/core/pwrseq_sd8787.c
 delete mode 100644 drivers/mmc/core/quirks.c
 create mode 100644 drivers/mmc/core/quirks.h
 create mode 100644 drivers/mmc/host/dw_mmc-zx.c
 create mode 100644 drivers/mmc/host/dw_mmc-zx.h
 delete mode 100644 drivers/mmc/host/sdhci-s3c-regs.h
 delete mode 100644 include/linux/mmc/boot.h
 delete mode 100644 include/linux/mmc/dw_mmc.h
