From: akpm@linux-foundation.org
Subject: [patch 015/203] mmc: s3c6410: enable ADMA feature in 6410 sdhci controller
Date: Wed, 26 May 2010 14:42:05 -0700
Message-ID: <201005262142.o4QLg57d015363@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49560 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab0EZWB3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 18:01:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, thomas.ab@samsung.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org, mcuelenaere@gmail.com

From: Thomas Abraham <thomas.ab@samsung.com>

Enable the ADMA feature in the 6410 SDHCI controller driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff -puN drivers/mmc/host/sdhci-s3c.c~s3c6410-enable-adma-feature-in-6410-sdhci-controller drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~s3c6410-enable-adma-feature-in-6410-sdhci-controller
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -317,12 +317,7 @@ static int __devinit sdhci_s3c_probe(str
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
 
_
