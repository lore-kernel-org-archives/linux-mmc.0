From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 13/29] mmc: tmio: add regulator support
Date: Thu,  3 May 2012 17:05:42 +0200
Message-ID: <1336057558-11031-14-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Currently the TMIO MMC driver derives the OCR mask from the platform data
and uses a platform callback to turn card power on and off. This patch adds
regulator support to the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
index 579f990..175cc71 100644
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
@@ -767,6 +768,19 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
 	return ret;
 }
 
+static void tmio_mmc_set_power(struct tmio_mmc_host *host, struct mmc_ios *ios)
+{
+	if (!(host->mmc->caps & MMC_CAP_POWER_OFF_CARD))
+		return;
+
+	if (host->vdd)
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(host->mmc, host->vdd,
+				      ios->power_mode ? ios->vdd : 0);
+	else if (host->set_pwr)
+		host->set_pwr(host->pdev, ios->power_mode != MMC_POWER_OFF);
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -819,13 +833,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		tmio_mmc_set_clock(host, ios->clock);
 		/* power up SD bus */
-		if (host->set_pwr)
-			host->set_pwr(host->pdev, 1);
+		tmio_mmc_set_power(host, ios);
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
 	} else if (ios->power_mode != MMC_POWER_UP) {
-		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
-			host->set_pwr(host->pdev, 0);
+		if (ios->power_mode == MMC_POWER_OFF)
+			tmio_mmc_set_power(host, ios);
 		tmio_mmc_clk_stop(host);
 		if (host->power) {
 			struct tmio_mmc_data *pdata = host->pdata;
@@ -885,6 +898,24 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
+static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
+{
+	struct tmio_mmc_data *pdata = host->pdata;
+	struct mmc_host *mmc = host->mmc;
+
+	host->vdd = mmc_regulator_get_vmmc(mmc);
+
+	if ((mmc->ocr_avail && pdata->ocr_mask) || (host->vdd && host->set_pwr))
+		dev_warn(mmc_dev(mmc),
+			 "Platform OCR mask / .set_pwr() are ignored\n");
+
+	if (host->set_pwr)
+		mmc->caps |= MMC_CAP_POWER_OFF_CARD;
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = pdata->ocr_mask ? : MMC_VDD_32_33 | MMC_VDD_33_34;
+}
+
 int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -930,10 +961,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
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
-- 
1.7.2.5

