From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 0/5] eSDHC patches introduction
Date: Fri, 27 Nov 2015 11:20:12 +0800
Message-ID: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0122.outbound.protection.outlook.com ([65.55.169.122]:3660
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753748AbbK0DmF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 22:42:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: scottwood@freescale.com, X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

This patchset is used to fix host version in eSDHC_HOSTVER for T4240-R1.0-R2.0.
To get the SoC version and revision, it's needed to add syscon support to access
the SVR(system version register) of global utilities registers through regmap.

So, the first three patches are to add syscon support to access SVR.
The following two patches are to fix host version for T4240.

Yangbo Lu (5):
  powerpc/fsl: move mpc85xx.h to include/linux
  mmc: sdhci-of-esdhc: get SVR from global utilities registers
  mmc: kconfig: select MFD_SYSCON for MMC_SDHCI_OF_ESDHC
  powerpc: dts: t4240: add syscon support for DCFG node
  mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |  4 +-
 arch/powerpc/include/asm/mpc85xx.h          | 95 ----------------------------
 drivers/clk/clk-qoriq.c                     |  2 +-
 drivers/i2c/busses/i2c-mpc.c                |  2 +-
 drivers/iommu/fsl_pamu.c                    |  2 +-
 drivers/mmc/host/Kconfig                    |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c           | 28 ++++++++-
 drivers/net/ethernet/freescale/gianfar.c    |  2 +-
 include/linux/fsl-svr.h                     | 97 +++++++++++++++++++++++++++++
 9 files changed, 131 insertions(+), 102 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/mpc85xx.h
 create mode 100644 include/linux/fsl-svr.h

-- 
2.1.0.27.g96db324

