From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 1/4] sdhci-1: sdhci driver modifications when support FSL eSDHC
Date: Fri, 24 Sep 2010 11:54:24 +0800
Message-ID: <1285300467-5158-2-git-send-email-r65037@freescale.com>
References: <1285300467-5158-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:35329
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755454Ab0IXDuv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 23:50:51 -0400
Received: from mail52-db3 (localhost.localdomain [127.0.0.1])	by
 mail52-db3-R.bigfish.com (Postfix) with ESMTP id 2D69998023A	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:50:50 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.241])	by
 mail52-db3.bigfish.com (Postfix) with ESMTP id A0FB11004E	for
 <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2010 03:50:48 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 o8O3okkI001488	for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 20:50:47
 -0700 (MST)
Received: from shlinux1.ap.freescale.net ([10.192.225.216])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o8O3oqjW015858	for
 <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 22:50:52 -0500 (CDT)
In-Reply-To: <1285300467-5158-1-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Richard Zhu <r65037@freescale.com>

Add host's own get_ro func to support the controller that used it's own WP mechanism
Some controllers maybe have their exceptional WP mechanism in the different HW design
when implement the get_ro, add one get_ro api to supported them.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   24 ++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pltfm.h |    7 +++++++
 drivers/mmc/host/sdhci.c       |    3 +++
 drivers/mmc/host/sdhci.h       |    1 +
 include/linux/sdhci-pltfm.h    |    2 ++
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e045e3c..202a6bf 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -54,12 +54,24 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	struct sdhci_pltfm_data *dpdata = (void *)platid->driver_data;
 	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
 	if (!pdata && platid && platid->driver_data)
 		pdata = (void *)platid->driver_data;
+	else {
+		if (!pdata->ops)
+			pdata->ops = dpdata->ops;
+		if (pdata->quirks == 0)
+			pdata->quirks = dpdata->quirks;
+		if (!pdata->init)
+			pdata->init = dpdata->init;
+		if (!pdata->exit)
+			pdata->exit= dpdata->exit;
+	}
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
@@ -72,15 +84,20 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 			"experience problems.\n");
 
 	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
+		host = sdhci_alloc_host(pdev->dev.parent,
+				sizeof(struct sdhci_pltfm_host));
 	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
+		host = sdhci_alloc_host(&pdev->dev,
+				sizeof(struct sdhci_pltfm_host));
 
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto err;
 	}
 
+	pltfm_host = sdhci_priv(host);
+	pltfm_host->wp_gpio = pdata->wp_gpio;
+
 	host->hw_name = "platform";
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
@@ -161,6 +178,9 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
 #ifdef CONFIG_MMC_SDHCI_CNS3XXX
 	{ "sdhci-cns3xxx", (kernel_ulong_t)&sdhci_cns3xxx_pdata },
 #endif
+#ifdef CONFIG_MMC_SDHCI_IMX
+	{ "imx-sdhci", (kernel_ulong_t)&sdhci_imx_pdata },
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 900f329..2df8cac 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -13,6 +13,13 @@
 
 #include <linux/sdhci-pltfm.h>
 
+struct sdhci_pltfm_host {
+	struct clk *clk;
+	u32 scratchpad; /* to handle quirks across io-accessor calls */
+	u32 wp_gpio; /* GPIO pin number that used as the Write Protect */
+};
+
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
+extern struct sdhci_pltfm_data sdhci_imx_pdata;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..10e5931 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1208,6 +1208,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	host = mmc_priv(mmc);
 
+	if (host->ops->get_ro)
+		return host->ops->get_ro(host);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 036cfae..e765cc6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -321,6 +321,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	unsigned int	(*get_ro)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/sdhci-pltfm.h b/include/linux/sdhci-pltfm.h
index 0239bd7..da83e76 100644
--- a/include/linux/sdhci-pltfm.h
+++ b/include/linux/sdhci-pltfm.h
@@ -30,6 +30,8 @@ struct sdhci_pltfm_data {
 	unsigned int quirks;
 	int (*init)(struct sdhci_host *host);
 	void (*exit)(struct sdhci_host *host);
+	unsigned int wp_gpio; /* GPIO pin num that used as the Write Protect */
+	unsigned int caps; /* Board specified max bus width */
 };
 
 #endif /* _SDHCI_PLTFM_H */
-- 
1.7.0


