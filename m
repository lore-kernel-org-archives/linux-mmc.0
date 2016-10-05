From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC for v.4.9
Date: Wed, 5 Oct 2016 12:36:13 +0200
Message-ID: <CAPDyKFpM0ixCFvpqzSdOJPmuTSXuggOmrNP8x6GYDctp7VnwUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36046 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbcJEKgR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2016 06:36:17 -0400
Received: by mail-wm0-f41.google.com with SMTP id k125so259037664wma.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 Oct 2016 03:36:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi Linus,

Here's the PR for MMC v4.9. Details about the highlights are as usual
found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 08895a8b6b06ed2323cd97a36ee40a116b3db8ed=
:

  Linux 4.8-rc8 (2016-09-25 18:47:13 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.9

for you to fetch changes up to 0f75c404503cc49cbe92555fbab80a584c1f4ae2:

  mmc: dw_mmc: remove the deprecated "supports-highspeed" property
(2016-09-26 21:31:37 +0200)

----------------------------------------------------------------
MMC core:
 - Add support for sending commands during data transfer
 - Erase/discard/trim improvements
 - Improved error handling
 - Extend sysfs with SD status register
 - Document info about the vmmc/vmmcq regulators
 - Extend pwrseq-simple to manage an optional post-power-on-delay
 - Some various minor improvements and cleanups

MMC host:
 - dw_mmc: Add reset support
 - dw_mmc: Return -EILSEQ for EBE and SBE error
 - dw_mmc: Some cleanups
 - dw_mmc-k3: Add UHS-I support Hisilicon Hikey
 - tmio: Add eMMC support
 - sh_mobile_sdhi: Add r8a7796 support
 - sunxi: Don't use sample clocks for sun4i/sun5i
 - sunxi: Add support for A64 mmc controller
 - sunxi: Some cleanups and improvements
 - sdhci: Support for sending commands during data transfer
 - sdhci: Do not allow tuning procedure to be interrupted
 - sdhci-pci: Enable SD/SDIO on Merrifield
 - sdhci-pci|acpi: Enable MMC_CAP_CMD_DURING_TFR
 - sdhci-pci: Some cleanups
 - sdhci-of-arasan: Set controller to test mode when no CD bit
 - sdhci-of-arasan: Some fixes for clocks and phys
 - sdhci-brcmstb: Don't use ADMA 64-bit when not supported
 - sdhci-tegra: Mark 64-bit DMA broken on Tegra124
 - sdhci-esdhc-imx: Fixups related to data timeouts

----------------------------------------------------------------
Adrian Hunter (5):
      mmc: core: Add support for sending commands during data transfer
      mmc: mmc_test: Add tests for sending commands during transfer
      mmc: sdhci: Support cap_cmd_during_tfr requests
      mmc: sdhci-pci: Set MMC_CAP_CMD_DURING_TFR for Intel eMMC controllers
      mmc: sdhci-acpi: Set MMC_CAP_CMD_DURING_TFR for Intel eMMC controller=
s

Ai Kyuse (1):
      mmc: sh_mobile_sdhi: Add r8a7796 support

Andy Shevchenko (4):
      mmc: sdhci-pci: Convert to use managed functions (part2)
      sdhci-pci: refactor intel_mrfld_mmc_probe_slot()
      sdhci-pci: enable SDIO interface on Intel Merrifield
      sdhci-pci: enable SD card interface on Merrifield

Arnd Bergmann (1):
      mmc: davinci: remove incorrect NO_IRQ use

Baolin Wang (2):
      mmc: core: Factor out the alignment of erase size
      mmc: core: Optimize the mmc erase size alignment

Ben Dooks (1):
      mmc: core: Add the vmmc/vmmcq regulator info

Christopher Freeman (1):
      mmc: sdhci: Do not allow tuning procedure to be interrupted

Daniel Gl=C3=B6ckner (1):
      mmc: block: don't use CMD23 with very old MMC cards

Douglas Anderson (1):
      mmc: sdhci-of-arasan: Don't power PHY w/ slow/no clock

Guodong Xu (2):
      Documentation: synopsys-dw-mshc: add binding for resets
      mmc: dw_mmc: add reset support to dwmmc host controller

Haibo Chen (2):
      mmc: sdhci-esdhc-imx: do not touch other bit when config DTOCV
      mmc: sdhci-esdhc-imx: correct the max timeout count

Hans de Goede (7):
      mmc: sunxi: Disable sample clks on remove
      mmc: sunxi: Introduce a sunxi_mmc_cfg struct
      mmc: sunxi: Factor out clock phase setting code into a helper functio=
n
      mmc: sunxi: sun4i / sun5i do not have sample clocks
      ARM: dts: sunxi: Use new sun7i-a20-mmc compatible on sun7i and newer
      dt: bindings: Make compatible optional for mmc function nodes
      mmc: pwrseq-simple: Add an optional post-power-on-delay

Icenowy Zheng (2):
      Documentation: dt: Add new compatible to sunxi mmc driver bindings
      mmc: sunxi: add support for A64 mmc controller

Jaedon Shin (2):
      mmc: DT: sdhci-brcmstb: Bindings document for common sdhci-brcmstb
      mmc: sdhci-brcmstb: Fix incorrect capability

Jaehoon Chung (2):
      mmc: dw_mmc: remove the unnecessary IS_ERR() checking for ciu/biu clo=
ck
      mmc: dw_mmc: remove the deprecated "supports-highspeed" property

Jean-Francois Moine (1):
      mmc: sunxi: Check the value returned by clk_round_rate

Jin Guojun (1):
      mmc: dw_mmc: k3: UHS-SD card for Hisilicon Hikey

Julia Lawall (1):
      mmc: sdhci-of-esdhc: use of_property_read_bool

Jungseung Lee (1):
      mmc: core: Add error message when switching fails in mmc_select_hs()

Krzysztof Kozlowski (1):
      mmc: dw_mmc: exynos: Warn if HS400 is being used on non-Exynos5420 ch=
ipset

Linus Walleij (1):
      mmc: card: do away with indirection pointer

Markus Elfring (1):
      mmc: sdhci-brcmstb: Delete owner assignment

Michael Weiser (1):
      mmc: sunxi-mmc: change idma descriptor to __le32

Nicholas Mc Guire (1):
      mmc: moxart: fix wait_for_completion_interruptible_timeout
return variable type

Shawn Lin (10):
      mmc: block: remove the check of packed for packed request routine
      mmc: sdio: deploy error handling instead of triggering BUG_ON
      mmc: dw_mmc: remove parsing for each slot subnode
      mmc: dw_mmc: return -EILSEQ for EBE and SBE error
      mmc: sdhci-of-arasan: Properly set corecfg_clockmultiplier on rk3399
      mmc: dw_mmc: split out preparation of desc for IDMAC32 and IDMAC64
      mmc: dw_mmc: avoid race condition of cpu and IDMAC
      mmc: dw_mmc: fix misleading error print if failing to do DMA transfer
      mmc: dw_mmc: use macro to define ring buffer size
      mmc: dw_mmc: minor cleanup for dw_mci_adjust_fifoth

Thierry Reding (1):
      mmc: tegra: Mark 64-bit DMA broken on Tegra124

Ulf Hansson (2):
      mmc: sdhci: Remove ->platform_init() callback as it's no longer used
      mmc: core: Use a default maximum erase timeout

Uri Yanai (1):
      mmc: sd: Export SD Status via =E2=80=9Cssr=E2=80=9D device attribute

Wei Yongjun (1):
      mmc: sdhci-bcm-kona: fix error return code in sdhci_bcm_kona_probe()

Wolfram Sang (7):
      mmc: vub300: don't print error when allocating urb fails
      mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi
      mmc: host: sh_mobile_sdhi: don't populate unneeded functions
      mmc: add define for R1 response without CRC
      mmc: rtsx_pci: use new macro for R1 without CRC
      mmc: rtsx_usb: use new macro for R1 without CRC
      mmc: tmio: add eMMC support

Zach Brown (2):
      dt: sdhci-of-arasan: Add device tree option xlnx, fails-without-test-=
cd
      mmc: sdhci-of-arasan: Set controller to test mode when no CD bit

Ziyuan Xu (1):
      mmc: core: don't try to switch block size for dual rate mode

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   3 +
 ...cm,bcm7425-sdhci.txt =3D> brcm,sdhci-brcmstb.txt} |   4 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |   2 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |  15 +-
 .../devicetree/bindings/mmc/sunxi-mmc.txt          |   7 +-
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   4 +
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   8 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   8 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   6 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   6 +-
 drivers/mmc/card/block.c                           |  30 +-
 drivers/mmc/card/block.h                           |   1 +
 drivers/mmc/card/mmc_test.c                        | 308 +++++++++++++++
 drivers/mmc/card/queue.c                           |   4 +-
 drivers/mmc/card/queue.h                           |   2 -
 drivers/mmc/core/core.c                            | 181 +++++++--
 drivers/mmc/core/mmc.c                             |   9 +-
 drivers/mmc/core/pwrseq_simple.c                   |   9 +
 drivers/mmc/core/sd.c                              |  37 +-
 drivers/mmc/core/sdio_io.c                         |  47 ++-
 drivers/mmc/core/sdio_ops.c                        |   9 +-
 drivers/mmc/host/davinci_mmc.c                     |   6 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   6 +-
 drivers/mmc/host/dw_mmc-k3.c                       |   6 +
 drivers/mmc/host/dw_mmc.c                          | 427 +++++++++++------=
