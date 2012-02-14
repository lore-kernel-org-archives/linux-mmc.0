From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/4] mmc: sdhci-s3c: use the sdhci-s3c.h instead of regs-sdhci.h
Date: Tue, 14 Feb 2012 14:03:08 +0900
Message-ID: <4F39EB0C.1080003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9411 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab2BNFDK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 00:03:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>

Use the sdhci-s3c.h

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a651c1e..ac4b0e8 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -24,9 +24,9 @@
 #include <linux/mmc/host.h>
 
 #include <plat/sdhci.h>
-#include <plat/regs-sdhci.h>
 
 #include "sdhci-pltfm.h"
+#include "sdhci-s3c.h"
 #include "sdhci.h"
 
 #define MAX_BUS_CLK	(4)
@@ -200,14 +200,12 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	/* reprogram default hardware configuration */
-	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
-		host->ioaddr + S3C64XX_SDHCI_CONTROL4);
+	writel(S3C_SDHCI_CONTROL4_DRIVE_9mA,
+		host->ioaddr + S3C_SDHCI_CONTROL4);
 
 	ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
-	ctrl |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
-		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
-		  S3C_SDHCI_CTRL2_ENFBCLKRX |
-		  S3C_SDHCI_CTRL2_DFCNT_NONE |
+	ctrl |= (S3C_SDHCI_CTRL2_ENSTAASYNCCLR | S3C_SDHCI_CTRL2_ENCMDCNFMSK |
+		  S3C_SDHCI_CTRL2_ENFBCLKRX | S3C_SDHCI_CTRL2_DFCNT_NONE |
 		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
 	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
 
