From: Balaji T K <balajitk@ti.com>
Subject: [PATCHv2 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Tue, 28 Jun 2011 22:57:28 +0530
Message-ID: <1309282049-23739-3-git-send-email-balajitk@ti.com>
References: <1309282049-23739-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47232 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759509Ab1F1R2p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 13:28:45 -0400
In-Reply-To: <1309282049-23739-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, svenkatr@ti.com, Balaji T K <balajitk@ti.com>

add runtime pm support to HSMMC host controller
Use runtime pm API to enable/disable HSMMC clock
Use runtime autosuspend APIs to enable auto suspend delay

Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore Kadiyala

Signed-off-by: Balaji T K <balajitk@ti.com>
---
changes since v1
Removed pm_runtime_allow, pm_runtime_forbid, pm_suspend_ignore_children calls.

 drivers/mmc/host/omap_hsmmc.c |  119 +++++++++++++++++++++--------------------
 1 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0c3d0a4..85fd228 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -33,6 +33,7 @@
 #include <linux/semaphore.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 #include <plat/dma.h>
 #include <mach/hardware.h>
 #include <plat/board.h>
@@ -116,6 +117,7 @@
 #define OMAP_MMC4_DEVID		3
 #define OMAP_MMC5_DEVID		4
 
+#define MMC_AUTOSUSPEND_DELAY	50
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
 #define DRIVER_NAME		"omap_hsmmc"
@@ -1150,8 +1152,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	int ret;
 
 	/* Disable the clocks */
-	clk_disable(host->fclk);
-	clk_disable(host->iclk);
+	pm_runtime_put_sync(host->dev);
 	if (host->got_dbclk)
 		clk_disable(host->dbclk);
 
@@ -1162,8 +1163,7 @@ static int omap_hsmmc_switch_opcond(struct omap_hsmmc_host *host, int vdd)
 	if (!ret)
 		ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1,
 					       vdd);
-	clk_enable(host->iclk);
-	clk_enable(host->fclk);
+	pm_runtime_get_sync(host->dev);
 	if (host->got_dbclk)
 		clk_enable(host->dbclk);
 
@@ -1529,7 +1529,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	u32 con;
 	int do_send_init_stream = 0;
 
-	mmc_host_enable(host->mmc);
+	pm_runtime_get_sync(host->dev);
 
 	if (ios->power_mode != host->power_mode) {
 		switch (ios->power_mode) {
@@ -1624,8 +1624,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
 
-	if (host->power_mode == MMC_POWER_OFF)
-		mmc_host_disable(host->mmc);
+	pm_runtime_put_autosuspend(host->dev);
 }
 
 static int omap_hsmmc_get_cd(struct mmc_host *mmc)
@@ -1681,32 +1680,28 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 	set_sd_bus_power(host);
 }
 
-static int omap_hsmmc_enable_fclk(struct mmc_host *mmc)
+static int omap_hsmmc_enable(struct mmc_host *mmc)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
-	int err;
 
-	err = clk_enable(host->fclk);
-	if (err)
-		return err;
-	dev_dbg(mmc_dev(host->mmc), "mmc_fclk: enabled\n");
-	omap_hsmmc_context_restore(host);
+	pm_runtime_get_sync(host->dev);
+
 	return 0;
 }
 
