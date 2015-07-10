From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: sdhci-pltfm: add broken ADMA quirk for T4240 board
Date: Fri, 10 Jul 2015 11:41:11 +0800
Message-ID: <1436499671-16153-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0134.outbound.protection.outlook.com ([157.56.111.134]:2101
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750805AbbGJDp4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 23:45:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

eMMC build-in on T4240 board can't work when using ADMA to transfer
data, but SDHC card could work well. No erratum provided, use SDMA
instead to get it to work first.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a207f5a..0b4d059 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -95,6 +95,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
+	if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
 	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
-- 
2.1.0.27.g96db324

