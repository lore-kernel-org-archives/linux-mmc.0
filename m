From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
Date: Tue, 28 Sep 2010 14:36:41 +0200
Message-ID: <1285677406-3359-2-git-send-email-w.sang@pengutronix.de>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54508 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab0I1MhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:37:15 -0400
In-Reply-To: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

We need to carry some information per host, e.g. the clock. Add a
structure for it and initialize it in the generic part.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Change since last version:

* include clk.h

 drivers/mmc/host/sdhci-pltfm.c |    7 +++++--
 drivers/mmc/host/sdhci-pltfm.h |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e045e3c..bf522a1 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
@@ -72,15 +73,17 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 			"experience problems.\n");
 
 	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
+		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
 	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
+		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
 
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto err;
 	}
 
+	pltfm_host = sdhci_priv(host);
+
 	host->hw_name = "platform";
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 900f329..1f96864 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -11,8 +11,14 @@
 #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
 #define _DRIVERS_MMC_SDHCI_PLTFM_H
 
+#include <linux/clk.h>
 #include <linux/sdhci-pltfm.h>
 
+struct sdhci_pltfm_host {
+	struct clk *clk;
+	u32 scratchpad; /* to handle quirks across io-accessor calls */
+};
+
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
1.7.1

