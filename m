From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] DRAFT: shdci: allows custom wakeup irqs for runtime PM
Date: Fri, 25 Mar 2016 17:05:02 +0100
Message-ID: <1458921903-11133-2-git-send-email-ludovic.desroches@atmel.com>
References: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:5018 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbcCYQFl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2016 12:05:41 -0400
In-Reply-To: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++--------------------------
 drivers/mmc/host/sdhci.c         | 12 +++++-------
 drivers/mmc/host/sdhci.h         |  2 +-
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 2703aa9..d70bb7a 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -62,12 +62,14 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
-	ret = sdhci_runtime_suspend_host(host);
+	ret = sdhci_runtime_suspend_host(host, SDHCI_INT_CARD_INT | SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
 
 	clk_disable_unprepare(priv->gck);
-	clk_disable_unprepare(priv->hclock);
+	//clk_disable_unprepare(priv->hclock);
 	clk_disable_unprepare(priv->mainck);
 
+	printk("sdhci_at91_runtime_suspend\n");
+
 	return ret;
 }
 
@@ -78,17 +80,18 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	printk("sdhci_at91_runtime_resume\n");
 	ret = clk_prepare_enable(priv->mainck);
 	if (ret) {
 		dev_err(dev, "can't enable mainck\n");
 		return ret;
 	}
 
-	ret = clk_prepare_enable(priv->hclock);
-	if (ret) {
-		dev_err(dev, "can't enable hclock\n");
-		return ret;
-	}
+	//ret = clk_prepare_enable(priv->hclock);
+	//if (ret) {
+	//	dev_err(dev, "can't enable hclock\n");
+	//	return ret;
+	//}
 
 	ret = clk_prepare_enable(priv->gck);
 	if (ret) {
@@ -205,25 +208,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	if (ret)
 		goto pm_runtime_disable;
 
-	/*
-	 * When calling sdhci_runtime_suspend_host(), the sdhci layer makes
-	 * the assumption that all the clocks of the controller are disabled.
-	 * It means we can't get irq from it when it is runtime suspended.
-	 * For that reason, it is not planned to wake-up on a card detect irq
-	 * from the controller.
-	 * If we want to use runtime PM and to be able to wake-up on card
-	 * insertion, we have to use a GPIO for the card detection or we can
-	 * use polling. Be aware that using polling will resume/suspend the
-	 * controller between each attempt.
-	 * Disable SDHCI_QUIRK_BROKEN_CARD_DETECTION to be sure nobody tries
-	 * to enable polling via device tree with broken-cd property.
-	 */
-	if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
-	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc))) {
-		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-	}
-
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8670f16..619a64a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2467,11 +2467,6 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	spin_lock(&host->lock);
 
-	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
-		spin_unlock(&host->lock);
-		return IRQ_NONE;
-	}
-
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 	if (!intmask || intmask == 0xffffffff) {
 		result = IRQ_NONE;
@@ -2709,7 +2704,7 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 	pm_runtime_put_noidle(host->mmc->parent);
 }
 
-int sdhci_runtime_suspend_host(struct sdhci_host *host)
+int sdhci_runtime_suspend_host(struct sdhci_host *host, u32 wakeup_irqs)
 {
 	unsigned long flags;
 
@@ -2717,7 +2712,10 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	mmc_retune_needed(host->mmc);
 
 	spin_lock_irqsave(&host->lock, flags);
-	host->ier &= SDHCI_INT_CARD_INT;
+	if (wakeup_irqs)
+		host->ier = wakeup_irqs;
+	else
+		host->ier &= SDHCI_INT_CARD_INT;
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 3bd2803..b932e15 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -668,7 +668,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 extern int sdhci_suspend_host(struct sdhci_host *host);
 extern int sdhci_resume_host(struct sdhci_host *host);
 extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
-extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
+extern int sdhci_runtime_suspend_host(struct sdhci_host *host, u32 wakeup_irqs);
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
 
-- 
2.5.0

