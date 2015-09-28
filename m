From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v5, 4/4] mmc: sdhci-of-esdhc: add quirk SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a
Date: Mon, 28 Sep 2015 14:35:46 +0800
Message-ID: <1443422146-16976-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0136.outbound.protection.outlook.com ([157.56.110.136]:28512
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753576AbbI1Glz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Sep 2015 02:41:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, LeoLi@freescale.com
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5315864..5ddcfc8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -583,6 +583,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
+	if (of_device_is_compatible(np, "fsl,ls1021a-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
 		/*
 		 * Freescale messed up with P2020 as it has a non-standard
-- 
2.1.0.27.g96db324

