From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 07/11] mmc: tmio_mmc: power status flag doesn't have to be exposed in platform data
Date: Wed,  4 Jan 2012 15:17:12 +0100
Message-ID: <1325686636-23905-8-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60760 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab2ADORY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 09:17:24 -0500
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

The controller power status flag does not have to be accessed from the
hot-plug detection code any more, it can now be removed from the platform
data and put in the controller private struct.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc.h     |    3 +++
 drivers/mmc/host/tmio_mmc_pio.c |   13 ++++++-------
 include/linux/mfd/tmio.h        |    1 -
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9fb6e6b..0c39002 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -49,6 +49,9 @@ struct tmio_mmc_host {
 	struct mmc_host         *mmc;
 	unsigned int		sdio_irq_enabled;
 
+	/* Controller power state */
+	bool			power;
+
 	/* Callbacks for clock / power control */
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 41b7eff..478e57b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -754,7 +754,6 @@ fail:
 static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned long flags;
 
 	mutex_lock(&host->ios_lock);
@@ -784,15 +783,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	/*
-	 * pdata->power toggles between false and true in both cases - either
+	 * host->power toggles between false and true in both cases - either
 	 * or not the controller can be runtime-suspended during inactivity. But
 	 * if the controller has to be kept on, the runtime-pm usage_count is
 	 * kept positive, so no suspending actually takes place.
 	 */
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
-		if (!pdata->power) {
+		if (!host->power) {
 			pm_runtime_get_sync(&host->pdev->dev);
-			pdata->power = true;
+			host->power = true;
 		}
 		tmio_mmc_set_clock(host, ios->clock);
 		/* power up SD bus */
@@ -803,8 +802,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	} else if (ios->power_mode != MMC_POWER_UP) {
 		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
 			host->set_pwr(host->pdev, 0);
-		if (pdata->power) {
-			pdata->power = false;
+		if (host->power) {
+			host->power = false;
 			pm_runtime_put(&host->pdev->dev);
 		}
 		tmio_mmc_clk_stop(host);
@@ -914,7 +913,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_HAS_COLD_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  mmc->caps & MMC_CAP_NONREMOVABLE);
-	pdata->power = false;
+	_host->power = false;
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 08fb7d2..367c65c6 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -98,7 +98,6 @@ struct tmio_mmc_data {
 	u32				ocr_mask;	/* available voltages */
 	struct tmio_mmc_dma		*dma;
 	struct device			*dev;
-	bool				power;
 	unsigned int			cd_gpio;
 	unsigned int			cd_irq;
 	unsigned long			cd_flags;
-- 
1.7.2.5

