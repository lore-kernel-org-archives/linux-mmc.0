From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH v3] mmc: sdhci-pltfm: enable interrupt mode to detect card
Date: Mon, 1 Jun 2015 13:47:12 +0800
Message-ID: <1433137632-48130-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0129.outbound.protection.outlook.com ([207.46.100.129]:30784
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751158AbbFAFvR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Jun 2015 01:51:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chrisball@gmail.com, ulf.hansson@linaro.org
Cc: scottwood@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Enable interrupt mode to detect card instead of polling mode
for P1020/P4080/P5020/P5040/T1040 by removing the quirk
SDHCI_QUIRK_BROKEN_CARD_DETECTION. This could improve data
transferring performance and avoid the call trace caused by
polling card status sometime.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
----
Changes for v3:
	- Moved code from sdhci-pltfm to sdhci-of-esdhc
Changes for v2:
	- Aligned all "of_device_is_compatibles" in same column
---
 drivers/mmc/host/sdhci-of-esdhc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 22e9111..af9dad8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -361,6 +361,13 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	sdhci_get_of_property(pdev);
 
 	np = pdev->dev.of_node;
+	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
+	    of_device_is_compatible(np, "fsl,t1040-esdhc"))
+		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
 		/*
 		 * Freescale messed up with P2020 as it has a non-standard
-- 
2.1.0.27.g96db324

