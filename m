From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
Date: Wed, 29 Sep 2010 22:08:02 +0200
Message-ID: <1285790884-3516-5-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34114 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab0I2UIX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 16:08:23 -0400
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>

The custom init call may need more data to perform its job, so we pass
it a pointer to pdata, too. Also, always use the platform_id specific
data even if platform_data is present. Doing that, platform_data can
additionally be parsed by init() for board-specific information (via
sdhci->mmc->parent).

(Note: the old behaviour was that you could override the platform_id
specific data with your own. However, one can still do this by using the
"sdhci" id instead of "sdhci-<something>".)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Changes since last version:

* Removed priv_data-variable.

 drivers/mmc/host/sdhci-pltfm.c  |    8 +++++---
 include/linux/mmc/sdhci-pltfm.h |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e95b454..5d963fe 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -52,15 +52,17 @@ static struct sdhci_ops sdhci_pltfm_ops = {
 
 static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	struct sdhci_pltfm_data *pdata;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
-	if (!pdata && platid && platid->driver_data)
+	if (platid && platid->driver_data)
 		pdata = (void *)platid->driver_data;
+	else
+		pdata = pdev->dev.platform_data;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
@@ -105,7 +107,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 	}
 
 	if (pdata && pdata->init) {
-		ret = pdata->init(host);
+		ret = pdata->init(host, pdata);
 		if (ret)
 			goto err_plat_init;
 	}
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
index 0239bd7..548d59d 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -28,7 +28,7 @@ struct sdhci_host;
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
+	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata);
 	void (*exit)(struct sdhci_host *host);
 };
 
-- 
1.7.1

