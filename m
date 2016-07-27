From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 08/11] mmc: sdhci-esdhc-imx: Use common sdhci_suspend|resume_host()
Date: Wed, 27 Jul 2016 13:32:04 +0200
Message-ID: <1469619127-29283-9-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33602 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbcG0Lc0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:26 -0400
Received: by mail-lf0-f54.google.com with SMTP id b199so25208328lfe.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:25 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

To prepare to make the sdhci_pltfm_suspend|resume() static functions, move
sdhci-esdhc-imx over to use the sdhci_suspend|resume_host().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f5768a6..99e0b33 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1296,7 +1296,9 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int sdhci_esdhc_suspend(struct device *dev)
 {
-	return sdhci_pltfm_suspend(dev);
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	return sdhci_suspend_host(host);
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
@@ -1306,7 +1308,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	return sdhci_pltfm_resume(dev);
+	return sdhci_resume_host(host);
 }
 #endif
 
-- 
1.9.1

