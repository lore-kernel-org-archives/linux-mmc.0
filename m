From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: tmio_mmc, sdhi: update input clock frequency after
 resume
Date: Tue, 10 Jan 2012 16:06:04 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201101604130.530@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56862 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2AJPGR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2012 10:06:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

After a runtime or system-wide suspend the clock frequency can change,
therefore it must be re-read.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   10 ++++++++++
 drivers/mmc/host/tmio_mmc_pio.c   |   31 +++++++++++++++++++++----------
 include/linux/mfd/tmio.h          |    1 +
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 95a2405..c0db970 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -47,6 +47,15 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 		p->set_pwr(pdev, state);
 }
 
+static unsigned int sh_mobile_sdhi_get_clk_rate(struct platform_device *pdev)
+{
+	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+
+	return clk_get_rate(priv->clk);
+}
+
 static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
@@ -120,6 +129,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	mmc_data->get_clk_rate = sh_mobile_sdhi_get_clk_rate;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 7c4378f..0e72f1a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -900,7 +900,10 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	mmc->ops = &tmio_mmc_ops;
 	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
-	mmc->f_max = pdata->hclk;
+	if (pdata->get_clk_rate)
+		mmc->f_max = pdata->get_clk_rate(pdev);
+	else
+		mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -1019,6 +1022,21 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 }
 EXPORT_SYMBOL(tmio_mmc_host_remove);
 
+static void tmio_mmc_resume(struct device *dev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_data *pdata = host->pdata;
+
+	if (pdata->get_clk_rate) {
+		mmc->f_max = pdata->get_clk_rate(host->pdev);
+		mmc->f_min = mmc->f_max / 512;
+	}
+
+	tmio_mmc_reset(host);
+	tmio_mmc_enable_dma(host, true);
+}
+
 #ifdef CONFIG_PM
 int tmio_mmc_host_suspend(struct device *dev)
 {
@@ -1036,10 +1054,8 @@ EXPORT_SYMBOL(tmio_mmc_host_suspend);
 int tmio_mmc_host_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	tmio_mmc_reset(host);
-	tmio_mmc_enable_dma(host, true);
+	tmio_mmc_resume(dev);
 
 	/* The MMC core will perform the complete set up */
 	return mmc_resume_host(mmc);
@@ -1056,12 +1072,7 @@ EXPORT_SYMBOL(tmio_mmc_host_runtime_suspend);
 
 int tmio_mmc_host_runtime_resume(struct device *dev)
 {
-	struct mmc_host *mmc = dev_get_drvdata(dev);
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-
-	tmio_mmc_reset(host);
-	tmio_mmc_enable_dma(host, true);
-
+	tmio_mmc_resume(dev);
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 367c65c6..018eb45 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -103,6 +103,7 @@ struct tmio_mmc_data {
 	unsigned long			cd_flags;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
+	unsigned int (*get_clk_rate)(struct platform_device *host);
 	int (*get_cd)(struct platform_device *host);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 };
-- 
1.7.2.5

