From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC] sdhci_pltfm: pass platform_data on custom init-call
Date: Tue, 21 Sep 2010 14:56:07 +0200
Message-ID: <1285073767-19900-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44738 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab0IUM4R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 08:56:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Richard Zhu <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

The custom init call may need more data to perform its job, so we pass it a
pointer to the platform_data, too. Now, for drivers extending sdhci-pltfm (like
sdhci-cns3xxx), a fixed platform_data is used according to the platform device
id. Because that one does not contain board specific information, we simply
name the board specific information information priv_pdata and pass it to the
init routine as well. (Note: the old behaviour was that you could override the
platform id specific data with your own. However, one can still do this by
using the "sdhci" id instead of "sdhci-<something>".)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

This approach has its issues, but all I tried had some. So, let's start arguing
over code ;)

 drivers/mmc/host/sdhci-esdhc.c  |    3 ++-
 drivers/mmc/host/sdhci-pltfm.c  |   11 ++++++++---
 include/linux/mmc/sdhci-pltfm.h |    2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.c b/drivers/mmc/host/sdhci-esdhc.c
index 132e9c9..ccdafd9 100644
--- a/drivers/mmc/host/sdhci-esdhc.c
+++ b/drivers/mmc/host/sdhci-esdhc.c
@@ -97,7 +97,8 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
-static int esdhc_pltfm_init(struct sdhci_host *host)
+static int esdhc_pltfm_init(struct sdhci_host *host,
+		struct sdhci_pltfm_data *pdata, void *priv_pdata)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct clk *clk;
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 6ba3f3d..04f3117 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -52,15 +52,20 @@ static struct sdhci_ops sdhci_pltfm_ops = {
 
 static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	struct sdhci_pltfm_data *pdata;
+	void *priv_pdata = NULL;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
-	if (!pdata && platid && platid->driver_data)
+	if (platid && platid->driver_data) {
 		pdata = (void *)platid->driver_data;
+		priv_pdata = pdev->dev.platform_data;
+	} else {
+		pdata = pdev->dev.platform_data;
+	}
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
@@ -108,7 +113,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 	}
 
 	if (pdata && pdata->init) {
-		ret = pdata->init(host);
+		ret = pdata->init(host, pdata, priv_pdata);
 		if (ret)
 			goto err_plat_init;
 	}
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
index 0239bd7..e14fce3 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -28,7 +28,7 @@ struct sdhci_host;
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
+	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata, void* priv_pdata);
 	void (*exit)(struct sdhci_host *host);
 };
 
-- 
1.7.1

