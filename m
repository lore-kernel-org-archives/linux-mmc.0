From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH] S3C: sdhci: Enable ADMA feature in S3C sdhci controller.
Date: Thu, 29 Oct 2009 16:44:42 +0900
Message-ID: <1256802282-28479-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:52159 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZJ2Hq7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Oct 2009 03:46:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: sdhci-devel@lists.ossman.eu, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, Thomas Abraham <thomas.ab@samsung.com>

This patch enables ADMA feature in S3C SDHCI controller driver. This patch
depends on the following patch.

[PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor build.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7400ba0..03f7e3b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -341,12 +341,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
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

