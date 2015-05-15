From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH v2, 2/2] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Fri, 15 May 2015 10:46:24 +0800
Message-ID: <1431657984-42484-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0108.outbound.protection.outlook.com ([65.55.169.108]:14955
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423235AbbEOCuR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 May 2015 22:50:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chrisball@gmail.com
Cc: scottwood@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Enable interrupt mode to detect card instead of polling mode
for P1020/P4080/P5020/P5040/T1040 by removing the quirk
SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
transferring performance and avoid the call trace caused by
polling card status sometime.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
----
Changes for v2:
	- Aligned all "of_device_is_compatibles" in same column
---
 drivers/mmc/host/sdhci-pltfm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index c5b01d6..97128f3 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -102,6 +102,13 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+		if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
+		    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
+		    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
+		    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
+		    of_device_is_compatible(np, "fsl,t1040-esdhc"))
+			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 		clk = of_get_property(np, "clock-frequency", &size);
 		if (clk && size == sizeof(*clk) && *clk)
 			pltfm_host->clock = be32_to_cpup(clk);
-- 
2.1.0.27.g96db324

