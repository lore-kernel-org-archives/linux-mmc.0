From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 6/8] mmc: sdhci-of-esdhc: add tuning cycles delay quirk for t2080/t1040
Date: Thu, 17 Sep 2015 13:50:52 +0800
Message-ID: <1442469054-23644-6-git-send-email-yangbo.lu@freescale.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0144.outbound.protection.outlook.com ([157.56.111.144]:46976
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752989AbbIQF5j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 01:57:39 -0400
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index bffc8c4..5aabadf 100644
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

