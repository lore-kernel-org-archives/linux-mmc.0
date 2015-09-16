From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2] mmc: sdhci-pltfm: enable interrupt mode to detect card for ls1021a
Date: Wed, 16 Sep 2015 14:36:10 +0800
Message-ID: <1442385370-26961-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0140.outbound.protection.outlook.com ([157.56.111.140]:6119
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751742AbbIPGmK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Sep 2015 02:42:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Enable interrupt mode to detect card instead of polling mode for
ls1021a by removing the quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION.
This could improve data transferring performance and avoid the call
trace caused by polling card status sometime.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- Modified commit message
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 653f335..2a54dbe 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -371,7 +371,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p1020-esdhc") ||
-	    of_device_is_compatible(np, "fsl,t1040-esdhc"))
+	    of_device_is_compatible(np, "fsl,t1040-esdhc") ||
+	    of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
-- 
2.1.0.27.g96db324

