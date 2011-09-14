From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 1/2] mmc: sdhci-s3c: add default controller configuration
Date: Wed, 14 Sep 2011 12:39:17 +0530
Message-ID: <1315984158-29651-2-git-send-email-thomas.abraham@linaro.org>
References: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14285 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1INHJz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2011 03:09:55 -0400
In-reply-to: <1315984158-29651-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

The default controller configuration which was previously setup by
platform helper functions is moved into the driver.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2bd7bf4..d891682 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -203,17 +203,23 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 		writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
 	}
 
-	/* reconfigure the hardware for new clock rate */
-
-	{
-		struct mmc_ios ios;
-
-		ios.clock = clock;
-
-		if (ourhost->pdata->cfg_card)
-			(ourhost->pdata->cfg_card)(ourhost->pdev, host->ioaddr,
-						   &ios, NULL);
-	}
+	/* reprogram default hardware configuration */
+	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
+		host->ioaddr + S3C64XX_SDHCI_CONTROL4);
+
+	ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
+	ctrl |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
+		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
+		  S3C_SDHCI_CTRL2_ENFBCLKRX |
+		  S3C_SDHCI_CTRL2_DFCNT_NONE |
+		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
+	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
+
+	/* reconfigure the controller for new clock rate */
+	ctrl = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
+	if (clock < 25 * 1000000)
+		ctrl |= (S3C_SDHCI_CTRL3_FCSEL3 | S3C_SDHCI_CTRL3_FCSEL2);
+	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL3);
 }
 
 /**
-- 
1.6.6.rc2

