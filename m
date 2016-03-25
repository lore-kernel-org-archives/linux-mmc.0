From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: sdhci-of-at91: allow the use of controller card detect as wake up
Date: Fri, 25 Mar 2016 17:05:03 +0100
Message-ID: <1458921903-11133-3-git-send-email-ludovic.desroches@atmel.com>
References: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458921903-11133-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

At the moment, there are only two ways to wake up from runtime suspend state:
- using a gpio for the card detection which is not a good solution since
  you still need the card detect pin of the controller.
- using polling which is also not a good solution since it will
  resume/suspend the controller between each attempt.

The sdhci layer makes the assumption that all the clocks are disabled
when suspending the controller. For that reason, irqs are rejected if
runtime_suspended is true.

This patch duplicates the sdhci_runtime_suspend_host() but doesn't set
runtime_suspended and doesn't disable the interface clock if there is a
removable device and no gpio for card detection.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 71 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 2703aa9..6683f2d 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -35,6 +35,7 @@ struct sdhci_at91_priv {
 	struct clk *hclock;
 	struct clk *gck;
 	struct clk *mainck;
+	bool disable_interface_clk;
 };
 
 static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
@@ -55,20 +56,47 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
 };
 
 #ifdef CONFIG_PM
+/*
+ * This function is the very same as sdhci_runtime_suspend_host but if the
+ * device is removable and we only have the controller card detect signal then
+ * we won't disable all the clocks. The interface clock will be needed to get
+ * card event interrupt.
+ * When calling sdhci_runtime_suspend_host(), the sdhci layer makes the
+ * assumption that all the clocks of the controller are disabled. If
+ * runtime_suspended is set, irqs will be rejected. That's why it won't be set
+ * if we want to wake up on card event.
+ */
 static int sdhci_at91_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	int ret;
+	unsigned long flags;
+
+	mmc_retune_timer_stop(host->mmc);
+	mmc_retune_needed(host->mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->ier &= SDHCI_INT_CARD_INT;
+	if (!priv->disable_interface_clk)
+		host->ier |= SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE;
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+	spin_unlock_irqrestore(&host->lock, flags);
 
-	ret = sdhci_runtime_suspend_host(host);
+	synchronize_hardirq(host->irq);
+
+	if (priv->disable_interface_clk) {
+		spin_lock_irqsave(&host->lock, flags);
+		host->runtime_suspended = true;
+		spin_unlock_irqrestore(&host->lock, flags);
+		clk_disable_unprepare(priv->hclock);
+	};
 
 	clk_disable_unprepare(priv->gck);
-	clk_disable_unprepare(priv->hclock);
 	clk_disable_unprepare(priv->mainck);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_at91_runtime_resume(struct device *dev)
@@ -84,18 +112,20 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(priv->hclock);
-	if (ret) {
-		dev_err(dev, "can't enable hclock\n");
-		return ret;
-	}
-
 	ret = clk_prepare_enable(priv->gck);
 	if (ret) {
 		dev_err(dev, "can't enable gck\n");
 		return ret;
 	}
 
+	if (priv->disable_interface_clk) {
+		ret = clk_prepare_enable(priv->hclock);
+		if (ret) {
+			dev_err(dev, "can't enable hclock\n");
+			return ret;
+		}
+	}
+
 	return sdhci_runtime_resume_host(host);
 }
 #endif /* CONFIG_PM */
@@ -206,23 +236,12 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		goto pm_runtime_disable;
 
 	/*
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
+	 * If the device is non removable or if there is a gpio for the card
+	 * detection, all the clocks can be disabled in runtime suspend state.
 	 */
-	if (!(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
-	    IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc))) {
-		host->mmc->caps |= MMC_CAP_NEEDS_POLL;
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
-	}
+	priv->disable_interface_clk = (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+				       || !IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc));
+
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
-- 
2.5.0
