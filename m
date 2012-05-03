From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 11/29] mmc: tmio: add callbacks to enable-update and disable the interface clock
Date: Thu,  3 May 2012 17:05:40 +0200
Message-ID: <1336057558-11031-12-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Every time the clockc is enabled after possibly being disabled, we have
to re-read its frequency and update our configuration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   35 ++++++++++++++++++++++++++++++++---
 include/linux/mfd/tmio.h        |    3 +++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 8cd3637..579f990 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -751,6 +751,22 @@ fail:
 	mmc_request_done(mmc, mrq);
 }
 
+static int tmio_mmc_clk_update(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct tmio_mmc_data *pdata = host->pdata;
+	int ret;
+
+	if (!pdata->clk_enable)
+		return -ENOTSUPP;
+
+	ret = pdata->clk_enable(host->pdev, &mmc->f_max);
+	if (!ret)
+		mmc->f_min = mmc->f_max / 512;
+
+	return ret;
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -797,6 +813,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
 		if (!host->power) {
+			tmio_mmc_clk_update(mmc);
 			pm_runtime_get_sync(dev);
 			host->power = true;
 		}
@@ -811,8 +828,11 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			host->set_pwr(host->pdev, 0);
 		tmio_mmc_clk_stop(host);
 		if (host->power) {
+			struct tmio_mmc_data *pdata = host->pdata;
 			host->power = false;
 			pm_runtime_put(dev);
+			if (pdata->clk_disable)
+				pdata->clk_disable(host->pdev);
 		}
 	}
 
@@ -904,8 +924,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	mmc->ops = &tmio_mmc_ops;
 	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
-	mmc->f_max = pdata->hclk;
-	mmc->f_min = mmc->f_max / 512;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
 	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
@@ -927,6 +945,11 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (ret < 0)
 		goto pm_disable;
 
+	if (tmio_mmc_clk_update(mmc) < 0) {
+		mmc->f_max = pdata->hclk;
+		mmc->f_min = mmc->f_max / 512;
+	}
+
 	/*
 	 * There are 4 different scenarios for the card detection:
 	 *  1) an external gpio irq handles the cd (best for power savings)
@@ -972,7 +995,13 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	/* See if we also get DMA */
 	tmio_mmc_request_dma(_host, pdata);
 
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (pdata->clk_disable)
+		pdata->clk_disable(pdev);
+	if (ret < 0) {
+		tmio_mmc_host_remove(_host);
+		return ret;
+	}
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index f5171db..b332c4c 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -110,6 +110,9 @@ struct tmio_mmc_data {
 	void (*set_clk_div)(struct platform_device *host, int state);
 	int (*get_cd)(struct platform_device *host);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	/* clock management callbacks */
+	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
+	void (*clk_disable)(struct platform_device *pdev);
 };
 
 /*
-- 
1.7.2.5

