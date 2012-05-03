From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 08/29] mmc: sh_mmcif: add regulator support
Date: Thu,  3 May 2012 17:05:37 +0200
Message-ID: <1336057558-11031-9-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53919 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757405Ab2ECPGD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:03 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Add regulator support to the sh_mmcif driver, but also preserve the current
power-callback.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sh_mmcif.c |   48 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 19c7576..f6d0b11 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -58,6 +58,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
 
@@ -231,6 +232,8 @@ struct sh_mmcif_host {
 	bool power;
 	bool card_present;
 
+	struct regulator	*vdd;
+
 	/* DMA support */
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
@@ -923,10 +926,24 @@ static void sh_mmcif_clk_update(struct sh_mmcif_host *host)
 	host->mmc->f_min = host->clk / 512;
 }
 
+static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
+{
+	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+
+	if (!(host->mmc->caps & MMC_CAP_POWER_OFF_CARD))
+		return;
+
+	if (host->vdd)
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(host->mmc, host->vdd,
+				      ios->power_mode ? ios->vdd : 0);
+	else if (pd->set_pwr)
+		pd->set_pwr(host->pd, ios->power_mode != MMC_POWER_OFF);
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
-	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -944,6 +961,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
 			host->card_present = true;
 		}
+		sh_mmcif_set_power(host, ios);
 	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* clock stop */
 		sh_mmcif_clock_control(host, 0);
@@ -957,8 +975,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			pm_runtime_put(&host->pd->dev);
 			clk_disable(host->hclk);
 			host->power = false;
-			if (p->set_pwr && ios->power_mode == MMC_POWER_OFF)
-				p->set_pwr(host->pd, 0);
+			if (ios->power_mode == MMC_POWER_OFF)
+				sh_mmcif_set_power(host, ios);
 		}
 		host->state = STATE_IDLE;
 		return;
@@ -966,8 +984,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		if (!host->power) {
-			if (p->set_pwr)
-				p->set_pwr(host->pd, ios->power_mode);
 			clk_enable(host->hclk);
 			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
@@ -1252,6 +1268,24 @@ static void mmcif_timeout_work(struct work_struct *work)
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
+{
+	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+	struct mmc_host *mmc = host->mmc;
+
+	host->vdd = mmc_regulator_get_vmmc(mmc);
+
+	if ((mmc->ocr_avail && pd->ocr) || (host->vdd && pd->set_pwr))
+		dev_warn(mmc_dev(mmc),
+			 "Platform OCR mask / .set_pwr() are ignored\n");
+
+	if (pd->set_pwr)
+		mmc->caps |= MMC_CAP_POWER_OFF_CARD;
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = pd->ocr;
+}
+
 static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq[2];
@@ -1298,8 +1332,8 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
-	if (pd->ocr)
-		mmc->ocr_avail = pd->ocr;
+	sh_mmcif_init_ocr(host);
+
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
 	if (pd->caps)
 		mmc->caps |= pd->caps;
-- 
1.7.2.5

