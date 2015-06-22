From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.2
Date: Mon, 22 Jun 2015 13:28:25 +0200
Message-ID: <CAPDyKFoNhD3Y71b+wdoKXH6-fcsq-H-5rby72Ru1+n5q6QiATw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33352 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbbFVL20 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jun 2015 07:28:26 -0400
Received: by qkhu186 with SMTP id u186so98618265qkh.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2015 04:28:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>

Hi Linus,

Here are the PR for MMC for v4.2.

Details about the MMC highlights are found in the signed tag. Please
pull this in!

Kind regards
Ulf Hansson


The following changes since commit ba155e2d21f6bf05de86a78dbe5bfd8757604a65:

  Linux 4.1-rc5 (2015-05-24 18:22:35 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.2

for you to fetch changes up to a8c27c0bea45c6531fbc1e3be79ddd5a9bc1ba3e:

  mmc: queue: prevent soft lockups on PREEMPT=n (2015-06-18 09:21:04 +0200)

----------------------------------------------------------------
MMC core:
 - Fix an error path in the mmc block layer
 - Fix PM domain attachment for the SDIO bus
 - Add support for driver strength selection
 - Increase a delay to let voltage stabilize
 - Add support for disabling write-protect detection
 - Add facility to support re-tuning
 - Re-tune and retry in the recovery path
 - Add reset option for SDIO
 - Consolidations and clean-ups

MMC host:
 - Add Mediatek MMC driver
 - Constify platform_device_id for a couple of hosts
 - Fix modalias to make module auto-loading work for a couple of hosts
 - sdhci: Add support for sdhci-arasan4.9a
 - sdhci: Fix low memory corruption
 - sdhci: Restore behavior while creating OCR mask
 - sdhci: Add a callback to select drive strength
 - sdhci: Fix driver type B and D handling
 - sdhci: Add support for drive strength selection for SPT
 - sdhci: Enable HS400 for some Intel host controllers
 - sdhci: Convert to use the new re-tuning facility
 - sdhci: Various minor fixes and clean-ups
 - dw_mmc: Add support for hi6220
 - dw_mmc: Use core to handle absent write protect line
 - dw_mmc: Add support to switch voltage
 - tmio: Some fixes and modernizations
 - sh_mmcif: Improve clock rate calculation

----------------------------------------------------------------
Adrian Hunter (25):
      mmc: host: Add facility to support re-tuning
      mmc: core: Enable / disable re-tuning
      mmc: core: Add support for re-tuning before each request
      mmc: core: Hold re-tuning during switch commands
      mmc: core: Hold re-tuning during erase commands
      mmc: core: Hold re-tuning while bkops ongoing
      mmc: mmc: Hold re-tuning in mmc_sleep()
      mmc: core: Separate out the mmc_switch status check so it can be re-used
      mmc: core: Add support for HS400 re-tuning
      mmc: sdhci: Change to new way of doing re-tuning
      mmc: core: Flag re-tuning is needed on CRC errors
      mmc: block: Check re-tuning in the recovery path
      mmc: block: Retry errored data requests when re-tuning is needed
      mmc: core: Don't print reset warning if reset is not supported
      mmc: core: Reset driver type to default
      mmc: core: Allow card drive strength to be different to host
      mmc: core: Simplify card drive strength mask
      mmc: core: Add 'card' to drive strength selection callback
      mmc: core: Factor out common code in drive strength selection
      mmc: core: Record card drive strength
      mmc: mmc: Read card's valid driver strength mask
      mmc: mmc: Add driver strength selection
      mmc: sdhci: Add a callback to select drive strength
      mmc: sdhci-pci: Add support for drive strength selection for SPT
      mmc: sdhci-pci: Enable HS400 for some Intel host controllers

Andreas Fenkart (2):
      mmc: sdio: add reset callback to bus operations
      mmc: pwrseq: dt: example with reset clock and active low pin

Axel Lin (3):
      mmc: sdhci_f_sdh30: Staticize local functions
      mmc: sdhci_f_sdh30: Fix the size passed to sdhci_alloc_host
      mmc: sdhci-{pxav2,pxav3}: Use of_match_ptr() macro

Ben Hutchings (1):
      MAINTAINERS: mmc: Update Ian Molton's address for tmio_mmc driver

Chaotian Jing (3):
      mmc: dt-bindings: add Mediatek MMC bindings
      mmc: mediatek: Add Mediatek MMC driver
      mmc: mediatek: Add PM support for MMC driver

Ding Wang (1):
      mmc: card: Fixup request missing in mmc_blk_issue_rw_rq

Dong Aisheng (6):
      mmc: sdhci-esdhc-imx: merge the same register check into one place
      mmc: sdhci-esdhc-imx: usdhc does not have missing card interrupt issue
      mmc: sdhci-esdhc-imx: add ADMA Length Mismatch errata fix
      mmc: sdhci-esdhc-imx: using specific compatible string in binding doc
      mmc: sdhci-esdhc-imx: add imx6sx support
      mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl

Doug Anderson (1):
      mmc: core: Increase delay for voltage to stabilize from 3.3V to 1.8V

Eric Anholt (2):
      mmc: sdhci-bcm2835: Clean up platform allocations if sdhci init fails.
      mmc: sdhci-bcm2835: Actually enable the clock

Fabian Frederick (2):
      mmc: mmc-test: use swap() in mmc_test_nonblock_transfer()
      mmc: queue: use swap() in mmc_queue_thread()

Fabio Estevam (5):
      mmc: sdhci-esdhc-imx: Move mmc_of_parse() to the dt probe
      mmc: sdhci-esdhc-imx: Do not break platform data boards
      mmc: card: mmc_test: Simplify a trivial if-return sequence
      mmc: host: mxcmmc: Simplify a trivial if-return sequence
      mmc: host: sdhci: Use BUG_ON()

Ian Molton (3):
      mmc: TMIO: Ensure MFD cell is disabled on probe error path
      mmc: TMIO: Fix I/O mapping leak on error using devm_ioremap()
      mmc: TMIO: Use devm_request_irq()

Jiri Slaby (1):
      mmc: sdhci: fix low memory corruption

Jisheng Zhang (1):
      mmc: sdhci-pxav3: fix device wakeup initialization

Joakim Tjernlund (1):
      mmc: sdhci-of-esdhc: Pre divider starts at 1

Krzysztof Kozlowski (6):
      mmc: davinci: Constify platform_device_id
      mmc: mxs: Constify platform_device_id
      mmc: rtsx: Constify platform_device_id
      mmc: s3cmci: Constify platform_device_id
      mmc: sdhci-imx: Constify platform_device_id
      mmc: sdhci-s3c: Constify platform_device_id

Kuninori Morimoto (9):
      mmc: sh_mmcif: move mmcif_of_match to upside
      mmc: sh_mmcif: cleanup to use dev instead of &pdev->dev
      mmc: sh_mmcif: remove unnecessary int clk from struct sh_mmcif_host
      mmc: sh_mmcif: separate sh_mmcif_clk_update() into setup and prepare
      mmc: cast u8 to unsigned long long to avoid unexpected error
      mmc: cast unsigned int to typeof(sector_t) to avoid unexpected error
      mmc: sh_mmcif: add sh_mmcif_host_to_dev() macro and use it.
      mmc: sh_mmcif: use sh_mmcif_xxx prefix for all functions
      mmc: sh_mmcif: calculate best clock with parent clock

Lars-Peter Clausen (3):
      mmc: Add support for disabling write-protect detection
      mmc: dt: Allow to specify that no write protect signal is present
      mmc: dw_mmc: Use core to handle absent write protect line

Petri Gynther (1):
      mmc: sdhci: fix driver type B and D handling in sdhci_do_set_ios()

Prabu Thangamuthu (1):
      mmc: dw_mmc: insmod followed by rmmod will hung for eMMC

Rabin Vincent (1):
      mmc: queue: prevent soft lockups on PREEMPT=n

Suman Tripathi (1):
      mmc: sdhci-of-arasan: Add the support for sdhci-arasan4.9a

Ulf Hansson (4):
      mmc: core: Remove redundant ->power_restore() callback for MMC
      mmc: core: Remove redundant ->power_restore() callback for SD
      mmc: core: Attach PM domain prior probing of SDIO func driver
      mmc: sdhci: Restore behavior while creating OCR mask

Vincent Wan (3):
      pci_ids: Add AMD KERNCZ device ID support
      i2c-piix4: Use Macro for AMD CZ SMBus device ID
      mmc: sdhci-pci: Change AMD SDHCI quirk application scope

Weijun Yang (2):
      mmc: sdhci-sirf: fix the tuning count in platform_execute_tuning
      mmc: sdhci-sirf: fake version and capbility registers

Wolfram Sang (1):
      mmc: host: sdhci-esdhc-imx: fix broken email address

Yangbo Lu (2):
      powerpc/dts: add eSDHC compatible list
      mmc: sdhci-of-esdhc: enable interrupt mode to detect card

Zhangfei Gao (7):
      Document: dw_mmc-k3: add document of hi6220 mmc
      mmc: dw_mmc: add switch_voltage
      mmc: dw_mmc: k3: support hi6220
      mmc: dw_mmc: k3: Fix modalias to make module auto-loading work
      mmc: dw_mmc: exynos: Fix modalias to make module auto-loading work
      mmc: dw_mmc: rockchip: Fix modalias to make module auto-loading work
      mmc: sdhci-st: Fix modalias to make module auto-loading work

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |    3 +-
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    9 +-
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   28 +
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |    4 +-
 Documentation/devicetree/bindings/mmc/mmc.txt      |    5 +
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |   32 +
 .../devicetree/bindings/mmc/renesas,mmcif.txt      |    3 +
 MAINTAINERS                                        |    2 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |    1 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |    1 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |    1 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |    1 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |    1 +
 drivers/i2c/busses/i2c-piix4.c                     |    4 +-
 drivers/mmc/card/block.c                           |   25 +-
 drivers/mmc/card/mmc_test.c                        |  104 +-
 drivers/mmc/card/queue.c                           |    6 +-
 drivers/mmc/card/queue.h                           |    1 +
 drivers/mmc/core/core.c                            |  100 +-
 drivers/mmc/core/core.h                            |    4 +
 drivers/mmc/core/host.c                            |   88 ++
 drivers/mmc/core/host.h                            |    6 +
 drivers/mmc/core/mmc.c                             |  156 ++-
 drivers/mmc/core/mmc_ops.c                         |   44 +-
 drivers/mmc/core/mmc_ops.h                         |    1 +
 drivers/mmc/core/sd.c                              |  113 +-
 drivers/mmc/core/sdio.c                            |   90 +-
 drivers/mmc/core/sdio_bus.c                        |   12 +-
 drivers/mmc/host/Kconfig                           |    9 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/davinci_mmc.c                     |    2 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |    2 +-
 drivers/mmc/host/dw_mmc-k3.c                       |  105 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |    2 +-
 drivers/mmc/host/dw_mmc.c                          |   63 +-
 drivers/mmc/host/dw_mmc.h                          |    5 +-
 drivers/mmc/host/mtk-sd.c                          | 1462 ++++++++++++++++++++
 drivers/mmc/host/mxcmmc.c                          |    6 +-
 drivers/mmc/host/mxs-mmc.c                         |    2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |    2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |    2 +-
 drivers/mmc/host/s3cmci.c                          |    2 +-
 drivers/mmc/host/sdhci-bcm2835.c                   |   12 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   94 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |    7 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |   11 +-
 drivers/mmc/host/sdhci-pci-data.c                  |    3 +
 drivers/mmc/host/sdhci-pci.c                       |  109 +-
 drivers/mmc/host/sdhci-pci.h                       |    4 +
 drivers/mmc/host/sdhci-pxav2.c                     |    4 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   10 +-
 drivers/mmc/host/sdhci-s3c.c                       |    2 +-
 drivers/mmc/host/sdhci-sirf.c                      |   44 +-
 drivers/mmc/host/sdhci-st.c                        |    2 +-
 drivers/mmc/host/sdhci.c                           |  151 +-
 drivers/mmc/host/sdhci.h                           |    7 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |    9 +-
 drivers/mmc/host/sh_mmcif.c                        |  296 ++--
 drivers/mmc/host/tmio_mmc.c                        |   10 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |    5 +-
 include/linux/mmc/card.h                           |    2 +
 include/linux/mmc/core.h                           |    1 +
 include/linux/mmc/dw_mmc.h                         |    6 -
 include/linux/mmc/host.h                           |   28 +-
 include/linux/mmc/mmc.h                            |    4 +
 include/linux/mmc/sdhci-pci-data.h                 |    2 +
 include/linux/pci_ids.h                            |    1 +
 67 files changed, 2727 insertions(+), 607 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt
 create mode 100644 drivers/mmc/host/mtk-sd.c
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
