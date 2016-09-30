From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 1/4] mmc: dw_mmc: add runtime PM callback
Date: Fri, 30 Sep 2016 16:48:34 +0800
Message-ID: <1475225317-2815-2-git-send-email-shawn.lin@rock-chips.com>
References: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:53463 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbcI3IqY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2016 04:46:24 -0400
In-Reply-To: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch add dw_mci_runtime_suspend/resume interfaces
and expose it to dw_mci variant driver to support runtime
PM.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.h |  4 +++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4fcbc40..54b860e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3266,7 +3266,7 @@ EXPORT_SYMBOL(dw_mci_remove);
 
 
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 /*
  * TODO: we should probably disable the clock to the card in the suspend path.
  */
@@ -3324,7 +3324,63 @@ int dw_mci_resume(struct dw_mci *host)
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_resume);
-#endif /* CONFIG_PM_SLEEP */
+
+int dw_mci_runtime_suspend(struct dw_mci *host)
+{
+	printk("dw_mci_runtime_suspend\n");
+
+	if (host->use_dma && host->dma_ops->exit)
+		host->dma_ops->exit(host);
+
+	clk_disable_unprepare(host->ciu_clk);
+
+	return 0;
+}
+EXPORT_SYMBOL(dw_mci_runtime_suspend);
+
+int dw_mci_runtime_resume(struct dw_mci *host)
+{
+	int ret = 0;
+	int i;
+
+	printk("dw_mci_runtime_resume\n");
+
+	ret = clk_prepare_enable(host->ciu_clk);
+	if (ret)
+		return ret;
+
+	if (host->use_dma && host->dma_ops->init)
+		host->dma_ops->init(host);
+
+	mci_writel(host, FIFOTH, host->fifoth_val);
+	host->prev_blksz = 0;
+
+	mci_writel(host, TMOUT, 0xFFFFFFFF);
+	mci_writel(host, RINTSTS, 0xFFFFFFFF);
+	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE |
+				  SDMMC_INT_DATA_OVER |
+				  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
+				  DW_MCI_ERROR_FLAGS);
+	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
+
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slot[i];
+
+		if (!slot)
+			continue;
+
+		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
+			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
+			dw_mci_setup_bus(slot, true);
+		}
+	}
+
+	dw_mci_enable_cd(host);
+
+	return ret;
+}
+EXPORT_SYMBOL(dw_mci_runtime_resume);
+#endif /* CONFIG_PM */
 
 static int __init dw_mci_init(void)
 {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index e8cd2de..baa7261 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -234,9 +234,11 @@
 
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 extern int dw_mci_suspend(struct dw_mci *host);
 extern int dw_mci_resume(struct dw_mci *host);
+extern int dw_mci_runtime_suspend(struct dw_mci *host);
+extern int dw_mci_runtime_resume(struct dw_mci *host);
 #endif
 
 /**
-- 
2.3.7


