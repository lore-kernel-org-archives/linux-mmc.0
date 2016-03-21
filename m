From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.6
Date: Mon, 21 Mar 2016 13:59:33 +0100
Message-ID: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36066 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbcCUM7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2016 08:59:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id r129so49370532wmr.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Mar 2016 05:59:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>

Hi Linus,

Here's the PR for MMC v4.6.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.6

for you to fetch changes up to 64e5cd723120643a4c8bef0880a03a60161d3ccb:

  mmc: sdhci-of-at91: fix wake-up issue when using runtime pm
(2016-03-18 09:12:32 +0100)

----------------------------------------------------------------
MMC core:
 - Fix ABI regression of MMC BLK ioctl
 - Remove the unused MMC_DATA_STREAM flag
 - Enable asynchronous system PM for the host device
 - Minor fixes and clean-ups

SDHCI host:
Throughout the years, the numbers of SDHCI variants have increased and so
has also the numbers of SDHCI callbacks/quirks. The purpose of these
callbacks/quirks were to enable SDHCI to deal with variant specific
requirements, but unfortunate this method didn't scale. Instead we have
ended up with a mess. Not only did the code become suboptimal but also
highly fragile.

Lately many discussions of how to move forward with SDHCI has taken place
at the MMC mailing list. Step by step, we aim to turn SDHCI's common code
into a set of library functions. This will enable for optimizations and
allow some of the existing callbacks/quirks to be removed, which also
should help to make the code less fragile.

Therefore I am also really pleased to announce that Adrian Hunter (Intel)
has volunteered to step in as the maintainer for SDHCI.

Future wise, I hope the community around SDHCI will continue to grow and
that this release cycle can be the starting point of moving SDHCI into a
better shape. As a matter of fact, already in this cycle the re-factoring
has begun, but of course there are also fixes and new features included.
Some highlights:

 - sdhci-iproc: Add support for Broadcom's BCM2835 eMMC IP
 - sdhci-acpi: Add support for QCOM controllers
 - sdhci-pic32: Add new SDHCI variant for PIC32MZDA

Other hosts:
 - atmel-mci: Fix a NULL pointer dereference
 - mediatek: Add SD write-protect support
 - mmc_spi: Fix card detect in GPIO case
 - tmio/sdhi: Add r8a7795 support
 - tmio/sdhi: Some fixes and clean-ups
 - dw_mmc: Add HW reset support
 - dw_mmc: Some fixes and clean-ups
 - sunxi: Add support for MMC DDR52 mode

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix override of timeout clk wrt max_busy_timeout

Al Cooper (1):
      mmc: sdhci: Allow CAPS check for SDHCI_CAN_64BIT to use overridden caps

Alexandre Courbot (3):
      mmc: sdhci: Set DMA mask when adding host
      mmc: sdhci-acpi: Remove enable_dma() hook
      mmc: sdhci-pci: Do not set DMA mask in enable_dma()

Andrei Pistirica (2):
      dt/bindings: mmc: Add bindings for PIC32 SDHCI host controller
      mmc: sdhci-pic32: Add PIC32 SDHCI host controller driver

Arnd Bergmann (1):
      mmc: omap_hsmmc: don't print uninitialized variables

Brent Taylor (1):
      mmc: atmel-mci: Check pdata for NULL before dereferencing it at DMA config

Brian Norris (1):
      mmc: of_mmc_spi: fix unused warning

Chaotian Jing (1):
      mmc: mediatek: add SD write protect support

Chen-Yu Tsai (6):
      mmc: sunxi: Document host init sequence
      mmc: sunxi: Return error on mmc_regulator_set_ocr() fail in .set_ios op
      mmc: sunxi: Support vqmmc regulator
      mmc: sunxi: Support MMC_DDR52 timing modes
      mmc: sunxi: Support 8 bit eMMC DDR transfer modes
      mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support

Chuanxiao Dong (1):
      mmc: debugfs: Add a restriction to mmc debugfs clock setting

Fu, Zhonghui (2):
      mmc: core: enable mmc host device to suspend/resume asynchronously
      mmc: sdhci-acpi: enable sdhci-acpi device to suspend/resume asynchronously

Geliang Tang (2):
      mmc: sh_mmcif: use to_delayed_work
      mmc: usdhi6rol0: use to_delayed_work

Jaehoon Chung (13):
      mmc: core: use the defined function to check whether card is removable
      mmc: atmel-mci: remove the MMC_DATA_STREAM flag
      mmc: bfin_sdh: remove the MMC_DATA_STREAM flag
      mmc: davinci_mmc: remove the MMC_DATA_STREAM flag
      mmc: dw_mmc: remove the MMC_DATA_STREAM flag
      mmc: jz4740_mmc: remove the MMC_DATA_STREAM flag
      mmc: mxcmmc: remove the MMC_DATA_STREAM flag
      mmc: pxamci: remove the MMC_DATA_STREAM flag
      mmc: s3cmci: remove the MMC_DATA_STREAM flag
      mmc: sunxi-mmc: remove the MMC_DATA_STREAM flag
      mmc: core: remove the MMC_DATA_STREAM flag
      mmc: block: don't use the OR operation for flag of data
      mmc: dw_mmc: remove the prepare_command hook

