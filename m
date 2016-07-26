From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: sdhci-esdhc-imx: avoid unused function warnings
Date: Tue, 26 Jul 2016 14:32:34 +0200
Message-ID: <20160726123246.879426-1-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51773 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbcGZMc7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2016 08:32:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The driver has just gained a slightly incorrect pm-sleep implementation that causes
warnings when CONFIG_PM is set but CONFIG_PM_SLEEP is not:

drivers/mmc/host/sdhci-esdhc-imx.c:1302:12: error: 'sdhci_esdhc_resume' defined but not used [-Werror=unused-function]
 static int sdhci_esdhc_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-esdhc-imx.c:1297:12: error: 'sdhci_esdhc_suspend' defined but not used [-Werror=unused-function]
 static int sdhci_esdhc_suspend(struct device *dev)

This replaces the incorrect #ifdef with a __maybe_unused annotation that does
the right thing in all configurations and is more readable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b70d0b3b5b29 ("mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback")
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2bb326bbc34a..593e34053c4b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1293,13 +1293,12 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int sdhci_esdhc_suspend(struct device *dev)
+static int __maybe_unused sdhci_esdhc_suspend(struct device *dev)
 {
 	return sdhci_pltfm_suspend(dev);
 }
 
-static int sdhci_esdhc_resume(struct device *dev)
+static int __maybe_unused sdhci_esdhc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
@@ -1309,7 +1308,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 	return sdhci_pltfm_resume(dev);
 }
 
-static int sdhci_esdhc_runtime_suspend(struct device *dev)
+static int __maybe_unused sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1327,7 +1326,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	return ret;
 }
 
-static int sdhci_esdhc_runtime_resume(struct device *dev)
+static int __maybe_unused sdhci_esdhc_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1341,7 +1340,6 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 
 	return sdhci_runtime_resume_host(host);
 }
-#endif
 
 static const struct dev_pm_ops sdhci_esdhc_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
-- 
2.9.0

