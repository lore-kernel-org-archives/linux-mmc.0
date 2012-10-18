From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: [PATCH v2] mmc: sdhci-s3c: ensure non-transaction of bus before clk_disable
Date: Thu, 18 Oct 2012 13:01:20 +0200
Message-ID: <201210181301.20819.heiko@sntech.de>
References: <004701cdad16$6886e890$3994b9b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36760 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590Ab2JRLBY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 07:01:24 -0400
In-Reply-To: <004701cdad16$6886e890$3994b9b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Chris Ball' <cjb@laptop.org>

Clock should be supplied during bus transaction. This patch defers
clk_disabe in runtime_suspend if CMD/DATA line is used.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
It's also necessary to destaticise the forward declarations in the top of
sdhci.c, which I've done in this v2.

 drivers/mmc/host/sdhci-s3c.c |   13 +++++++++----
 drivers/mmc/host/sdhci.c     |   14 ++++++++------
 drivers/mmc/host/sdhci.h     |    2 ++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 30e3d01..0cabf18 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -848,12 +848,17 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_s3c *ourhost = to_s3c(host);
 	struct clk *busclk = ourhost->clk_io;
-	int ret;
+	int ret = 0;
 
-	ret = sdhci_runtime_suspend_host(host);
+	if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+			(SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT))) {
+		ret = sdhci_runtime_suspend_host(host);
+		clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
+		clk_disable(busclk);
+	} else {
+		sdhci_runtime_pm_put(host);
+	}
 
-	clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
-	clk_disable(busclk);
 	return ret;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7922adb..57de949 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -55,14 +55,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
 
 #ifdef CONFIG_PM_RUNTIME
-static int sdhci_runtime_pm_get(struct sdhci_host *host);
-static int sdhci_runtime_pm_put(struct sdhci_host *host);
+int sdhci_runtime_pm_get(struct sdhci_host *host);
+int sdhci_runtime_pm_put(struct sdhci_host *host);
 #else
-static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
+inline int sdhci_runtime_pm_get(struct sdhci_host *host)
 {
 	return 0;
 }
-static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
+inline int sdhci_runtime_pm_put(struct sdhci_host *host)
 {
 	return 0;
 }
@@ -2535,16 +2535,18 @@ EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
 #ifdef CONFIG_PM_RUNTIME
 
-static int sdhci_runtime_pm_get(struct sdhci_host *host)
+int sdhci_runtime_pm_get(struct sdhci_host *host)
 {
 	return pm_runtime_get_sync(host->mmc->parent);
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_get);
 
-static int sdhci_runtime_pm_put(struct sdhci_host *host)
+int sdhci_runtime_pm_put(struct sdhci_host *host)
 {
 	pm_runtime_mark_last_busy(host->mmc->parent);
 	return pm_runtime_put_autosuspend(host->mmc->parent);
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_put);
 
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97653ea..fbf9a08 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -384,6 +384,8 @@ extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
+extern int sdhci_runtime_pm_get(struct sdhci_host *host);
+extern int sdhci_runtime_pm_put(struct sdhci_host *host);
 extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
-- 
1.7.2.3

