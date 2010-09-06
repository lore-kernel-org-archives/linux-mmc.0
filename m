From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 1/3] sdhci-pltfm: Add structure for host-specific data
Date: Mon,  6 Sep 2010 12:34:23 +0200
Message-ID: <1283769265-14147-2-git-send-email-w.sang@pengutronix.de>
References: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51024 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab0IFKe4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 06:34:56 -0400
In-Reply-To: <1283769265-14147-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

We need to carry some information per host, e.g. the clock.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-pltfm.c |    7 +++++--
 drivers/mmc/host/sdhci-pltfm.h |    5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index 900f329..c393289 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -13,6 +13,11 @@
 
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

