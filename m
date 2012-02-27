From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 3/4] mmc: sdhci-s3c: use the sdhci-s3c.h instead of
 regs-sdhci.h
Date: Mon, 27 Feb 2012 16:58:10 +0900
Message-ID: <4F4B3792.7050409@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47338 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2B0H6R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2012 02:58:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>

Using the sdhci-s3c.h

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0778c38..7417100 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -26,9 +26,9 @@
 #include <linux/mmc/host.h>
 
 #include <plat/sdhci.h>
-#include <plat/regs-sdhci.h>
 
 #include "sdhci-pltfm.h"
+#include "sdhci-s3c.h"
 #include "sdhci.h"
 
 #define MAX_BUS_CLK	(4)
@@ -221,14 +221,12 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
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
 
