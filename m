From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 1/2] mmc: tmio: fix unbalanced power-on calls with
 clock-gating enabled
Date: Thu, 6 Jun 2013 16:35:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1306061625290.32566@axis700.grange>
References: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
 <871u8f8nxb.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62307 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab3FFOfy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jun 2013 10:35:54 -0400
In-Reply-To: <871u8f8nxb.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

With MMC clock gating enabled the MMC core currently calls MMC host driver's
.set_ios() method with .power_mode == MMC_POWER_ON and the clock value set
either to 0 or to the target rate. The tmio MMC driver then wrongly
translates the latter calls to card slot power-on requests, even when the
slot already was on. This patch fixes the driver to avoid needlessly
incrementing power-supplying regulator's use count.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

v3: rebased on top of current mmc-next / 3.10-rc

 drivers/mmc/host/tmio_mmc.h     |   20 ++++++++++++++++++--
 drivers/mmc/host/tmio_mmc_pio.c |   27 +++++++++++++++++----------
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 759d8f4..86fd21e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -40,6 +40,22 @@
 
 struct tmio_mmc_data;
 
+/*
+ * We differentiate between the following 3 power states:
+ * 1. card slot powered off, controller stopped. This is used, when either there
+ *    is no card in the slot, or the card really has to be powered down.
+ * 2. card slot powered on, controller stopped. This is used, when a card is in
+ *    the slot, but no activity is currently taking place. This is a power-
+ *    saving mode with card-state preserved. This state can be entered, e.g.
+ *    when MMC clock-gating is used.
+ * 3. card slot powered on, controller running. This is the actual active state.
+ */
+enum tmio_mmc_power {
+	TMIO_MMC_OFF_STOP,	/* card power off, controller stopped */
+	TMIO_MMC_ON_STOP,	/* card power on, controller stopped */
+	TMIO_MMC_ON_RUN,	/* card power on, controller running */
+};
+
 struct tmio_mmc_host {
 	void __iomem *ctl;
 	unsigned long bus_shift;
@@ -48,8 +64,8 @@ struct tmio_mmc_host {
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
 
-	/* Controller power state */
-	bool			power;
+	/* Controller and card power state */
+	enum tmio_mmc_power	power;
 
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 435cc4d..67d9642 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -859,7 +859,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * is kept positive, so no suspending actually takes place.
 	 */
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
-		if (!host->power) {
+		if (host->power != TMIO_MMC_ON_RUN) {
 			tmio_mmc_clk_update(mmc);
 			pm_runtime_get_sync(dev);
 			if (host->resuming) {
@@ -868,27 +868,34 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 		}
 		tmio_mmc_set_clock(host, ios->clock);
-		if (!host->power) {
+		if (host->power == TMIO_MMC_OFF_STOP)
 			/* power up SD card and the bus */
 			tmio_mmc_power_on(host, ios->vdd);
-			host->power = true;
-		}
+		host->power = TMIO_MMC_ON_RUN;
 		/* start bus clock */
 		tmio_mmc_clk_start(host);
 	} else if (ios->power_mode != MMC_POWER_UP) {
-		if (host->power) {
-			struct tmio_mmc_data *pdata = host->pdata;
-			if (ios->power_mode == MMC_POWER_OFF)
+		struct tmio_mmc_data *pdata = host->pdata;
+		unsigned int old_power = host->power;
+
+		if (old_power != TMIO_MMC_OFF_STOP) {
+			if (ios->power_mode == MMC_POWER_OFF) {
 				tmio_mmc_power_off(host);
+				host->power = TMIO_MMC_OFF_STOP;
+			} else {
+				host->power = TMIO_MMC_ON_STOP;
+			}
+		}
+
+		if (old_power == TMIO_MMC_ON_RUN) {
 			tmio_mmc_clk_stop(host);
-			host->power = false;
 			pm_runtime_put(dev);
 			if (pdata->clk_disable)
 				pdata->clk_disable(host->pdev);
 		}
 	}
 
-	if (host->power) {
+	if (host->power != TMIO_MMC_OFF_STOP) {
 		switch (ios->bus_width) {
 		case MMC_BUS_WIDTH_1:
 			sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
@@ -1029,7 +1036,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  mmc->caps & MMC_CAP_NONREMOVABLE ||
 				  mmc->slot.cd_irq >= 0);
 
-	_host->power = false;
+	_host->power = TMIO_MMC_OFF_STOP;
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
-- 
1.7.2.5

