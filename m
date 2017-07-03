From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.13
Date: Mon, 3 Jul 2017 11:46:05 +0200
Message-ID: <CAPDyKFo2ZYmQ1tE07C2W63puONJ5xrp-CLvonkh=CRSwPubCWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35521 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbdGCJqH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Jul 2017 05:46:07 -0400
Received: by mail-qk0-f175.google.com with SMTP id 16so141715347qkg.2
        for <linux-mmc@vger.kernel.org>; Mon, 03 Jul 2017 02:46:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Linus,

Here's the PR for MMC for v4.13. Details about the highlights are as
usual found in the signed tag.

Stephen Rothwell reported about a conflict when merging the mmc tree
with the block tree, I think it should be trivial for you to manage,
however if not, please tell and I will help.
https://lkml.org/lkml/2017/6/13/5

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 41f1830f5a7af77cf5c86359aba3cbd706687e52=
:

  Linux 4.12-rc6 (2017-06-19 22:19:37 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13

for you to fetch changes up to e47c0b96678c5fd731c125dca677880e06d6394c:

  mmc: dw_mmc: remove the unnecessary slot variable (2017-06-29 17:14:32 +0=
200)

----------------------------------------------------------------
MMC core:
 - Add support to enable irq wake for slot gpio
 - Remove MMC_CAP2_HC_ERASE_SZ and make it the default behaviour
 - Improve R1 response error checks for stop commands
 - Cleanup and clarify some MMC specific code
 - Keep card runtime resumed while adding SDIO function devices
 - Use device_property_read instead of of_property_read in mmc_of_parse()
 - Move boot partition locking into a driver op to enable proper I/O schedu=
ling
 - Move multi/single-ioctl() to use block layer to enable proper I/O schedu=
ling
 - Delete bounce buffer Kconfig option
 - Improve the eMMC HW reset support provided via the eMMC pwrseq
 - Add host API to manage SDIO IRQs from a workqueue

MMC host:
 - dw_mmc: Drop support for multiple slots
 - dw_mmc: Use device_property_read instead of of_property_read
 - dw_mmc-rockchip: Optional improved tuning to greatly decrease tuning tim=
e
 - dw_mmc: Prevent rpm suspend for SDIO IRQs instead of always for SDIO car=
ds
 - dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
 - omap_hsmmc: Convert to mmc regulator APIs to consolidate code
 - omap_hsmmc: Deprecate "vmmc_aux" in DT and use "vqmmc" instead
 - tmio: make sure SDIO gets reinitialized after resume
 - sdhi: add CMD23 support to R-Car Gen2 & Gen3
 - tmio: add CMD23 support
 - sdhi/tmio: Refactor code and rename files to simplify Kconfig options
 - sdhci-pci: Enable card detect wake for Intel BYT-related SD controllers
 - sdhci-pci: Add support for Intel CNP
 - sdhci-esdhc-imx: Remove ENGcm07207 workaround - allow multi block transf=
ers
 - sdhci-esdhc-imx: Allow all supported prescaler values
 - sdhci-esdhc-imx: Fix DAT line software reset
 - sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
 - atmel-mci: Drop AVR32 support

----------------------------------------------------------------
Adrian Hunter (5):
      mmc: sdhci-pci: Add support for Intel CNP
      mmc: sdio: Tidy error path in mmc_attach_sdio()
      mmc: sdio: Keep card runtime resumed while adding function devices
      mmc: slot-gpio: Add support to enable irq wake on cd_irq
      mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD
controllers

Andy Shevchenko (1):
      mmc: atmel-mci: Remove AVR32 bits from the driver

Beno=C3=AEt Th=C3=A9baudeau (5):
      mmc: sdhci-esdhc-imx: Fix some English mistakes and typos
      mmc: sdhci-esdhc: Add SDHCI_QUIRK_32BIT_DMA_ADDR
      mmc: sdhci-esdhc-imx: Fix DAT line software reset
      mmc: sdhci-esdhc-imx: Allow all supported prescaler values
      mmc: sdhci-esdhc-imx: Remove the ENGcm07207 workaround

Colin Ian King (1):
      mmc: sdricoh_cs: remove redundant check if len is non-zero

David Woods (2):
      mmc: dw_mmc: Use device_property_read instead of of_property_read
      mmc: core: Use device_property_read instead of of_property_read

Fabio Estevam (1):
      mmc: sdhci-esdhc-imx: Check the return value from clk_prepare_enable(=
)

Gustavo A. R. Silva (1):
      mmc: bcm2835: fix potential null pointer dereferences

Hans de Goede (1):
      mmc: sdhci-acpi: Remove unneeded acpi_bus_get_status() call

Jaehoon Chung (6):
      mmc: dw_mmc: deprecated the "num-slots" property
      mmc: dw_mmc: remove the loop about finding slots
      mmc: dw_mmc: change the array of slots
      mmc: dw_mmc: remove the 'id' arguments about functions relevant to sl=
ot
      mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
      mmc: dw_mmc: remove the unnecessary slot variable

Johan Hovold (1):
      mmc: vub3000: add missing USB-descriptor endianness conversions

Kishon Vijay Abraham I (4):
      ARM: dts: omap3-overo: Remove "vqmmc-supply" property from MMC dt nod=
e
      mmc: host: omap_hsmmc: Do not initialize MMC regulators to NULL on er=
ror
      mmc: host: omap_hsmmc: use mmc_regulator_get_supply() to get regulato=
rs
      Documentation: dt-bindings: Document deprecation of "vmmc_aux"
and using "vqmmc"

Linus Walleij (10):
      mmc: core: Delete bounce buffer Kconfig option
      mmc: core: Allocate per-request data using the block layer core
      mmc: block: Tag is_rpmb as bool
      mmc: block: move single ioctl() commands to block requests
      mmc: block: move multi-ioctl() to use block layer
      mmc: queue: delete mmc_req_is_special()
      mmc: block: remove req back pointer
      mmc: block: Tag DRV_OPs with a driver operation type
      mmc: block: Move DRV OP issue function
      mmc: block: Move boot partition locking into a driver op

Markus Elfring (2):
      mmc: atmel-mci: Delete an error message for a failed memory allocatio=
n
      mmc: core: Delete error messages for failed memory allocations

Matthias Kraemer (1):
      mmc: sdhci-pci: Use macros in pci_ids definition

Phong LE (1):
      mmc: mediatek: Fixed size in dma_free_coherent

Shawn Lin (3):
      Documentation: rockchip-dw-mshc: add description for rk3328
      dt-bindings: rockchip-dw-mshc: add optional rockchip, desired-num-pha=
ses
      mmc: dw_mmc-rockchip: parse rockchip, desired-num-phases from DT

Shubhrajyoti Datta (1):
      mmc: sdhci-of-arasan: Trivial print fix

Simon Horman (11):
      mmc: tmio: drop filenames from comment at top of source
      mmc: renesas-sdhi, tmio: make dma more modular
      mmc: tmio: rename tmio_mmc_{pio =3D> core}.c
      mmc: renesas-sdhi: rename tmio_mmc_dma.c =3D> renesas_sdhi_sys_dmac.c
      mmc: renesas-sdhi: rename sh_mobile_sdhi.c =3D> renesas_sdhi_core.c
      mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file
      MAINTAINERS: Update files for TMIO/SDHI MMC driver
      mmc: tmio: use EXPORT_SYMBOL_GPL
      mmc: tmio, renesas-sdhi: update Renesas related copyrights
      mmc: tmio: improve checkpatch cleanness
      mmc: renesas-sdhi: improve checkpatch cleanness

Ulf Hansson (18):
      mmc: pwrseq: Add reset callback to the struct mmc_pwrseq_ops
      mmc: core: Don't do eMMC HW reset when resuming the eMMC card
      mmc: core: Prevent processing SDIO IRQs when none is claimed
      mmc: sdio: Add API to manage SDIO IRQs from a workqueue
      mmc: dw_mmc: Convert to use MMC_CAP2_SDIO_IRQ_NOTHREAD for SDIO IRQs
      mmc: dw_mmc: Prevent runtime PM suspend when SDIO IRQs are enabled
      Revert "mmc: dw_mmc: Don't allow Runtime PM for SDIO cards"
      mmc: block: Use __mmc_send_status() and drop get_card_status()
      mmc: core: Don't export some eMMC specific functions from core.c
      mmc: core: Move mmc bkops functions from core.c to mmc_ops.c
      mmc: core: Move mmc_interrupt_hpi() from core.c to mmc_ops.c
      mmc: core: Move mmc_flush_cache() from core.c to mmc_ops.c
      mmc: core: Make mmc_can_reset() static
      mmc: core: Remove redundant code in mmc_send_cid()
      mmc: core: Re-factor code for sending CID
      mmc: core: Drop mmc_all_send_cid() and use mmc_send_cxd_native() inst=
ead
      mmc: core: Clarify code for sending CSD
      mmc: core: Remove MMC_CAP2_HC_ERASE_SZ

Wolfram Sang (10):
      mmc: tmio: make tmio_mmc_request function more readable
      mmc: tmio: refactor handling mrq
      mmc: tmio: remove outdated comment
      mmc: tmio: move finish_request function further down
      mmc: tmio: add CMD23 support
      mmc: sdhi: add CMD23 support to R-Car Gen2 & Gen3
      mmc: use proper name for the R-Car SoC
      mmc: tmio: make sure SDIO gets reinitialized after resume
      mmc: core: check also R1 response for stop commands
      mmc: core: for data errors, take response of stop cmd into account

Wu Fengguang (1):
      mmc: block: fix semicolon.cocci warnings

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   5 +
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   2 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/omap3-overo-base.dtsi            |  11 -
 drivers/mmc/core/Kconfig                           |  18 -
 drivers/mmc/core/block.c                           | 269 +++++----
 drivers/mmc/core/core.c                            | 214 +------
 drivers/mmc/core/host.c                            |  74 +--
 drivers/mmc/core/mmc.c                             |  18 +-
 drivers/mmc/core/mmc_ops.c                         | 260 ++++++--
 drivers/mmc/core/mmc_ops.h                         |   5 +-
 drivers/mmc/core/mmc_test.c                        |   2 -
 drivers/mmc/core/pwrseq.c                          |   8 +
 drivers/mmc/core/pwrseq.h                          |   3 +
 drivers/mmc/core/pwrseq_emmc.c                     |   2 +-
 drivers/mmc/core/queue.c                           | 242 ++------
 drivers/mmc/core/queue.h                           |  47 +-
 drivers/mmc/core/sd.c                              |  22 +-
 drivers/mmc/core/sdio.c                            |  24 +-
 drivers/mmc/core/sdio_irq.c                        |  22 +-
 drivers/mmc/core/sdio_ops.h                        |   2 +
 drivers/mmc/core/slot-gpio.c                       |   2 +
 drivers/mmc/host/Kconfig                           |  12 +-
 drivers/mmc/host/Makefile                          |   4 +-
 drivers/mmc/host/atmel-mci.c                       |  28 +-
 drivers/mmc/host/bcm2835.c                         |  12 +-
 drivers/mmc/host/cavium.c                          |   4 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  48 +-
 drivers/mmc/host/dw_mmc.c                          | 225 +++----
 drivers/mmc/host/dw_mmc.h                          |   7 +-
 drivers/mmc/host/mtk-sd.c                          |   2 +-
 drivers/mmc/host/omap_hsmmc.c                      |  55 +-
 drivers/mmc/host/pxamci.c                          |   6 +-
 drivers/mmc/host/renesas_sdhi.h                    |  39 ++
 .../host/{sh_mobile_sdhi.c =3D> renesas_sdhi_core.c} | 273 +++------
 .../{tmio_mmc_dma.c =3D> renesas_sdhi_sys_dmac.c}    | 186 +++++-
 drivers/mmc/host/sdhci-acpi.c                      |   4 -
 drivers/mmc/host/sdhci-brcmstb.c                   |   3 -
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 192 +++---
 drivers/mmc/host/sdhci-esdhc.h                     |   1 +
 drivers/mmc/host/sdhci-of-arasan.c                 |   2 +-
 drivers/mmc/host/sdhci-pci-core.c                  | 668 ++++-------------=
----
 drivers/mmc/host/sdhci-pci.h                       |  46 +-
 drivers/mmc/host/sdricoh_cs.c                      |   3 -
 drivers/mmc/host/tmio_mmc.c                        |  20 +-
 drivers/mmc/host/tmio_mmc.h                        |  75 +--
 .../mmc/host/{tmio_mmc_pio.c =3D> tmio_mmc_core.c}   | 282 +++++----
 drivers/mmc/host/vub300.c                          |   3 +-
 include/linux/mfd/tmio.h                           |  35 +-
 include/linux/mmc/card.h                           |   2 -
 include/linux/mmc/host.h                           |   7 +-
 52 files changed, 1565 insertions(+), 1937 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 rename drivers/mmc/host/{sh_mobile_sdhi.c =3D> renesas_sdhi_core.c} (65%)
 rename drivers/mmc/host/{tmio_mmc_dma.c =3D> renesas_sdhi_sys_dmac.c} (55%=
)
 rename drivers/mmc/host/{tmio_mmc_pio.c =3D> tmio_mmc_core.c} (89%)
