From: Viresh KUMAR <viresh.kumar@st.com>
Subject: [PATCH V2 Incremental] sdhci-spear: ST SPEAr based SDHCI controller glue
Date: Mon, 24 May 2010 10:39:56 +0530
Message-ID: <1274677796-17233-1-git-send-email-viresh.kumar@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:34550 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908Ab0EXFKd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2010 01:10:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: shiraz.hashim@st.com, Viresh Kumar <viresh.kumar@st.com>

This patch is a incremental patch over V1 of sdhci-spear patch.
It contains following changes from V1:
- dev_get_platdata is used to get dev->platform_data

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/mmc/host/sdhci-spear.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 6d3f740..d70c54c 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -41,8 +41,7 @@ static irqreturn_t sdhci_gpio_irq(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
-	struct spear_sdhci *sdhci =
-		(struct spear_sdhci *)(pdev->dev.platform_data);
+	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
 	unsigned long gpio_irq_type;
 	int val;
 
@@ -112,7 +111,7 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	}
 
 	/* overwrite platform_data */
-	sdhci->data = (struct sdhci_plat_data *)(pdev->dev.platform_data);
+	sdhci->data = dev_get_platdata(&pdev->dev);
 	pdev->dev.platform_data = sdhci;
 
 	if (pdev->dev.parent)
@@ -241,8 +240,7 @@ static int __devexit sdhci_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct resource *iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct spear_sdhci *sdhci =
-		(struct spear_sdhci *)(pdev->dev.platform_data);
+	struct spear_sdhci *sdhci = dev_get_platdata(&pdev->dev);
 	int dead;
 	u32 scratch;
 
-- 
1.6.0.2

