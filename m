From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 6/6] mmc: sdhci-of-esdhc: add tuning cycles delay quirk for t2080/t1040
Date: Mon, 14 Sep 2015 19:44:14 +0800
Message-ID: <1442231054-10801-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0114.outbound.protection.outlook.com ([207.46.100.114]:55375
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753517AbbINLuI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 07:50:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 57e1e8b..46efa05 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -470,6 +470,10 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,t1040-esdhc"))
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
+	if (of_device_is_compatible(np, "fsl,t1040-esdhc") ||
+	    of_device_is_compatible(np, "fsl,t2080-esdhc"))
+		host->quirks2 |= SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES;
+
 	if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
 		/*
 		 * Freescale messed up with P2020 as it has a non-standard
-- 
2.1.0.27.g96db324

