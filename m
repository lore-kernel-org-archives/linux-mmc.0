From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v5, 3/4] mmc: kconfig: reconfigure MMC_SDHCI_OF_ESDHC option
Date: Mon, 28 Sep 2015 14:35:32 +0800
Message-ID: <1443422132-16841-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:24496
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751004AbbI1Glr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Sep 2015 02:41:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, LeoLi@freescale.com
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Freescale eSDHC driver now supports both little-endian and
big-endian mode eSDHC IPs for ARM and PPC. So, MMC_SDHCI_OF_ESDHC
option needs to be reconfigured.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8a1e349..12b274a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -67,7 +67,7 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 	  has the effect of scrambling the addresses and formats of data
 	  accessed in sizes other than the datum size.
 
-	  This is the case for the Freescale eSDHC and Nintendo Wii SDHCI.
+	  This is the case for the Nintendo Wii SDHCI.
 
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
@@ -140,8 +140,8 @@ config MMC_SDHCI_OF_AT91
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC
-	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Freescale eSDHC controller support.
 
-- 
2.1.0.27.g96db324

