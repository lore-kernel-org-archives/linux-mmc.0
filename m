From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 14:44:47 +0800
Message-ID: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:40382 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315Ab1FTGpE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 02:45:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>

	Without depends, MMC_SDHCI_PXAV3/2 can be chosen in other platfrom.
	Build error will occur since plat/sdhci.h is located at arch/arm/plat-pxa/

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 198ddda..d33a3e2 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -183,6 +183,7 @@ config MMC_SDHCI_S3C
 
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
+	depends on ARCH_MMP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default CPU_MMP2
@@ -195,6 +196,7 @@ config MMC_SDHCI_PXAV3
 
 config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
+	depends on ARCH_MMP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default CPU_PXA910
-- 
1.7.0.4

