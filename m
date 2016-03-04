From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v5, 0/5] Fix eSDHC host version register bug
Date: Fri, 4 Mar 2016 17:38:36 +0800
Message-ID: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0090.outbound.protection.outlook.com ([157.56.110.90]:62880
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756990AbcCDKVG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2016 05:21:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, scott.wood@nxp.com, leoyang.li@nxp.com, xiaobo.xie@nxp.com, Rob Herring <robh+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>

This patchset is used to fix a host version register bug in the T4240-R1.0-R2.0
eSDHC controller. To get the SoC version and revision, it's needed to add the
GUTS driver to access the global utilities registers.

So, the first three patches are to add the GUTS driver.
The following two patches are to enable GUTS driver support to get SVR in eSDHC
driver and fix host version for T4240.

Yangbo Lu (5):
  ARM64: dts: ls2080a: add device configuration node
  soc: fsl: add GUTS driver for QorIQ platforms
  dt: move guts devicetree doc out of powerpc directory
  powerpc/fsl: move mpc85xx.h to include/linux/fsl
  mmc: sdhci-of-esdhc: fix host version for T4240-R1.0-R2.0

 .../bindings/{powerpc => soc}/fsl/guts.txt         |   3 +
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   6 ++
 drivers/clk/clk-qoriq.c                            |   3 +-
 drivers/i2c/busses/i2c-mpc.c                       |   2 +-
 drivers/iommu/fsl_pamu.c                           |   3 +-
 drivers/mmc/host/Kconfig                           |   1 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |  23 +++++
 drivers/net/ethernet/freescale/gianfar.c           |   2 +-
 drivers/soc/Kconfig                                |   2 +-
 drivers/soc/fsl/Kconfig                            |   8 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/guts.c                             | 103 +++++++++++++++++++++
 include/linux/fsl/guts.h                           | 100 ++++++++++----------
 .../asm/mpc85xx.h => include/linux/fsl/svr.h       |   4 +-
 14 files changed, 204 insertions(+), 57 deletions(-)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/guts.txt (91%)
 create mode 100644 drivers/soc/fsl/Kconfig
 create mode 100644 drivers/soc/fsl/guts.c
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/fsl/svr.h (97%)

-- 
2.1.0.27.g96db324

