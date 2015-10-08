From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v6, 4/4] mmc: sdhci-of-esdhc: add quirk SDHCI_QUIRK_BROKEN_TIMEOUT_VAL for ls1021a
Date: Thu, 8 Oct 2015 18:36:57 +0800
Message-ID: <1444300617-26678-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0145.outbound.protection.outlook.com ([65.55.169.145]:17122
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751589AbbJHKnT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Oct 2015 06:43:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, LeoLi@freescale.com, arnd@arndb.de
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v5:
	- Added this quirk patch
Changes for v6: None
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 910838f..7b9282b 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -602,6 +602,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
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

