From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 5/5 v3] mmc: sh_mmcif: add regulator support
Date: Fri, 25 May 2012 17:14:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251233350.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61251 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab2EYPPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:15:10 -0400
In-Reply-To: <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Add regulator support to the sh_mmcif driver, but also preserve the current
power-callback.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: don't (yet) give preference to using the regulator over the .set_pwr() 
platform callback, call them both if both are available. Thanks to Mark 
and Magnus.

 drivers/mmc/host/sh_mmcif.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 3834b21..f952978 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -207,6 +207,8 @@ enum mmcif_wait_for {
 	MMCIF_WAIT_FOR_STOP,
 };
 
+struct regulator;
+
 struct sh_mmcif_host {
 	struct mmc_host *mmc;
 	struct mmc_request *mrq;
@@ -231,6 +233,8 @@ struct sh_mmcif_host {
 	bool power;
 	bool card_present;
 
+	struct regulator	*vdd;
+
 	/* DMA support */
 	struct dma_chan		*chan_rx;
 	struct dma_chan		*chan_tx;
@@ -929,10 +933,21 @@ static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 	return ret;
 }
 
+static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
+{
+	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+
+	if (pd->set_pwr)
+		pd->set_pwr(host->pd, ios->power_mode != MMC_POWER_OFF);
+	if (host->vdd)
+		/* Errors ignored... */
+		mmc_regulator_set_ocr(host->mmc, host->vdd,
+				      ios->power_mode ? ios->vdd : 0);
+}
+
 static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
-	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -950,6 +965,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
 			host->card_present = true;
 		}
+		sh_mmcif_set_power(host, ios);
 	} else if (ios->power_mode == MMC_POWER_OFF || !ios->clock) {
 		/* clock stop */
 		sh_mmcif_clock_control(host, 0);
@@ -963,8 +979,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -972,8 +988,6 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (ios->clock) {
 		if (!host->power) {
-			if (p->set_pwr)
-				p->set_pwr(host->pd, ios->power_mode);
 			sh_mmcif_clk_update(host);
 			pm_runtime_get_sync(&host->pd->dev);
 			host->power = true;
@@ -1257,6 +1271,19 @@ static void mmcif_timeout_work(struct work_struct *work)
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
+{
+	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+	struct mmc_host *mmc = host->mmc;
+
+	host->vdd = mmc_regulator_get_vmmc(mmc);
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
@@ -1304,8 +1331,8 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
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

