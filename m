From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/11] mmc: sdhci-esdhc-imx: Assign system PM ops within #ifdef CONFIG_PM_SLEEP
Date: Wed, 27 Jul 2016 13:32:03 +0200
Message-ID: <1469619127-29283-8-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33590 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbcG0LcX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:23 -0400
Received: by mail-lf0-f46.google.com with SMTP id b199so25207712lfe.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:23 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dong Aisheng <aisheng.dong@nxp.com>

The system PM callbacks isn't used unless CONFIG_PM_SLEEP is set, thus it
triggers a compiler warning about unused functions. Avoid this by changing
from CONFIG_PM to CONFIG_PM_SLEEP.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b70d0b3b5b29 ("mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback")
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2bb326b..f5768a6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1293,7 +1293,7 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int sdhci_esdhc_suspend(struct device *dev)
 {
 	return sdhci_pltfm_suspend(dev);
@@ -1308,7 +1308,9 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	return sdhci_pltfm_resume(dev);
 }
+#endif
 
+#ifdef CONFIG_PM
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-- 
1.9.1

