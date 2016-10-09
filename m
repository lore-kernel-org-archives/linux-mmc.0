From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH 9/9] mmc: dw_mmc: remove system PM callback
Date: Sun,  9 Oct 2016 22:02:01 +0800
Message-ID: <1476021721-923-5-git-send-email-shawn.lin@rock-chips.com>
References: <1476021506-869-1-git-send-email-shawn.lin@rock-chips.com>
 <1476021721-923-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:49894 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbcJIN6A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Oct 2016 09:58:00 -0400
In-Reply-To: <1476021721-923-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

Now there are no variant drivers using dw_mci_suspend
and dw_mci_resume, so let's remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 44 ++++++++------------------------------------
 drivers/mmc/host/dw_mmc.h |  2 --
 2 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5ef263..46a14c5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3267,26 +3267,24 @@ EXPORT_SYMBOL(dw_mci_remove);
 
 
 #ifdef CONFIG_PM
-/*
- * TODO: we should probably disable the clock to the card in the suspend path.
- */
-int dw_mci_suspend(struct dw_mci *host)
+int dw_mci_runtime_suspend(struct dw_mci *host)
 {
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	clk_disable_unprepare(host->ciu_clk);
+
 	return 0;
 }
-EXPORT_SYMBOL(dw_mci_suspend);
+EXPORT_SYMBOL(dw_mci_runtime_suspend);
 
-int dw_mci_resume(struct dw_mci *host)
+int dw_mci_runtime_resume(struct dw_mci *host)
 {
-	int i, ret;
+	int i, ret = 0;
 
-	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
-		ret = -ENODEV;
+	ret = clk_prepare_enable(host->ciu_clk);
+	if (ret)
 		return ret;
-	}
 
 	if (host->use_dma && host->dma_ops->init)
 		host->dma_ops->init(host);
@@ -3323,32 +3321,6 @@ int dw_mci_resume(struct dw_mci *host)
 
 	return 0;
 }
-EXPORT_SYMBOL(dw_mci_resume);
-
-int dw_mci_runtime_suspend(struct dw_mci *host)
-{
-	int err = 0;
-
-	err = dw_mci_suspend(host);
-	if (err)
-		return err;
-
-	clk_disable_unprepare(host->ciu_clk);
-
-	return err;
-}
-EXPORT_SYMBOL(dw_mci_runtime_suspend);
-
-int dw_mci_runtime_resume(struct dw_mci *host)
-{
-	int ret = 0;
-
-	ret = clk_prepare_enable(host->ciu_clk);
-	if (ret)
-		return ret;
-
-	return dw_mci_resume(host);
-}
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 #endif /* CONFIG_PM */
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index baa7261..b642dbb 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -235,8 +235,6 @@
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
 #ifdef CONFIG_PM
-extern int dw_mci_suspend(struct dw_mci *host);
-extern int dw_mci_resume(struct dw_mci *host);
 extern int dw_mci_runtime_suspend(struct dw_mci *host);
 extern int dw_mci_runtime_resume(struct dw_mci *host);
 #endif
-- 
2.3.7


