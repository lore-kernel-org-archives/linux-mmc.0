From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/5] mmc: sh_mmcif: add regulator support
Date: Fri, 20 Apr 2012 18:59:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204201840020.3974@axis700.grange>
References: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add regulator support to the sh_mmcif driver, but also preserve the current
power-callback.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   48 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 19c7576..a5dadd2 100644
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
@@ -923,10 +926,21 @@ static void sh_mmcif_clk_update(struct sh_mmcif_host *host)
 	host->mmc->f_min = host->clk / 512;
 }
 
+static void sh_mmcif_set_power(struct sh_mmcif_host *host, bool on)
+{
+	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+
+	if (host->vdd)
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(host->mmc, host->vdd,
+				      on ? host->mmc->ios.vdd : 0);
+	else if (p->set_pwr)
+		p->set_pwr(host->pd, on);
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
-	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -944,6 +958,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
 			host->card_present = true;
 		}
+		sh_mmcif_set_power(host, true);
 	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* clock stop */
 		sh_mmcif_clock_control(host, 0);
@@ -957,8 +972,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			pm_runtime_put(&host->pd->dev);
 			clk_disable(host->hclk);
 			host->power = false;
-			if (p->set_pwr && ios->power_mode == MMC_POWER_OFF)
-				p->set_pwr(host->pd, 0);
+			if (ios->power_mode == MMC_POWER_OFF)
+				sh_mmcif_set_power(host, false);
 		}
 		host->state = STATE_IDLE;
 		return;
@@ -966,8 +981,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		if (!host->power) {
-			if (p->set_pwr)
-				p->set_pwr(host->pd, ios->power_mode);
 			clk_enable(host->hclk);
 			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
@@ -1252,6 +1265,25 @@ static void mmcif_timeout_work(struct work_struct *work)
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
+{
+	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+	struct mmc_host *mmc = host->mmc;
+
+	host->vdd = regulator_get(mmc_dev(mmc), "MMC Vdd");
+	if (IS_ERR(host->vdd)) {
+		host->vdd = NULL;
+	} else {
+		mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vdd);
+		if (p->ocr || p->set_pwr)
+			dev_warn(mmc_dev(mmc),
+				"Platform OCR mask / .s_power() are ignored\n");
+	}
+
+	if (!host->vdd)
+		mmc->ocr_avail = p->ocr;
+}
+
 static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq[2];
@@ -1298,8 +1330,8 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
-	if (pd->ocr)
-		mmc->ocr_avail = pd->ocr;
+	sh_mmcif_init_ocr(host);
+
 	mmc->caps = MMC_CAP_MMC_HIGHSPEED;
 	if (pd->caps)
 		mmc->caps |= pd->caps;
@@ -1365,6 +1397,7 @@ eresume:
 	clk_disable(host->hclk);
 	clk_put(host->hclk);
 eclkget:
+	regulator_put(host->vdd);
 	pm_runtime_disable(&pdev->dev);
 	mmc_free_host(mmc);
 ealloch:
@@ -1407,6 +1440,7 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
 	clk_disable(host->hclk);
+	regulator_put(host->vdd);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
1.7.2.5

