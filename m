From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/5 v4] mmc: sh_mmcif: add regulator support
Date: Wed, 13 Jun 2012 15:37:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1206131535090.17854@axis700.grange>
References: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Add regulator support to the sh_mmcif driver, but also preserve the current
power-callback.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4: update to the new mmc_regulator_get_supply() function

 drivers/mmc/host/sh_mmcif.c |   38 +++++++++++++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 4680276..204bced 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -923,10 +923,22 @@ static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 	return ret;
 }
 
+static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
+{
+	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+	struct mmc_host *mmc = host->mmc;
+
+	if (pd->set_pwr)
+		pd->set_pwr(host->pd, ios->power_mode != MMC_POWER_OFF);
+	if (!IS_ERR(mmc->supply.vmmc))
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+				      ios->power_mode ? ios->vdd : 0);
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
-	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -944,6 +956,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
 			host->card_present = true;
 		}
+		sh_mmcif_set_power(host, ios);
 	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* clock stop */
 		sh_mmcif_clock_control(host, 0);
@@ -957,8 +970,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -966,8 +979,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		if (!host->power) {
-			if (p->set_pwr)
-				p->set_pwr(host->pd, ios->power_mode);
 			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
@@ -1251,6 +1262,19 @@ static void mmcif_timeout_work(struct work_struct *work)
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
+{
+	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+	struct mmc_host *mmc = host->mmc;
+
+	mmc_regulator_get_supply(mmc);
+
+	if (!mmc->ocr_avail)
+		mmc->ocr_avail = pd->ocr;
+	else if (pd->ocr)
+		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
+}
+
 static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 {
 	int ret = 0, irq[2];
@@ -1298,8 +1322,8 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
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