-static int omap_hsmmc_disable_fclk(struct mmc_host *mmc, int lazy)
+static int omap_hsmmc_disable(struct mmc_host *mmc, int lazy)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	omap_hsmmc_context_save(host);
-	clk_disable(host->fclk);
-	dev_dbg(mmc_dev(host->mmc), "mmc_fclk: disabled\n");
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
+
 	return 0;
 }
 
 static const struct mmc_host_ops omap_hsmmc_ops = {
-	.enable = omap_hsmmc_enable_fclk,
-	.disable = omap_hsmmc_disable_fclk,
+	.enable = omap_hsmmc_enable,
+	.disable = omap_hsmmc_disable,
 	.request = omap_hsmmc_request,
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
@@ -1741,10 +1736,7 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	if (clk_enable(host->fclk) != 0) {
-		seq_printf(s, "can't read the regs\n");
-		return 0;
-	}
+	pm_runtime_get_sync(host->dev);
 
 	seq_printf(s, "SYSCONFIG:\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, SYSCONFIG));
@@ -1761,7 +1753,8 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
 	seq_printf(s, "CAPA:\t\t0x%08x\n",
 			OMAP_HSMMC_READ(host->base, CAPA));
 
-	clk_disable(host->fclk);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 
 	return 0;
 }
@@ -1881,18 +1874,10 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->caps |= MMC_CAP_DISABLE;
 
-	if (clk_enable(host->iclk) != 0) {
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
-
-	if (mmc_host_enable(host->mmc) != 0) {
-		clk_disable(host->iclk);
-		clk_put(host->iclk);
-		clk_put(host->fclk);
-		goto err1;
-	}
+	pm_runtime_enable(host->dev);
+	pm_runtime_get_sync(host->dev);
+	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(host->dev);
 
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
@@ -2019,6 +2004,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	omap_hsmmc_debugfs(mmc);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 
 	return 0;
 
@@ -2034,8 +2021,8 @@ err_reg:
 err_irq_cd_init:
 	free_irq(host->irq, host);
 err_irq:
-	mmc_host_disable(host->mmc);
-	clk_disable(host->iclk);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 	clk_put(host->fclk);
 	clk_put(host->iclk);
 	if (host->got_dbclk) {
@@ -2059,7 +2046,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	struct resource *res;
 
 	if (host) {
-		mmc_host_enable(host->mmc);
+		pm_runtime_get_sync(host->dev);
 		mmc_remove_host(host->mmc);
 		if (host->use_reg)
 			omap_hsmmc_reg_put(host);
@@ -2070,8 +2057,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 			free_irq(mmc_slot(host).card_detect_irq, host);
 		flush_work_sync(&host->mmc_carddetect_work);
 
-		mmc_host_disable(host->mmc);
-		clk_disable(host->iclk);
+		pm_runtime_put_sync(host->dev);
+		pm_runtime_disable(host->dev);
 		clk_put(host->fclk);
 		clk_put(host->iclk);
 		if (host->got_dbclk) {
@@ -2103,6 +2090,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 		return 0;
 
 	if (host) {
+		pm_runtime_get_sync(host->dev);
 		host->suspended = 1;
 		if (host->pdata->suspend) {
 			ret = host->pdata->suspend(&pdev->dev,
@@ -2117,13 +2105,11 @@ static int omap_hsmmc_suspend(struct device *dev)
 		}
 		cancel_work_sync(&host->mmc_carddetect_work);
 		ret = mmc_suspend_host(host->mmc);
-		mmc_host_enable(host->mmc);
+
 		if (ret == 0) {
 			omap_hsmmc_disable_irq(host);
 			OMAP_HSMMC_WRITE(host->base, HCTL,
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
-			mmc_host_disable(host->mmc);
-			clk_disable(host->iclk);
 			if (host->got_dbclk)
 				clk_disable(host->dbclk);
 		} else {
@@ -2135,9 +2121,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 					dev_dbg(mmc_dev(host->mmc),
 						"Unmask interrupt failed\n");
 			}
-			mmc_host_disable(host->mmc);
 		}
-
+		pm_runtime_put_sync(host->dev);
 	}
 	return ret;
 }
@@ -2153,14 +2138,7 @@ static int omap_hsmmc_resume(struct device *dev)
 		return 0;
 
 	if (host) {
-		ret = clk_enable(host->iclk);
-		if (ret)
-			goto clk_en_err;
-
-		if (mmc_host_enable(host->mmc) != 0) {
-			clk_disable(host->iclk);
-			goto clk_en_err;
-		}
+		pm_runtime_get_sync(host->dev);
 
 		if (host->got_dbclk)
 			clk_enable(host->dbclk);
@@ -2180,14 +2158,13 @@ static int omap_hsmmc_resume(struct device *dev)
 		ret = mmc_resume_host(host->mmc);
 		if (ret == 0)
 			host->suspended = 0;
+
+		pm_runtime_mark_last_busy(host->dev);
+		pm_runtime_put_autosuspend(host->dev);
 	}
 
 	return ret;
 
-clk_en_err:
-	dev_dbg(mmc_dev(host->mmc),
-		"Failed to enable MMC clocks during resume\n");
-	return ret;
 }
 
 #else
@@ -2195,9 +2172,33 @@ clk_en_err:
 #define omap_hsmmc_resume		NULL
 #endif
 
+static int omap_hsmmc_runtime_suspend(struct device *dev)
+{
+	struct omap_hsmmc_host *host;
+
+	host = platform_get_drvdata(to_platform_device(dev));
+	omap_hsmmc_context_save(host);
+	dev_dbg(mmc_dev(host->mmc), "disabled\n");
+
+	return 0;
+}
+
+static int omap_hsmmc_runtime_resume(struct device *dev)
+{
+	struct omap_hsmmc_host *host;
+
+	host = platform_get_drvdata(to_platform_device(dev));
+	omap_hsmmc_context_restore(host);
+	dev_dbg(mmc_dev(host->mmc), "host: enabled\n");
+
+	return 0;
+}
+
 static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
 	.suspend	= omap_hsmmc_suspend,
 	.resume		= omap_hsmmc_resume,
+	.runtime_suspend = omap_hsmmc_runtime_suspend,
+	.runtime_resume = omap_hsmmc_runtime_resume,
 };
 
 static struct platform_driver omap_hsmmc_driver = {
-- 
1.7.0.4

