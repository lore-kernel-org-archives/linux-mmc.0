From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: make sure usdhc clock enabled while doing suspend
Date: Tue, 18 Oct 2016 15:39:00 +0800
Message-ID: <1476776340-23718-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:2803
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030371AbcJRQIB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Oct 2016 12:08:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, dongas86@gmail.com
Cc: linux-mmc@vger.kernel.org, aisheng.dong@nxp.com, haibo.chen@nxp.com

When suspend usdhc, it will access usdhc register. So usdhc clock
should be enabled, otherwise the access usdhc register will return
error or cause system hung.

Take this into consideration, if system enable a usdhc and do not
connect any SD/SDIO/MMC card, after system boot up, this usdhc
will do runtime suspend, and close all usdhc clock. At this time,
if suspend the system, due to no card persent, usdhc runtime resume
will not be called. So usdhc clock still closed, then in suspend,
once access usdhc register, system hung or bus error return.

This patch make sure usdhc clock always enabled while doing usdhc
suspend.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7123ef9..1df3846 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1322,17 +1322,28 @@ static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
+#ifdef CONFIG_PM
+	pm_runtime_get_sync(host->mmc->parent);
+#endif
+
 	return sdhci_suspend_host(host);
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret;
 
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
+	ret = sdhci_resume_host(host);
 
-	return sdhci_resume_host(host);
+#ifdef CONFIG_PM
+	pm_runtime_mark_last_busy(host->mmc->parent);
+	pm_runtime_put_autosuspend(host->mmc->parent);
+#endif
+
+	return ret;
 }
 #endif
 
-- 
1.9.1

