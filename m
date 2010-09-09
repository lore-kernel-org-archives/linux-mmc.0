From: akpm@linux-foundation.org
Subject: [patch 14/41] ARM: SAMSUNG: MMC: fix build error when both DMA and PIO mode selected
Date: Thu, 09 Sep 2010 16:37:44 -0700
Message-ID: <201009092337.o89NbiKK014205@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53940 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208Ab0IIXin (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 19:38:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, jiri.pinkava@vscht.cz, ben-linux@fluff.org, cjb@laptop.org, linux-mmc@vger.kernel.org, matt@console-pimps.org, rmk@arm.linux.org.uk


From: Jiri Pinkava <jiri.pinkava@vscht.cz>
Date: Tue, 25 May 2010 09:48:58 +0200

[cjb: fix line-wrapped patch]
Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/s3cmci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/s3cmci.c~arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~arm-samsung-mmc-fix-build-error-when-both-dma-and-pio-mode-selected
+++ a/drivers/mmc/host/s3cmci.c
@@ -1600,7 +1600,7 @@ static int __devinit s3cmci_probe(struct
 	host->pio_active 	= XFER_NONE;
 
 #ifdef CONFIG_MMC_S3C_PIODMA
-	host->dodma		= host->pdata->dma;
+	host->dodma		= host->pdata->use_dma;
 #endif
 
 	host->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
_
