From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/8] mmc: tmio: Restructure .set_ios and adapt probe sequence to it
Date: Fri,  8 Nov 2013 07:06:15 +0100
Message-ID: <1383890776-6912-8-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:61642 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KHGGg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:36 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so1122897lbv.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:35 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

An internal power state machine has earlier been used to keep probe and
.set_ios in sync. Moreover it was used to handle the specific scenario
of using MMC_CLKGATE. A dependency to MMC_CLKGATE existed to handle
runtime PM properly, which we moves away from here.

By removing the state machine and instead make .set_ios rely on the
information provided through the function's in-parameters, the code
becomes significantly simplier. Additonally as a part of this rework we
prepares for making the runtime callbacks responsible of clock gating.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h     |   20 -------------
 drivers/mmc/host/tmio_mmc_pio.c |   61 +++++++++------------------------------
 2 files changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c2c9546..58d3c05 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -40,22 +40,6 @@
 
 struct tmio_mmc_data;
 
-/*
- * We differentiate between the following 3 power states:
- * 1. card slot powered off, controller stopped. This is used, when either there
- *    is no card in the slot, or the card really has to be powered down.
- * 2. card slot powered on, controller stopped. This is used, when a card is in
- *    the slot, but no activity is currently taking place. This is a power-
- *    saving mode with card-state preserved. This state can be entered, e.g.
- *    when MMC clock-gating is used.
- * 3. card slot powered on, controller running. This is the actual active state.
- */
-enum tmio_mmc_power {
-	TMIO_MMC_OFF_STOP,	/* card power off, controller stopped */
-	TMIO_MMC_ON_STOP,	/* card power on, controller stopped */
-	TMIO_MMC_ON_RUN,	/* card power on, controller running */
-};
-
 struct tmio_mmc_host {
 	void __iomem *ctl;
 	unsigned long bus_shift;
@@ -64,9 +48,6 @@ struct tmio_mmc_host {
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
 
-	/* Controller and card power state */
-	enum tmio_mmc_power	power;
-
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
@@ -101,7 +82,6 @@ struct tmio_mmc_host {
 	unsigned long		last_req_ts;
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
-	bool			resuming;
 	bool			sdio_irq_enabled;
 };
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index fefe86c..cbb96a8 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -890,51 +890,23 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	/*
-	 * host->power toggles between false and true in both cases - either
-	 * or not the controller can be runtime-suspended during inactivity.
-	 * But if the controller has to be kept on, the runtime-pm usage_count
-	 * is kept positive, so no suspending actually takes place.
-	 */
-	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
-		if (host->power != TMIO_MMC_ON_RUN) {
-			tmio_mmc_clk_update(mmc);
-			if (host->resuming) {
-				tmio_mmc_reset(host);
-				host->resuming = false;
-			}
-		}
-		if (host->power == TMIO_MMC_OFF_STOP)
-			tmio_mmc_reset(host);
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		tmio_mmc_power_off(host);
+		tmio_mmc_clk_stop(host);
+		break;
+	case MMC_POWER_UP:
 		tmio_mmc_set_clock(host, ios->clock);
-		if (host->power == TMIO_MMC_OFF_STOP)
-			/* power up SD card and the bus */
-			tmio_mmc_power_on(host, ios->vdd);
-		host->power = TMIO_MMC_ON_RUN;
-		/* start bus clock */
+		tmio_mmc_power_on(host, ios->vdd);
 		tmio_mmc_clk_start(host);
-	} else if (ios->power_mode != MMC_POWER_UP) {
-		struct tmio_mmc_data *pdata = host->pdata;
-		unsigned int old_power = host->power;
-
-		if (old_power != TMIO_MMC_OFF_STOP) {
-			if (ios->power_mode == MMC_POWER_OFF) {
-				tmio_mmc_power_off(host);
-				host->power = TMIO_MMC_OFF_STOP;
-			} else {
-				host->power = TMIO_MMC_ON_STOP;
-			}
-		}
-
-		if (old_power == TMIO_MMC_ON_RUN) {
-			tmio_mmc_clk_stop(host);
-			if (pdata->clk_disable)
-				pdata->clk_disable(host->pdev);
-		}
-	}
-
-	if (host->power != TMIO_MMC_OFF_STOP)
 		tmio_mmc_set_bus_width(host, ios->bus_width);
+		break;
+	case MMC_POWER_ON:
+		tmio_mmc_set_clock(host, ios->clock);
+		tmio_mmc_clk_start(host);
+		tmio_mmc_set_bus_width(host, ios->bus_width);
+		break;
+	}
 
 	/* Let things settle. delay taken from winCE driver */
 	udelay(140);
@@ -1062,7 +1034,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  mmc->caps & MMC_CAP_NONREMOVABLE ||
 				  mmc->slot.cd_irq >= 0);
 
-	_host->power = TMIO_MMC_OFF_STOP;
 	if (tmio_mmc_clk_update(mmc) < 0) {
 		mmc->f_max = pdata->hclk;
 		mmc->f_min = mmc->f_max / 512;
@@ -1114,8 +1085,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	pm_runtime_enable(&pdev->dev);
 
 	ret = mmc_add_host(mmc);
-	if (pdata->clk_disable)
-		pdata->clk_disable(pdev);
 	if (ret < 0) {
 		tmio_mmc_host_remove(_host);
 		return ret;
@@ -1183,8 +1152,6 @@ int tmio_mmc_host_resume(struct device *dev)
 
 	tmio_mmc_enable_dma(host, true);
 
-	/* The MMC core will perform the complete set up */
-	host->resuming = true;
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_resume);
-- 
1.7.9.5

