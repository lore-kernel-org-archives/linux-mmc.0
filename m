From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 2/2] mmc: esdhc: add quirk to support 3.3v for T4240
Date: Tue, 2 Jun 2015 15:09:51 +0800
Message-ID: <1433228991-24324-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:52210
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751455AbbFBH3y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Jun 2015 03:29:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chrisball@gmail.com, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Add SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33 for T4240

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 22e9111..4f5fe42 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -369,6 +369,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
 
+	if (of_device_is_compatible(np, "fsl,t4240-esdhc"))
+		host->quirks2 |= SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS33;
+
 	/* call to generic mmc_of_parse to support additional capabilities */
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
-- 
2.1.0.27.g96db324

