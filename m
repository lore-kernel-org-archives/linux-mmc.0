From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 9/9] mmc: dw_mmc: remove system PM callback
Date: Wed, 12 Oct 2016 10:56:55 +0800
Message-ID: <1476241015-5932-1-git-send-email-shawn.lin@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:54275 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcJLCum (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2016 22:50:42 -0400
In-Reply-To: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

Now there are no variant drivers using dw_mci_suspend
and dw_mci_resume, so let's remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 81 ++++++++++++++++-------------------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 297b6c2..1c9ee36 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3267,27 +3267,41 @@ EXPORT_SYMBOL(dw_mci_remove);
 
 
 #ifdef CONFIG_PM
-/*
- * TODO: we should probably disable the clock to the card in the suspend path.
- */
-int dw_mci_suspend(struct dw_mci *host)
+int dw_mci_runtime_suspend(struct device *dev)
 {
+	struct dw_mci *host = dev_get_drvdata(dev);
+
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	clk_disable_unprepare(host->ciu_clk);
+
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc)))
+		clk_disable_unprepare(host->biu_clk);
+
 	return 0;
 }
-EXPORT_SYMBOL(dw_mci_suspend);
+EXPORT_SYMBOL(dw_mci_runtime_suspend);
 
-int dw_mci_resume(struct dw_mci *host)
+int dw_mci_runtime_resume(struct device *dev)
 {
-	int i, ret;
+	int i, ret = 0;
+	struct dw_mci *host = dev_get_drvdata(dev);
 
-	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
-		ret = -ENODEV;
-		return ret;
+	if (host->cur_slot &&
+	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+	     !mmc_card_is_removable(host->cur_slot->mmc))) {
+		ret = clk_prepare_enable(host->biu_clk);
+		if (ret)
+			return ret;
 	}
 
+	ret = clk_prepare_enable(host->ciu_clk);
+	if (ret)
+		return ret;
+
 	if (host->use_dma && host->dma_ops->init)
 		host->dma_ops->init(host);
 
@@ -3295,8 +3309,8 @@ int dw_mci_resume(struct dw_mci *host)
 	 * Restore the initial value at FIFOTH register
 	 * And Invalidate the prev_blksz with zero
 	 */
-	mci_writel(host, FIFOTH, host->fifoth_val);
-	host->prev_blksz = 0;
+	 mci_writel(host, FIFOTH, host->fifoth_val);
+	 host->prev_blksz = 0;
 
 	/* Put in max timeout */
 	mci_writel(host, TMOUT, 0xFFFFFFFF);
@@ -3321,48 +3335,7 @@ int dw_mci_resume(struct dw_mci *host)
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-	return 0;
-}
-EXPORT_SYMBOL(dw_mci_resume);
-
-int dw_mci_runtime_suspend(struct device *dev)
-{
-	int err = 0;
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	err = dw_mci_suspend(host);
-	if (err)
-		return err;
-
-	clk_disable_unprepare(host->ciu_clk);
-
-	if (host->cur_slot &&
-	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
-	     !mmc_card_is_removable(host->cur_slot->mmc)))
-		clk_disable_unprepare(host->biu_clk);
-
-	return err;
-}
-EXPORT_SYMBOL(dw_mci_runtime_suspend);
-
-int dw_mci_runtime_resume(struct device *dev)
-{
-	int ret = 0;
-	struct dw_mci *host = dev_get_drvdata(dev);
-
-	if (host->cur_slot &&
-	    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
-	     !mmc_card_is_removable(host->cur_slot->mmc))) {
-		ret = clk_prepare_enable(host->biu_clk);
-		if (ret)
-			return ret;
-	}
-
-	ret = clk_prepare_enable(host->ciu_clk);
-	if (ret)
-		return ret;
-
-	return dw_mci_resume(host);
+	return ret;
 }
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 #endif /* CONFIG_PM */
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index d14a391..4a6ae750 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -235,8 +235,6 @@
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
 #ifdef CONFIG_PM
-extern int dw_mci_suspend(struct dw_mci *host);
-extern int dw_mci_resume(struct dw_mci *host);
 extern int dw_mci_runtime_suspend(struct device *device);
 extern int dw_mci_runtime_resume(struct device *device);
 #endif
-- 
2.3.7