Jisheng Zhang (14):
      mmc: sdhci-iproc: use sdhci_pltfm_unregister directly
      mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
      mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
      mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of sdhci_msm_host
      mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
      mmc: sdhci-of-arasan: fix clk issue in sdhci_arasan_remove()
      mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
      mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
      mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
      mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
      mmc: sdhci-st: use sdhci_pltfm_init for private allocation
      mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
      mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
      mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host

Jon Hunter (1):
      mmc: tegra: Disable UHS-I modes for tegra114

Kishon Vijay Abraham I (1):
      mmc: host: omap_hsmmc: add a verbose print to enable
CONFIG_REGULATOR_PBIAS

Lucas Stach (2):
      mmc: tegra: properly disable card clock
      mmc: tegra: implement memcomp pad calibration

Magnus Damm (1):
      mmc: mmc_spi: Add Card Detect comments and fix CD GPIO case

Markus Elfring (2):
      mmc: sdricoh_cs: Delete unnecessary variable initialisations
      mmc: sdricoh_cs: Less checks in sdricoh_init_mmc() after, error detection

Masahiro Yamada (1):
      mmc: remove unnecessary assignment statements before return

Nicolas Boichat (2):
      mmc: mediatek: Change signal voltage error to dev_dbg()
      mmc: mediatek: Use mmc_regulator_set_vqmmc in start_signal_voltage_switch

Peter Chen (1):
      mmc: core: pwrseq_simple: remove unused header file

Philip Elcan (1):
      mmc: sdhci-acpi: add QCOM controllers

Rameshwar Prasad Sahu (1):
      mmc: sdhci-of-arasan: Remove no-hispd and no-cmd23 quirks for
sdhci-arasan4.9a

Russell King (26):
      mmc: core: shut up "voltage-ranges unspecified" pr_info()
      mmc: core: improve mmc_of_parse_voltage() to return better status
      mmc: block: shut up "retrying because a re-tune was needed" message
      mmc: core: report tuning command execution failure reason
      mmc: sdhci: move initialisation of command error member
      mmc: sdhci: clean up command error handling
      mmc: sdhci: fix command response CRC error handling
      mmc: sdhci: avoid unnecessary mapping/unmapping of align buffer
      mmc: sdhci: plug DMA mapping leak on error
      mmc: sdhci-pxav3: fix higher speed mode capabilities
      mmc: sdhci: further fix for DMA unmapping in sdhci_post_req()
      mmc: sdhci: fix data timeout (part 1)
      mmc: sdhci: fix data timeout (part 2)
      mmc: sdhci: allocate alignment and DMA descriptor buffer together
      mmc: sdhci: clean up coding style in sdhci_adma_table_pre()
      mmc: sdhci: avoid walking SG list for writes
      mmc: sdhci: factor out common DMA cleanup in sdhci_finish_data()
      mmc: sdhci: move sdhci_pre_dma_transfer()
      mmc: sdhci: factor out sdhci_pre_dma_transfer() from
sdhci_adma_table_pre()
      mmc: sdhci: pass the cookie into sdhci_pre_dma_transfer()
      mmc: sdhci: always unmap a mapped data transfer in sdhci_post_req()
      mmc: sdhci: clean up host cookie handling
      mmc: sdhci: cleanup DMA un-mapping
      mmc: sdhci: prepare DMA address/size quirk handling consolidation
      mmc: sdhci: consolidate the DMA/ADMA size/address quicks
      mmc: sdhci: further code simplication

Shawn Lin (13):
      mmc: dw_mmc: add hw_reset support
      mmc: dw_mmc: remove struct block_settings
      mmc: dw_mmc: remove DW_MCI_QUIRK_BROKEN_CARD_DETECTION quirk
      mmc: dw_mmc: fix err handle of dw_mci_probe
      mmc: dw_mmc: remove repetitive clear interrupt
      mmc: dw_mmc: fix num_slots setting
      Documentation: bindings: add description of phy for sdhci-of-arasan
      mmc: sdhci-of-arasan: remove disable clk_ahb from sdhci_arasan_resume
      mmc: sdhci-of-arasan: fix missing sdhci_pltfm_free for err handling
      mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan
      mmc: core: remove redundant memset of mmc_decode_cid
      mmc: core: remove redundant memset of sdio_read_cccr
      mmc: block: fix ABI regression of mmc_blk_ioctl

Shinobu Uehara (1):
      mmc: sdhi: Add EXT_ACC register busy check

Simon Horman (1):
      mmc: sh_mmcif, tmio: Use ARCH_RENESAS

Stefan Wahren (5):
      mmc: sdhci-iproc: Clean up platform allocations if shdci init fails
      mmc: sdhci-iproc: Actually enable the clock
      mmc: sdhci-iproc: define MMC caps in platform data
      mmc: sdhci-iproc: add bcm2835 support
      mmc: DT: sdhci-iproc: add bcm2835 compatible

