From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/8 v3] mmc: tmio: add regulator support
Date: Fri, 25 May 2012 17:15:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251308490.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251300300.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57926 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab2EYPPe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:15:34 -0400
In-Reply-To: <Pine.LNX.4.64.1205251300300.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Currently the TMIO MMC driver derives the OCR mask from the platform data
and uses a platform callback to turn card power on and off. This patch adds
regulator support to the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: similar to MMCIF don't prefer regulator over platform callback, call 
both. Thanks to all, who commented.

 drivers/mmc/host/tmio_mmc.h     |    3 +++
 drivers/mmc/host/tmio_mmc_pio.c |   35 +++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d857f5c..3a8dcfb 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -39,6 +39,7 @@
 #define TMIO_MASK_IRQ     (TMIO_MASK_READOP | TMIO_MASK_WRITEOP | TMIO_MASK_CMD)
 
 struct tmio_mmc_data;
+struct regulator;
 
 struct tmio_mmc_host {
 	void __iomem *ctl;
@@ -55,6 +56,8 @@ struct tmio_mmc_host {
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 
+	struct regulator	*vdd;
+
 	/* pio related stuff */
 	struct scatterlist      *sg_ptr;
 	struct scatterlist      *sg_orig;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 579f990..baa0959 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -767,6 +767,16 @@ static int tmio_mmc_clk_update(struct mmc_host *mmc)
 	return ret;
 }
 
+static void tmio_mmc_set_power(struct tmio_mmc_host *host, struct mmc_ios *ios)
+{
+	if (host->set_pwr)
+		host->set_pwr(host->pdev, ios->power_mode != MMC_POWER_OFF);
+	if (host->vdd)
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(host->mmc, host->vdd,
+				      ios->power_mode ? ios->vdd : 0);
+}
+
 /* Set MMC clock / power.
  * Note: This controller uses a simple divider scheme therefore it cannot
  * run a MMC card at full speed (20MHz). The max clock is 24MHz on SD, but as
@@ -819,13 +829,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -885,6 +894,19 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
+static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
+{
+	struct tmio_mmc_data *pdata = host->pdata;
+	struct mmc_host *mmc = host->mmc;
+
+	host->vdd = mmc_regulator_get_vmmc(mmc);
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = pdata->ocr_mask ? : MMC_VDD_32_33 | MMC_VDD_33_34;
+	else if (pdata->ocr_mask)
+		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
+}
+
 int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -930,10 +952,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
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

