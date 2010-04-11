From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 2/2] [RESEND] s3c6410: Enable ADMA feature in 6410 sdhci
	controller.
Date: Sun, 11 Apr 2010 17:22:45 +0200
Message-ID: <x2tb2e8f9f71004110822n11576a7drd43b424f05803097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61240 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0DKPXG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Apr 2010 11:23:06 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so24362bwz.21
        for <linux-mmc@vger.kernel.org>; Sun, 11 Apr 2010 08:23:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, sdhci-devel@lists.ossman.eu
Cc: Thomas Abraham <thomas.ab@samsung.com>, Ben Dooks <ben-linux@fluff.org>, kgene.kim@samsung.com

This patch enables ADMA feature in 6410 SDHCI controller
driver.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/mmc/host/sdhci-s3c.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2136794..ad3a78e 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -317,12 +317,7 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
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
1.7.0.4
