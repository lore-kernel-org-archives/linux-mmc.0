From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass platform_data on custom init-call
Date: Tue, 28 Sep 2010 14:36:44 +0200
Message-ID: <1285677406-3359-5-git-send-email-w.sang@pengutronix.de>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0I1MhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:37:15 -0400
In-Reply-To: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

The custom init call may need more data to perform its job, so we pass
it a pointer to the platform_data, too. Now, for drivers extending
sdhci-pltfm (like sdhci-cns3xxx), a fixed platform_data is used
according to the platform device id. Because that one does not contain
board specific information, we simply name the board specific
information information priv_pdata and pass it to the init routine as
well. (Note: the old behaviour was that you could override the platform
id specific data with your own. However, one can still do this by using
the "sdhci" id instead of "sdhci-<something>".)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Changes since previous version:

Rebased and dropped imx-specific stuff as mentioned by zhangfei gao.

priv_pdata might not be needed as Giuseppe pointed out. Will update with
the next revision of this series, if needed.

 drivers/mmc/host/sdhci-pltfm.c  |   11 ++++++++---
 include/linux/mmc/sdhci-pltfm.h |    3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index ff0271c..4076222 100644
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
index 0239bd7..cafb96b 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -28,7 +28,8 @@ struct sdhci_host;
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
+	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata,
+			void *priv_pdata);
 	void (*exit)(struct sdhci_host *host);
 };
 
-- 
1.7.1

