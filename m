From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 07/10 v3] mmc: tmio_mmc: power status flag doesn't have to be exposed in platform data
Date: Thu,  9 Feb 2012 22:57:13 +0100
Message-ID: <1328824636-10553-8-git-send-email-g.liakhovetski@gmx.de>
References: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53765 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932216Ab2BIV5V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Feb 2012 16:57:21 -0500
In-Reply-To: <1328824636-10553-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

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
index ede2f4e5..edfcfd7 100644
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
index 3a28c62..2deb676 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -758,7 +758,6 @@ fail:
 static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned long flags;
 
 	mutex_lock(&host->ios_lock);
@@ -788,15 +787,15 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -807,8 +806,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -919,7 +918,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  mmc->caps & MMC_CAP_NONREMOVABLE);
-	pdata->power = false;
+	_host->power = false;
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume(&pdev->dev);
 	if (ret < 0)
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 5a197de..f5171db 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -105,7 +105,6 @@ struct tmio_mmc_data {
 	u32				ocr_mask;	/* available voltages */
 	struct tmio_mmc_dma		*dma;
 	struct device			*dev;
-	bool				power;
 	unsigned int			cd_gpio;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
-- 
1.7.2.5