Ulf Hansson (1):
      MAINTAINERS: mmc: Add Adrian Hunter as the maintainer for SDHCI

Wang Hongcheng (1):
      mmc: mmci: Remove unnecessary header file

Wolfram Sang (12):
      mmc: make MAN_BKOPS_EN message a debug
      mmc: mmcif: don't depend on MMC_BLOCK
      mmc: mmc_test: mention that '0' runs all tests
      mmc: sanitize 'bus width' in debug output
      mmc: tmio_dma: remove debug messages with little information
      mmc: sdhi: error message on ENOMEM is superfluous
      mmc: tmio: add flag to reduce delay after changing clock status
      mmc: tmio: remove stale comments
      mmc: sdhi: use faster clock handling on RCar Gen2
      mmc: tmio: refactor set_clock a little
      mmc: tmio: disable clock before changing it
      mmc: sdhi: Add r8a7795 support

ludovic.desroches@atmel.com (1):
      mmc: sdhci-of-at91: fix wake-up issue when using runtime pm

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  20 +-
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |   5 +-
 .../bindings/mmc/microchip,sdhci-pic32.txt         |  29 ++
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 MAINTAINERS                                        |   8 +-
 drivers/mmc/card/block.c                           |  34 +-
 drivers/mmc/card/mmc_test.c                        |   1 +
 drivers/mmc/core/core.c                            |  29 +-
 drivers/mmc/core/debugfs.c                         |   2 +-
 drivers/mmc/core/host.c                            |   1 +
 drivers/mmc/core/mmc.c                             |   4 +-
 drivers/mmc/core/mmc_ops.c                         |  19 +-
 drivers/mmc/core/pwrseq_simple.c                   |   1 -
 drivers/mmc/core/sd.c                              |   2 -
 drivers/mmc/core/sd_ops.c                          |   7 +-
 drivers/mmc/core/sdio.c                            |   2 -
 drivers/mmc/core/sdio_ops.c                        |   3 +-
 drivers/mmc/host/Kconfig                           |  25 +-
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci.c                       |  11 +-
 drivers/mmc/host/bfin_sdh.c                        |   3 -
 drivers/mmc/host/davinci_mmc.c                     |  15 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  31 +-
 drivers/mmc/host/dw_mmc-pltfm.c                    |  19 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   7 -
 drivers/mmc/host/dw_mmc.c                          | 101 +++--
 drivers/mmc/host/dw_mmc.h                          |   6 +-
 drivers/mmc/host/jz4740_mmc.c                      |   2 -
 drivers/mmc/host/mmc_spi.c                         |   6 +
 drivers/mmc/host/mmci.c                            |   1 -
 drivers/mmc/host/mtk-sd.c                          |  19 +-
 drivers/mmc/host/mxcmmc.c                          |   3 -
 drivers/mmc/host/of_mmc_spi.c                      |   2 -
 drivers/mmc/host/omap_hsmmc.c                      |   9 +-
 drivers/mmc/host/pxamci.c                          |   6 -
 drivers/mmc/host/s3cmci.c                          |   3 +-
 drivers/mmc/host/sdhci-acpi.c                      |  47 +-
 drivers/mmc/host/sdhci-bcm2835.c                   |  14 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  38 +-
 drivers/mmc/host/sdhci-iproc.c                     |  40 +-
 drivers/mmc/host/sdhci-msm.c                       |  25 +-
 drivers/mmc/host/sdhci-of-arasan.c                 | 109 +++--
 drivers/mmc/host/sdhci-of-at91.c                   |  53 ++-
 drivers/mmc/host/sdhci-of-esdhc.c                  |  19 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  15 -
 drivers/mmc/host/sdhci-pic32.c                     | 257 +++++++++++
 drivers/mmc/host/sdhci-pltfm.h                     |   1 -
 drivers/mmc/host/sdhci-pxav2.c                     |   1 -
 drivers/mmc/host/sdhci-pxav3.c                     |  26 +-
 drivers/mmc/host/sdhci-st.c                        |  40 +-
 drivers/mmc/host/sdhci-tegra.c                     |  82 +++-
 drivers/mmc/host/sdhci.c                           | 500 ++++++++++-----------
 drivers/mmc/host/sdhci.h                           |   4 +-
 drivers/mmc/host/sdricoh_cs.c                      |  26 +-
 drivers/mmc/host/sh_mmcif.c                        |   2 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |  54 ++-
 drivers/mmc/host/sunxi-mmc.c                       |  95 +++-
 drivers/mmc/host/tmio_mmc_dma.c                    |  11 -
 drivers/mmc/host/tmio_mmc_pio.c                    |  27 +-
 drivers/mmc/host/usdhi6rol0.c                      |   2 +-
 include/linux/mfd/tmio.h                           |   4 +
 include/linux/mmc/core.h                           |   1 -
 include/linux/mmc/dw_mmc.h                         |  12 +-
 include/linux/mmc/tmio.h                           |   5 +
 64 files changed, 1171 insertions(+), 777 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mmc/microchip,sdhci-pic32.txt
 create mode 100644 drivers/mmc/host/sdhci-pic32.c
