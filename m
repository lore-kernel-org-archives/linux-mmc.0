From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.2 rc4
Date: Fri, 24 Jul 2015 10:52:19 +0200
Message-ID: <CAPDyKFqrp7LcWGOHc-9yL4T7ozbP5payHnaX7tcxHRBZLtp-bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33496 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbbGXIwU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2015 04:52:20 -0400
Received: by qkdl129 with SMTP id l129so10468665qkd.0
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2015 01:52:19 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>

Hi Linus,

Here are some mmc fixes intended for v4.2 rc4 and it's based on v4.2-rc3.
Details are as usual found in the signed tag. Please pull this in!

Note, most of the changes are for the sdhci-esdhc-imx controller,
which also required us to modify some related DTS files. Those changes
have been acked by the SoC maintainer.

Kind regards
Ulf Hansson

The following changes since commit 52721d9d3334c1cb1f76219a161084094ec634dc:

  Linux 4.2-rc3 (2015-07-19 14:45:02 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-4.2-rc3

for you to fetch changes up to 9cd76049f0d90ae241f5ad80e311489824527000:

  mmc: sdhci-pxav3: fix platform_data is not initialized (2015-07-24
10:18:39 +0200)

----------------------------------------------------------------
MMC core:
 - Fix a reference inbalance issue for power_ro_lock_show() sysfs handler

MMC host:
 - omap_hsmmc: Fix IRQ errorhandling for CD, DTO, and CRC
 - sdhci: Prevent a kernel panic while using DMA
 - mtk-sd: Let it depend on HAS_DMA to prevent build errors
 - sdhci-esdhc: Make 8BIT bus work
 - sdhci-esdhc-imx: Fix some regressions for DT based platforms
 - sdhci-pxav3: Fix a regression for DT based platforms

----------------------------------------------------------------
Dong Aisheng (11):
      dts: imx51: fix sd card gpio polarity specified in device tree
      dts: imx53: fix sd card gpio polarity specified in device tree
      dts: imx6: fix sd card gpio polarity specified in device tree
      dts: imx25: fix sd card gpio polarity specified in device tree
      dts: imx7: fix sd card gpio polarity specified in device tree
      mmc: sdhci-esdhc-imx: fix cd regression for dt platform
      mmc: sdhci-esdhc-imx: move all non dt probe code into one function
      mmc: sdhci: make max-frequency property in device tree work
      mmc: sdhci-esdhc-imx: remove duplicated dts parsing
      mmc: sdhci-esdhc-imx: clear f_max in boarddata
      dts: mmc: fsl-imx-esdhc: remove fsl,cd-controller support

Geert Uytterhoeven (1):
      mmc: MMC_MTK should depend on HAS_DMA

Jingju Hou (1):
      mmc: sdhci-pxav3: fix platform_data is not initialized

Joakim Tjernlund (1):
      mmc: sdhci-esdhc: Make 8BIT bus work

Kishon Vijay Abraham I (1):
      mmc: omap_hsmmc: Fix DTO and DCRC handling

Peng Fan (1):
      mmc: sdhci check parameters before call dma_free_coherent

Tomas Winkler (1):
      mmc: block: Add missing mmc_blk_put() in power_ro_lock_show()

Vignesh R (1):
      mmc: omap_hsmmc: Handle BADA, DEB and CEB interrupts

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 -
 arch/arm/boot/dts/imx25-pdk.dts                    |   5 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |   2 +-
 arch/arm/boot/dts/imx53-ard.dts                    |   4 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |   4 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   4 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   4 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   4 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   4 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |   4 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   8 +-
 arch/arm/boot/dts/imx6q-arm2.dts                   |   5 +-
 arch/arm/boot/dts/imx6q-gk802.dts                  |   3 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   4 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   4 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   4 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |   4 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   4 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   8 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   4 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   4 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   6 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   8 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   4 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   6 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |  10 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   4 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   4 +-
 drivers/mmc/card/block.c                           |   2 +
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/omap_hsmmc.c                      |  11 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 210 ++++++++++-----------
 drivers/mmc/host/sdhci-esdhc.h                     |   2 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   1 +
 drivers/mmc/host/sdhci.c                           |  16 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 -
 42 files changed, 202 insertions(+), 187 deletions(-)
