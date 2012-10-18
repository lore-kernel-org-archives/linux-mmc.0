From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: ensure non-transaction of bus before
 clk_disable
Date: Thu, 18 Oct 2012 18:53:21 +0900
Message-ID: <004701cdad16$6886e890$3994b9b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43614 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab2JRJxX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 05:53:23 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MC3006MG24MNM10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 18 Oct 2012 18:53:22 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MC300M9H24X2G60@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 18 Oct 2012 18:53:21 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: =?utf-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, 'Chander Kashyap' <chander.kashyap@linaro.org>, 'Chris Ball' <cjb@laptop.org>

Clock should be supplied during bus transaction. This patch defers
clk_disabe in runtime_suspend if CMD/DATA line is used.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   13 +++++++++----
 drivers/mmc/host/sdhci.c     |    6 ++++--
 drivers/mmc/host/sdhci.h     |    2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..490b781 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -845,12 +845,17 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
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
index 7922adb..deeffce 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
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
1.7.0.4


