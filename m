From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 3/5] mmc: kconfig: select MFD_SYSCON for MMC_SDHCI_OF_ESDHC
Date: Fri, 27 Nov 2015 11:20:15 +0800
Message-ID: <1448594417-22515-4-git-send-email-yangbo.lu@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0128.outbound.protection.outlook.com ([65.55.169.128]:7879
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753718AbbK0D17 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 Nov 2015 22:27:59 -0500
In-Reply-To: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: scottwood@freescale.com, X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

The sdhci-of-esdhc driver needs the syscon support to do
regmap and access the global utilities registers. So we
select MFD_SYSCON for MMC_SDHCI_OF_ESDHC here.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- None
Changes for v3:
	- Added this patch
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1526b8a..4fb88ba 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -142,6 +142,7 @@ config MMC_SDHCI_OF_ESDHC
 	depends on MMC_SDHCI_PLTFM
 	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
 	select MMC_SDHCI_IO_ACCESSORS
+	select MFD_SYSCON
 	help
 	  This selects the Freescale eSDHC controller support.
 
-- 
2.1.0.27.g96db324

