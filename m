From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Improve runtime PM support
Date: Fri, 21 Oct 2011 17:25:54 +0200
Message-ID: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:34419 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891Ab1JUP0W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2011 11:26:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Runtime PM support is now dynamically controling the
enable/disable of the clock and vcore regulator.

In runtime_suspend the register values are saved and in
runtime_resume register values are restored. We also make
use of the runtime_autosuspend with a timeout value
set to 50 ms.

Moreover a runtime_idle function is implemented to be able
to enter runtime suspend state after probe and when no
requests are recieved from the mmc framework (due to that
there are no card inserted).

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |  154 ++++++++++++++++++++++++++++++++++++++---------
 drivers/mmc/host/mmci.h |    6 ++-
 2 files changed, 131 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50b5f99..571834a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -166,14 +166,10 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	host->mrq = NULL;
 	host->cmd = NULL;
 
-	/*
-	 * Need to drop the host lock here; mmc_request_done may call
-	 * back into the driver...
-	 */
-	spin_unlock(&host->lock);
-	pm_runtime_put(mmc_dev(host->mmc));
 	mmc_request_done(host->mmc, mrq);
-	spin_lock(&host->lock);
+
+	pm_runtime_mark_last_busy(host->mmc->parent);
+	pm_runtime_put_autosuspend(host->mmc->parent);
 }
 
 static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
@@ -986,7 +982,7 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	pm_runtime_get_sync(mmc_dev(mmc));
+	pm_runtime_get_sync(mmc->parent);
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -1010,6 +1006,8 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long flags;
 	int ret;
 
+	pm_runtime_get_sync(mmc->parent);
+
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		if (host->vcc)
@@ -1058,12 +1056,15 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mmci_set_clkreg(host, ios->clock);
 
-	if (host->pwr != pwr) {
-		host->pwr = pwr;
+	if (host->pwr_reg != pwr) {
+		host->pwr_reg = pwr;
 		writel(pwr, host->base + MMCIPOWER);
 	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	pm_runtime_mark_last_busy(mmc->parent);
+	pm_runtime_put_autosuspend(mmc->parent);
 }
 
 static int mmci_get_ro(struct mmc_host *mmc)
@@ -1147,6 +1148,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	host->gpio_wp = -ENOSYS;
 	host->gpio_cd = -ENOSYS;
 	host->gpio_cd_irq = -1;
+	host->irqmask0_reg = 0;
+	host->pwr_reg = 0;
+	host->clk_reg = 0;
 
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
@@ -1324,6 +1328,7 @@ static int __devinit mmci_probe(struct amba_device *dev,
 			goto irq0_free;
 	}
 
+	host->irqmask0_reg = MCI_IRQENABLE;
 	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
@@ -1335,7 +1340,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 
 	mmci_dma_setup(host);
 
-	pm_runtime_put(&dev->dev);
+	pm_runtime_set_autosuspend_delay(mmc->parent, 50);
+	pm_runtime_use_autosuspend(mmc->parent);
+	pm_runtime_put(mmc->parent);
 
 	mmc_add_host(mmc);
 
@@ -1377,10 +1384,11 @@ static int __devexit mmci_remove(struct amba_device *dev)
 		struct mmci_host *host = mmc_priv(mmc);
 
 		/*
-		 * Undo pm_runtime_put() in probe.  We use the _sync
-		 * version here so that we can access the primecell.
+		 * Make sure the host is resumed and undo the
+		 * pm_runtime_put in probe.
 		 */
-		pm_runtime_get_sync(&dev->dev);
+		pm_runtime_resume(mmc->parent);
+		pm_runtime_get_noresume(mmc->parent);
 
 		mmc_remove_host(mmc);
 
@@ -1419,43 +1427,134 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_SUSPEND
+
+#ifdef CONFIG_PM_RUNTIME
+static void mmci_disable_irq(struct mmci_host *host) {}
+static void mmci_enable_irq(struct mmci_host *host) {}
+#else
+static void mmci_disable_irq(struct mmci_host *host)
 {
-	struct mmc_host *mmc = amba_get_drvdata(dev);
+	writel(0, host->base + MMCIMASK0);
+}
+static void mmci_enable_irq(struct mmci_host *host)
+{
+	writel(host->irqmask0_reg, host->base + MMCIMASK0);
+}
+#endif
+
+static int mmci_suspend(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
 	int ret = 0;
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 
+		pm_runtime_get_sync(mmc->parent);
+
 		ret = mmc_suspend_host(mmc);
-		if (ret == 0)
-			writel(0, host->base + MMCIMASK0);
+		if (!ret)
+			mmci_disable_irq(host);
+
+		pm_runtime_put_sync_suspend(mmc->parent);
 	}
 
 	return ret;
 }
 
-static int mmci_resume(struct amba_device *dev)
+static int mmci_resume(struct device *dev)
 {
-	struct mmc_host *mmc = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
 	int ret = 0;
 
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 
-		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
-
+		mmci_enable_irq(host);
 		ret = mmc_resume_host(mmc);
 	}
 
 	return ret;
 }
-#else
-#define mmci_suspend	NULL
-#define mmci_resume	NULL
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int mmci_runtime_suspend(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+	unsigned long flags;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* Save registers for POWER, CLOCK and IRQMASK0 */
+		host->irqmask0_reg = readl(host->base + MMCIMASK0);
+		host->pwr_reg = readl(host->base + MMCIPOWER);
+		host->clk_reg = readl(host->base + MMCICLOCK);
+
+		/*
+		 * Make sure we do not get any interrupts when we disabled the
+		 * clock and the regulator and as well make sure to clear the
+		 * registers for clock and power.
+		 */
+		writel(0, host->base + MMCIMASK0);
+		writel(0, host->base + MMCIPOWER);
+		writel(0, host->base + MMCICLOCK);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		clk_disable(host->clk);
+		amba_vcore_disable(adev);
+	}
+
+	return 0;
+}
+
+static int mmci_runtime_resume(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+	unsigned long flags;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		amba_vcore_enable(adev);
+		clk_enable(host->clk);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* Restore registers for POWER, CLOCK and IRQMASK0 */
+		writel(host->clk_reg, host->base + MMCICLOCK);
+		writel(host->pwr_reg, host->base + MMCIPOWER);
+		writel(host->irqmask0_reg, host->base + MMCIMASK0);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+	return 0;
+}
+
+static int mmci_runtime_idle(struct device *dev)
+{
+	pm_runtime_suspend(dev);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops mmci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+	SET_RUNTIME_PM_OPS(mmci_runtime_suspend,
+			   mmci_runtime_resume,
+			   mmci_runtime_idle)
+};
+
 static struct amba_id mmci_ids[] = {
 	{
 		.id	= 0x00041180,
@@ -1499,11 +1598,10 @@ static struct amba_id mmci_ids[] = {
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
+		.pm	= &mmci_dev_pm_ops,
 	},
 	.probe		= mmci_probe,
 	.remove		= __devexit_p(mmci_remove),
-	.suspend	= mmci_suspend,
-	.resume		= mmci_resume,
 	.id_table	= mmci_ids,
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 79e4143..4ae0f84 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -189,7 +189,6 @@ struct mmci_host {
 
 	unsigned int		mclk;
 	unsigned int		cclk;
-	u32			pwr;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
 
@@ -199,6 +198,11 @@ struct mmci_host {
 	struct timer_list	timer;
 	unsigned int		oldstat;
 
+	/* register cache */
+	u32			irqmask0_reg;
+	u32			pwr_reg;
+	u32			clk_reg;
+
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
-- 
1.7.5.4

