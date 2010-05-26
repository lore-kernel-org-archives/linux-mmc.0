From: akpm@linux-foundation.org
Subject: [patch 016/203] sdhci: enable multiblock transfers in sdhci-s3c
Date: Wed, 26 May 2010 14:42:05 -0700
Message-ID: <201005262142.o4QLg5DE015367@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58957 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab0EZWBN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 18:01:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, mcuelenaere@gmail.com, ben-linux@fluff.org, linux-mmc@vger.kernel.org, thomas.ab@samsung.com

From: Maurus Cuelenaere <mcuelenaere@gmail.com>

Wifi over SDIO doesn't work correctly without multiblock, so enable this. 
This patch depends on the following patches:

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |    3 ---
 1 file changed, 3 deletions(-)

diff -puN drivers/mmc/host/sdhci-s3c.c~sdhci-enable-multiblock-transfers-in-sdhci-s3c drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~sdhci-enable-multiblock-transfers-in-sdhci-s3c
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -325,9 +325,6 @@ static int __devinit sdhci_s3c_probe(str
 	 * support as well. */
 	host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-	/* PIO currently has problems with multi-block IO */
-	host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
-
 #endif /* CONFIG_MMC_SDHCI_S3C_DMA */
 
 	/* It seems we do not get an DATA transfer complete on non-busy
_
