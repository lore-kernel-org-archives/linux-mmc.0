From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 8/8] mmc: tmio: Handle clock gating from runtime PM functions
Date: Fri,  8 Nov 2013 07:06:16 +0100
Message-ID: <1383890776-6912-9-git-send-email-ulf.hansson@linaro.org>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:42165 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KHGGi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 01:06:38 -0500
Received: by mail-la0-f47.google.com with SMTP id er20so1345266lab.6
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 22:06:36 -0800 (PST)
In-Reply-To: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add clock gating control as a part of the exported runtime PM
functions to provide tmio variants to use this in a common way.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc.h     |    3 ++-
 drivers/mmc/host/tmio_mmc_pio.c |   28 ++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 58d3c05..3b41568 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -74,9 +74,10 @@ struct tmio_mmc_host {
 	struct delayed_work	delayed_reset_work;
 	struct work_struct	done;
 
-	/* Cache IRQ mask */
+	/* Cache */
 	u32			sdcard_irq_mask;
 	u32			sdio_irq_mask;
+	unsigned int		clk_cache;
 
 	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index cbb96a8..bb18892 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -149,7 +149,8 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
-static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
+static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
+				unsigned int new_clock)
 {
 	u32 clk = 0, clock;
 
@@ -773,9 +774,9 @@ fail:
 	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
-static int tmio_mmc_clk_update(struct mmc_host *mmc)
+static int tmio_mmc_clk_update(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
 	int ret;
 
@@ -917,6 +918,8 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			ios->clock, ios->power_mode);
 	host->mrq = NULL;
 
+	host->clk_cache = ios->clock;
+
 	mutex_unlock(&host->ios_lock);
 
 	pm_runtime_mark_last_busy(mmc_dev(mmc));
@@ -1034,7 +1037,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  mmc->caps & MMC_CAP_NONREMOVABLE ||
 				  mmc->slot.cd_irq >= 0);
 
-	if (tmio_mmc_clk_update(mmc) < 0) {
+	if (tmio_mmc_clk_update(_host) < 0) {
 		mmc->f_max = pdata->hclk;
 		mmc->f_min = mmc->f_max / 512;
 	}
@@ -1160,6 +1163,15 @@ EXPORT_SYMBOL(tmio_mmc_host_resume);
 #ifdef CONFIG_PM_RUNTIME
 int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (host->clk_cache)
+		tmio_mmc_clk_stop(host);
+
+	if (host->pdata->clk_disable)
+		host->pdata->clk_disable(host->pdev);
+
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_suspend);
@@ -1171,6 +1183,14 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 
 	tmio_mmc_enable_dma(host, true);
 
+	tmio_mmc_reset(host);
+	tmio_mmc_clk_update(host);
+
+	if (host->clk_cache) {
+		tmio_mmc_set_clock(host, host->clk_cache);
+		tmio_mmc_clk_start(host);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
-- 
1.7.9.5

