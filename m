From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/7] mmc: tmio: add regulator support
Date: Tue, 24 Apr 2012 18:41:45 +0200
Message-ID: <1335285707-22707-6-git-send-email-g.liakhovetski@gmx.de>
References: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51538 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab2DXQly (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 12:41:54 -0400
In-Reply-To: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>

Currently the TMIO MMC driver derives the OCR mask from the platform data
and uses a platform callback to turn card power on and off. This patch adds
regulator support to the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
---
 drivers/mmc/host/tmio_mmc.h     |    2 +
 drivers/mmc/host/tmio_mmc_pio.c |   44 +++++++++++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d857f5c..12c0108 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -55,6 +55,8 @@ struct tmio_mmc_host {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 
+	struct regulator	*vdd;
+
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
 	struct scatterlist      *sg_orig;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 579f990..61d4274 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -42,6 +42,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -767,6 +768,16 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
 	return ret;
 }
 
+static void tmio_mmc_set_power(struct tmio_mmc_host *host, bool on)
+{
+	if (host->vdd)
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(host->mmc, host->vdd,
+				      on ? host->mmc->ios.vdd : 0);
+	else if (host->set_pwr)
+		host->set_pwr(host->pdev, on);
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -819,13 +830,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		tmio_mmc_set_clock(host, ios->clock);
 		/* power up SD bus */
-		if (host->set_pwr)
-			host->set_pwr(host->pdev, 1);
+		tmio_mmc_set_power(host, true);
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
 	} else if (ios->power_mode != MMC_POWER_UP) {
-		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
-			host->set_pwr(host->pdev, 0);
+		if (ios->power_mode == MMC_POWER_OFF)
+			tmio_mmc_set_power(host, false);
 		tmio_mmc_clk_stop(host);
 		if (host->power) {
 			struct tmio_mmc_data *pdata = host->pdata;
@@ -885,6 +895,25 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
+static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
+{
+	struct tmio_mmc_data *pdata = host->pdata;
+	struct mmc_host *mmc = host->mmc;
+
+	host->vdd = regulator_get(mmc_dev(mmc), "SD Vdd");
+	if (IS_ERR(host->vdd)) {
+		host->vdd = NULL;
+	} else {
+		mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vdd);
+		if (pdata->ocr_mask || host->set_pwr)
+			dev_warn(mmc_dev(mmc),
+				"Platform OCR mask / .set_pwr() are ignored\n");
+	}
+
+	if (!host->vdd)
+		mmc->ocr_avail = pdata->ocr_mask ? : MMC_VDD_32_33 | MMC_VDD_33_34;
+}
+
 int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -930,10 +959,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 		mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
-	if (pdata->ocr_mask)
-		mmc->ocr_avail = pdata->ocr_mask;
-	else
-		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+	tmio_mmc_init_ocr(_host);
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
@@ -1019,6 +1045,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	regulator_put(_host->vdd);
 	iounmap(_host->ctl);
 host_free:
 	mmc_free_host(mmc);
@@ -1052,6 +1079,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	regulator_put(host->vdd);
 
 	iounmap(host->ctl);
 	mmc_free_host(mmc);
-- 
1.7.2.5