----
 drivers/mmc/host/moxart-mmc.c                      |   5 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   2 +-
 drivers/mmc/host/sdhci-acpi.c                      |   2 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |   6 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |   4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   7 +-
 drivers/mmc/host/sdhci-of-arasan.c                 | 136 ++++++-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   2 +-
 drivers/mmc/host/sdhci-pci-core.c                  |  62 ++-
 drivers/mmc/host/sdhci-pci.h                       |   1 -
 drivers/mmc/host/sdhci-pltfm.c                     |   7 -
 drivers/mmc/host/sdhci-tegra.c                     |  27 +-
 drivers/mmc/host/sdhci.c                           |  23 +-
 drivers/mmc/host/sdhci.h                           |   3 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  |  17 +-
 drivers/mmc/host/sunxi-mmc.c                       | 265 +++++++++----
 drivers/mmc/host/tmio_mmc.h                        |   4 +
 drivers/mmc/host/tmio_mmc_pio.c                    |  47 ++-
 drivers/mmc/host/vub300.c                          |   2 -
 include/linux/mmc/card.h                           |   1 +
 include/linux/mmc/core.h                           |  10 +
 include/linux/mmc/dw_mmc.h                         |   2 +
 include/linux/mmc/host.h                           |   5 +
 50 files changed, 1305 insertions(+), 483 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{brcm,bcm7425-sdhci.txt
=3D> brcm,sdhci-brcmstb.txt} (89%)
 create mode 100644 drivers/mmc/card/block.h
