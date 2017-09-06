From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.14
Date: Wed,  6 Sep 2017 11:05:36 +0200
Message-ID: <1504688736-24258-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33532 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdIFJFk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Sep 2017 05:05:40 -0400
Received: by mail-lf0-f53.google.com with SMTP id s11so16238055lfe.0
        for <linux-mmc@vger.kernel.org>; Wed, 06 Sep 2017 02:05:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Linus,

Here's the PR for MMC for v4.14. Details about the highlights are as usual found
in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 99c14fc360dbbb583a03ab985551b12b5c5ca4f1:

  mmc: sdhci-xenon: add set_power callback (2017-08-30 14:11:47 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14

for you to fetch changes up to c16a854e4463078aedad601fac76341760a66dd1:

  mmc: renesas_sdhi: Add r8a7743/5 support (2017-09-01 15:31:01 +0200)

----------------------------------------------------------------
MMC core:
 - Continue to refactor the mmc block code to prepare for blkmq
 - Move mmc block debugfs into block module
 - Next step for eMMC CMDQ by adding a new mmc host interface for it
 - Move Kconfig option MMC_DEBUG from core to host
 - Some additional minor improvements

MMC host:
 - Declare structs as const when applicable
 - Explicitly request exclusive reset control when applicable
 - Improve some error paths and other various cleanups
 - sdhci: Preparations to support SDHCI OMAP
 - sdhci: Improve some PM related code
 - sdhci: Re-factoring and modernizations
 - sdhci-xenon: Add runtime PM and system sleep support
 - sdhci-xenon: Add support for eMMC HS400 Enhanced Strobe
 - sdhci-cadence: Add system sleep support
 - sdhci-of-at91: Improve system sleep support
 - dw_mmc: Add support for Hisilicon hi3660
 - sunxi: Add support for A83T eMMC
 - sunxi: Add support for DDR52 mode
 - meson-gx: Add support for UHS-I SD-cards
 - meson-gx: Cleanups and improvements
 - tmio: Fix CMD12 (STOP) handling
 - tmio: Cleanups and improvements
 - renesas_sdhi: Add r8a7743/5 support
 - renesas-sdhi: Add support for R-Car Gen3 SDHI DMAC
 - renesas_sdhi: Cleanups and improvements

----------------------------------------------------------------
Addy Ke (1):
      mmc: dw_mmc: introduce timer for broken command transfer over scheme

Adrian Hunter (7):
      mmc: core: Remove unused MMC_CAP2_PACKED_CMD
      mmc: core: Add mmc_retune_hold_now()
      mmc: core: Add members to mmc_request and mmc_data for CQE's
      mmc: host: Add CQE interface
      mmc: core: Turn off CQE before sending commands
      mmc: sdhci: Tidy reading 136-bit responses
      mmc: core: Move mmc_start_areq() declaration

Andy Shevchenko (2):
      sdhci: acpi: Use new method to get ACPI companion
      sdhci: pci: Fix up power if device has ACPI companion

Arnd Bergmann (1):
      mmc: test: reduce stack usage in mmc_test_nonblock_transfer

Arvind Yadav (7):
      mmc: sdhci-st: Handle return value of clk_prepare_enable
      mmc: omap_hsmmc: constify dev_pm_ops structures
      mmc: host: via-sdmmc: constify pci_device_id.
      mmc: wmt-sdmmc: Handle return value of clk_prepare_enable
      mmc: mxcmmc: Handle return value of clk_prepare_enable
      mmc: vub300: constify usb_device_id
      mmc: mmci: constify amba_id

Axel Lin (1):
      mmc: cavium-octeon: Convert to use module_platform_driver

Biju Das (2):
      mmc: renesas_sdhi: Add r8a7743/5 support
      mmc: renesas_sdhi: Add r8a7743/5 support

Chaotian Jing (1):
      mmc: mediatek: add ops->get_cd() support

Chen-Yu Tsai (8):
      clk: sunxi-ng: Add interface to query or configure MMC timing modes.
      clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes switching
      clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
      mmc: sunxi: Support controllers that can use both old and new timings
      mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
      mmc: sunxi: Add support for A83T eMMC (MMC2)
      mmc: sunxi: Fix NULL pointer reference on clk_delays
      mmc: sunxi: Fix clock rate passed to sunxi_mmc_clk_set_phase

Chris Paterson (1):
      dt-bindings: mmc: sh_mmcif: Document r8a7743 DT bindings

Colin Ian King (1):
      mmc: rtsx_usb_sdmmc: make array 'width' static const

Fabrizio Castro (1):
      dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings

Gustavo A. R. Silva (2):
      mmc: android-goldfish: remove logically dead code in goldfish_mmc_irq()
      mmc: mxcmmc: fix error return code in mxcmci_probe()

Hu Ziji (2):
      mmc: sdhci-xenon: Add Xenon SDHCI specific system-level PM support
      mmc: sdhci-xenon: Support HS400 Enhanced Strobe feature

Ian Molton (1):
      MMC: Remove HIGHMEM dependency from mmc-spi driver

Icenowy Zheng (1):
      mmc: sunxi: fix support for new timings mode only SoCs

Ivan Mikhaylov (1):
      mmc: sdhci-st: add FSP2(ppc476fpe) into depends for sdhci-st

Jean-Francois Dagenais (1):
      mmc: sdhci-of-arasan: use io functions from sdhci.h

Jerome Brunet (17):
      mmc: meson-gx: fix mux mask definition
      mmc: meson-gx: remove CLK_DIVIDER_ALLOW_ZERO clock flag
      mmc: meson-gx: clean up some constants
      mmc: meson-gx: initialize sane clk default before clock register
      mmc: meson-gx: cfg init overwrite values
      mmc: meson-gx: rework set_ios function
      mmc: meson-gx: rework clk_set function
      mmc: meson-gx: rework clock init function
      mmc: meson-gx: fix dual data rate mode frequencies
      mmc: meson-gx: work around clk-stop issue
      mmc: meson-gx: simplify interrupt handler
      mmc: meson-gx: implement card_busy callback
      mmc: meson-gx: use CCF to handle the clock phases
      mmc: meson-gx: implement voltage switch callback
      mmc: meson-gx: change default tx phase
      mmc: meson-gx: rework tuning function
      mmc: meson-gx: fix __ffsdi2 undefined on arm32

Julia Lawall (19):
      mmc: atmel-mci: add missing of_node_put
      mmc: wmt-sdmmc: constify mmc_host_ops structures
      mmc: s3cmci: constify mmc_host_ops structures
      mmc: davinci: constify mmc_host_ops structures
      mmc: moxart: constify mmc_host_ops structures
      mmc: sh_mmcif: constify mmc_host_ops structures
      mmc: toshsd: constify mmc_host_ops structures
      mmc: usdhi6rol0: constify mmc_host_ops structures
      mmc: vub300: constify mmc_host_ops structures
      mmc: sunxi: constify mmc_host_ops structures
      mmc: sdricoh_cs: constify mmc_host_ops structures
      mmc: mediatek: constify mmc_host_ops structures
      mmc: bcm2835: constify mmc_host_ops structures
      mmc: sdhci: constify sdhci_pltfm_data structures
      mmc: sdhci-bcm-kona: constify sdhci_pltfm_data and sdhci_ops structures
      mmc: sdhci-sirf: constify sdhci_pltfm_data and sdhci_ops structures
      mmc: sdhci-of-arasan: constify sdhci_pltfm_data and sdhci_ops structures
      mmc: sdhci-brcmstb: constify sdhci_pltfm_data structures
      mmc: renesas-sdhi: constify renesas_sdhi_internal_dmac_dma_ops

Kishon Vijay Abraham I (1):
      mmc: sdhci: Add quirk to indicate MMC_RSP_136 has CRC

Linus Walleij (6):
      mmc: block: Anonymize the drv op data pointer
      mmc: ops: export mmc_get_status()
      mmc: debugfs: Move block debugfs into block module
      mmc: block: Move duplicate check
      mmc: block: Refactor mmc_blk_part_switch()
      mmc: block: Reparametrize mmc_blk_ioctl_[multi]_cmd()

Masahiro Yamada (6):
      mmc: of_mmc_spi: fix restricted cast warning of sparse
      mmc: sdhci-msm: add static to local functions
      mmc: sdhci-cadence: add suspend / resume support
      mmc: sdhci-pxav2: switch to managed clk and sdhci_pltfm_unregister()
      mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
      mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume

Maxime Ripard (2):
      clk: sunxi-ng: Provide a default reset hook
      mmc: sunxi: Reset the device at probe time

Michał Mirosław (4):
      mmc: sdhci: key 8BITBUS bit off MMC_CAP_8_BIT_DATA
      mmc: sdhci-tegra: use generic sdhci_set_bus_width()
      mmc: sdhci-pci: use generic sdhci_set_bus_width()
      mmc: sdhci-s3c: use generic sdhci_set_bus_width()

Philipp Zabel (4):
      mmc: dw_mmc: explicitly request exclusive reset control
      mmc: sdhci-st: explicitly request exclusive reset control
      mmc: sunxi: explicitly request exclusive reset control
      mmc: tegra: explicitly request exclusive reset control

Quentin Schulz (2):
      mmc: sdhci-of-at91: factor out clks and presets setting
      mmc: sdhci-of-at91: set clocks and presets after resume from deepest PM

Rob Herring (1):
      mmc: Convert to using %pOF instead of full_name

Shawn Lin (17):
      Documentation: rockchip-dw-mshc: add description for rk3228
      mmc: mmc_ops: fix a typo for comment of mmc_start_bkops
      mmc: mxcmmc: check the return value of mxcmci_finish_data
      mmc: block: remove unused struct mmc_card *card
      mmc: sdhci-xenon: remove pointless struct xenon_priv *priv
      mmc: atmel-mci: remove unused sg_len variable
      arc: remove num-slots from arc platforms
      mmc: sdhci-acpi: remove unused struct sdhci_host variable
      mmc: core: remove check of host->removed for rescan routine
      mmc: core: always check the length of sglist with total data size
      mmc: core: turn the pr_info under CONFIG_MMC_DEBUG into pr_debug
      mmc: Kconfig: downgrade CONFIG_MMC_DEBUG for host drivers only
      mmc: wbsd: remove CONFIG_MMC_DEBUG from the driver
      mmc: sdhci: remove CONFIG_MMC_DEBUG from the driver
      mmc: core: correct taac parameter according to the specification
      mmc: core: remove the check of mmc_card_blockaddr for SD cards
      mmc: block: cast a informative log for no devidx available

Simon Horman (3):
      mmc: tmio, renesas-sdhi: add dataend to DMA ops
      mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
      mmc: renesas-sdhi: provide a whitelist for Gen3 SoC ES versions

Srinivas Kandagatla (3):
      mmc: sdhci: add sdma_boundary member to struct sdhci_host
      mmc: sdhci-msm: set sdma_boundary to zero
      mmc: mmci: stop building qcom dml as module

Ulf Hansson (1):
      Merge branch 'fixes' into next

Will Newton (1):
      mmc: omap_hsmmc: Reduce max_segs for reliability

Wolfram Sang (10):
      mmc: tmio: fix CMD12 (STOP) handling
      mmc: tmio: remove obsolete TMIO_BBS
      mmc: tmio: add references to bit defines in the header
      mmc: tmio: no magic values when enabling DMA
      mmc: tmio: don't wait on R-Car2+ when handling the clock
      mmc: renesas_sdhi_core: on R-Car 2+, make use of CBSY bit
      mmc: renesas_sdhi: use extra flag for CBSY usage
      mmc: renesas_sdhi: enably CBSY bit for RZ platform
      mmc: renesas_sdhi: document version of RZ/A1 instance
      mmc: sdhi: use maximum width for the sdbuf register

Yoshihiro Shimoda (1):
      mmc: tmio, renesas-sdhi: add max_{segs, blk_count} to tmio_mmc_data

Zhoujie Wu (3):
      mmc: sdhci-xenon: ignore timing DDR52 in tuning
      mmc: sdhci: ignore restoring the I/O state if MMC_POWER_OFF
      mmc: sdhci-xenon: add runtime pm support and reimplement standby

liwei (2):
      mmc: dw_mmc: move controller reset before driver init
      mmc: dw_mmc-k3: add sd support for hi3660

yangbo lu (2):
      mmc: sdhci: fix SDHCI_QUIRK_NO_HISPD_BIT handling
      mmc: sdhci-of-esdhc: support ESDHC_CAPABILITIES_1 accessing

 .../devicetree/bindings/mmc/renesas,mmcif.txt      |   4 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   1 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   8 +-
 arch/arc/boot/dts/axs10x_mb.dtsi                   |   1 -
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi               |   1 -
 drivers/clk/sunxi-ng/Makefile                      |   1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              |  10 +-
 drivers/clk/sunxi-ng/ccu_common.h                  |   4 +
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              |  70 ++
 drivers/clk/sunxi-ng/ccu_mp.c                      |  80 +++
 drivers/clk/sunxi-ng/ccu_mp.h                      |  30 +
 drivers/clk/sunxi-ng/ccu_reset.c                   |  12 +
 drivers/mmc/Kconfig                                |   7 -
 drivers/mmc/Makefile                               |   2 -
 drivers/mmc/core/block.c                           | 271 ++++++--
 drivers/mmc/core/core.c                            |  68 +-
 drivers/mmc/core/core.h                            |   6 +
 drivers/mmc/core/debugfs.c                         |  89 ---
 drivers/mmc/core/host.c                            |   6 +
 drivers/mmc/core/host.h                            |   1 +
 drivers/mmc/core/mmc.c                             |  31 +-
 drivers/mmc/core/mmc_ops.c                         |   3 +-
 drivers/mmc/core/mmc_test.c                        |  97 ++-
 drivers/mmc/core/queue.h                           |   6 +-
 drivers/mmc/core/sd.c                              |  12 +-
 drivers/mmc/host/Kconfig                           |  34 +-
 drivers/mmc/host/Makefile                          |  13 +-
 drivers/mmc/host/android-goldfish.c                |   8 +-
 drivers/mmc/host/atmel-mci.c                       |  10 +-
 drivers/mmc/host/bcm2835.c                         |   2 +-
 drivers/mmc/host/cavium-octeon.c                   |  13 +-
 drivers/mmc/host/cavium.c                          |   6 +-
 drivers/mmc/host/davinci_mmc.c                     |   2 +-
 drivers/mmc/host/dw_mmc-k3.c                       | 298 +++++++++
 drivers/mmc/host/dw_mmc.c                          |  62 +-
 drivers/mmc/host/dw_mmc.h                          |   4 +
 drivers/mmc/host/meson-gx-mmc.c                    | 714 ++++++++++++++-------
 drivers/mmc/host/mmci.c                            |   2 +-
 drivers/mmc/host/moxart-mmc.c                      |   2 +-
 drivers/mmc/host/mtk-sd.c                          |   3 +-
 drivers/mmc/host/mxcmmc.c                          |  34 +-
 drivers/mmc/host/of_mmc_spi.c                      |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |   8 +-
 drivers/mmc/host/renesas_sdhi.h                    |   2 +
 drivers/mmc/host/renesas_sdhi_core.c               |  31 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      | 287 +++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  34 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   2 +-
 drivers/mmc/host/s3cmci.c                          |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |   7 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   4 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |  39 +-
 drivers/mmc/host/sdhci-cadence.c                   |  88 ++-
 drivers/mmc/host/sdhci-esdhc.h                     |   3 +
 drivers/mmc/host/sdhci-msm.c                       |   5 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |   8 +-
 drivers/mmc/host/sdhci-of-at91.c                   | 177 +++--
 drivers/mmc/host/sdhci-of-esdhc.c                  |  23 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  50 +-
 drivers/mmc/host/sdhci-pic32.c                     |   2 +-
 drivers/mmc/host/sdhci-pltfm.c                     |  28 +-
 drivers/mmc/host/sdhci-pltfm.h                     |   2 +
 drivers/mmc/host/sdhci-pxav2.c                     |  30 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   2 +-
 drivers/mmc/host/sdhci-s3c.c                       |  34 +-
 drivers/mmc/host/sdhci-sirf.c                      |  43 +-
 drivers/mmc/host/sdhci-st.c                        |  28 +-
 drivers/mmc/host/sdhci-tegra.c                     |  26 +-
 drivers/mmc/host/sdhci-xenon-phy.c                 |  34 +-
 drivers/mmc/host/sdhci-xenon.c                     | 102 ++-
 drivers/mmc/host/sdhci-xenon.h                     |   2 +
 drivers/mmc/host/sdhci.c                           |  94 +--
 drivers/mmc/host/sdhci.h                           |   5 +
 drivers/mmc/host/sdricoh_cs.c                      |   2 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/sunxi-mmc.c                       |  95 ++-
 drivers/mmc/host/tmio_mmc.h                        |   9 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  32 +-
 drivers/mmc/host/toshsd.c                          |   2 +-
 drivers/mmc/host/usdhi6rol0.c                      |   2 +-
 drivers/mmc/host/via-sdmmc.c                       |   2 +-
 drivers/mmc/host/vub300.c                          |   4 +-
 drivers/mmc/host/wbsd.c                            |   2 -
 drivers/mmc/host/wmt-sdmmc.c                       |   8 +-
 include/linux/clk/sunxi-ng.h                       |  35 +
 include/linux/mfd/tmio.h                           |   5 +
 include/linux/mmc/card.h                           |   4 +-
 include/linux/mmc/core.h                           |  23 +-
 include/linux/mmc/host.h                           |  60 +-
 include/trace/events/mmc.h                         |  36 +-
 91 files changed, 2559 insertions(+), 997 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu_mmc_timing.c
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
 create mode 100644 include/linux/clk/sunxi-ng.h
