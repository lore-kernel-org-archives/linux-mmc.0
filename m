From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3] mmc: sdhci-s3c: ensure non-transaction of bus before
 clk_disable
Date: Fri, 09 Nov 2012 19:41:21 +0900
Message-ID: <019501cdbe66$c232e770$4698b650$%jun@samsung.com>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
 <201210181302.30843.heiko@sntech.de>
 <006501cdadd0$548d1f70$fda75e50$%jun@samsung.com>
 <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19416 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2KIKlX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 05:41:23 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MD7005RCV0OKO41@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Nov 2012 19:41:22 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MD7002RVV0X43A0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 09 Nov 2012 19:41:21 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, =?utf-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Fengguang Wu' <fengguang.wu@intel.com>

clock shoud be supplied during bus transaction. This patch defers
clk_disabe in runtime_suspend if cmd/data line is used.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
V3: Removed the error message. (reported by Fengguang Wu)

 drivers/mmc/host/sdhci-s3c.c |   13 +++++++++----
 drivers/mmc/host/sdhci.c     |   20 ++++----------------
 drivers/mmc/host/sdhci.h     |   12 ++++++++++++
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index a54dd5d..d680c0b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -847,12 +847,17 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_s3c *ourhost = to_s3c(host);
 	struct clk *busclk = ourhost->clk_io;
-	int ret;
+	int ret = 0;
 
-	ret = sdhci_runtime_suspend_host(host);
+	if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
+			(SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT))) {
+		ret = sdhci_runtime_suspend_host(host);
+		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
+		clk_disable_unprepare(busclk);
+	} else {
+		sdhci_runtime_pm_put(host);
+	}
 
-	clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
-	clk_disable_unprepare(busclk);
 	return ret;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7851c0..59b60e1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -54,20 +54,6 @@ static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_tuning_timer(unsigned long data);
 
-#ifdef CONFIG_PM_RUNTIME
-static int sdhci_runtime_pm_get(struct sdhci_host *host);
-static int sdhci_runtime_pm_put(struct sdhci_host *host);
-#else
-static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
-{
-	return 0;
-}
-static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
-{
-	return 0;
-}
-#endif
-
 static void sdhci_dumpregs(struct sdhci_host *host)
 {
 	pr_debug(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
@@ -2538,16 +2524,18 @@ EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
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
index 71a4a7e..02edce1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -385,8 +385,20 @@ extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
+extern int sdhci_runtime_pm_get(struct sdhci_host *host);
+extern int sdhci_runtime_pm_put(struct sdhci_host *host);
 extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
+#else
+static inline int sdhci_runtime_pm_get(struct sdhci_host *host)
+{
+	return 0;
+}
+
+static inline int sdhci_runtime_pm_put(struct sdhci_host *host)
+{
+	return 0;
+}
 #endif
 
 #endif /* __SDHCI_HW_H */
-- 
1.7.0.4


