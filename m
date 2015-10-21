From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Wed, 21 Oct 2015 11:47:12 +0900
Message-ID: <5626FCB0.5040708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57324 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbJUCrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 22:47:14 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWJ006DJUEODVD0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Oct 2015 11:47:12 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Govindraj Raja <govindraj.raja@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Vineet Gupta <vgupta@synopsys.com>, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>

Dear, Ulf.

Could you pull these patch for mmc-next?
If have any other problem, let me know, plz.

Best Regards,
Jaehoon Chung

The following changes since commit 10e2cf053bbbaa76fcd919c0f59ae5bf8463a19c:

  mmc: sdhci-of-esdhc: avoid writing power control register (2015-10-16 15:04:58 +0200)

are available in the git repository at:

  https://git.linaro.org/people/ulf.hansson/mmc.git 

for you to fetch changes up to 13ae9dff2fe12409197fbd3620d2308888badbac:

  arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC (2015-10-20 23:59:31 +0900)

----------------------------------------------------------------
Shawn Lin (10):
      mmc: dw_mmc: Add external dma interface support
      mmc: dw_mmc: use macro for HCON register operations
      Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
      mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
      arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
      arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC

 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  25 +++++++++++++
 arch/arc/configs/axs101_defconfig                          |   1 -
 arch/arc/configs/axs103_defconfig                          |   1 -
 arch/arc/configs/axs103_smp_defconfig                      |   1 -
 arch/arm/configs/exynos_defconfig                          |   1 -
 arch/arm/configs/hisi_defconfig                            |   1 -
 arch/arm/configs/lpc18xx_defconfig                         |   1 -
 arch/arm/configs/multi_v7_defconfig                        |   1 -
 arch/arm/configs/zx_defconfig                              |   1 -
 arch/mips/configs/pistachio_defconfig                      |   1 -
 drivers/mmc/host/Kconfig                                   |  11 +-----
 drivers/mmc/host/dw_mmc-pltfm.c                            |   2 +
 drivers/mmc/host/dw_mmc.c                                  | 272 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/mmc/host/dw_mmc.h                                  |   9 +++++
 include/linux/mmc/dw_mmc.h                                 |  23 +++++++++++-
 15 files changed, 276 insertions(+), 75 deletions(-)
