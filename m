From: thomas.ab@samsung.com
Subject: [PATCH 4/8] s3c6410: sdhci: Enable ADMA feature in 6410 sdhci controller.
Date: Tue,  8 Sep 2009 15:52:49 +0900
Message-ID: <1252392769-31159-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:46837 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbZIHHCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 03:02:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch enables ADMA feature in 6410 SDHCI controller
driver.
---
 drivers/mmc/host/sdhci-s3c.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index db1bb93..7f5b64e 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -329,12 +329,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	host->irq = irq;
 
 	/* Setup quirks for the controller */
-
-	/* Currently with ADMA enabled we are getting some length
-	 * interrupts that are not being dealt with, do disable
-	 * ADMA until this is sorted out. */
-	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
-	host->quirks |= SDHCI_QUIRK_32BIT_ADMA_SIZE;
+	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
 
 #ifndef CONFIG_MMC_SDHCI_S3C_DMA
 
-- 
1.5.3.4

