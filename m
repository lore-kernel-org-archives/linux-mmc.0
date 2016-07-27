From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/11] mmc: sdhci-pltfm: Convert to use the SET_SYSTEM_SLEEP_PM_OPS
Date: Wed, 27 Jul 2016 13:32:06 +0200
Message-ID: <1469619127-29283-11-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35709 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbcG0Lc3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:29 -0400
Received: by mail-lf0-f54.google.com with SMTP id f93so25149359lfi.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:28 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Move the system PM callbacks within #ifdef CONFIG_PM_SLEEP as to avoid
them being build when not used. This also allows us to use the
SET_SYSTEM_SLEEP_PM_OPS macro which simplifies the code.

Within this context it also makes sense to move the declaration of the
struct sdhci_pltfm_pmops, outside the #ifdef CONFIG_PM as the
SET_SYSTEM_SLEEP_PM_OPS deals with this. This further simplifies the code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 7 +++----
 drivers/mmc/host/sdhci-pltfm.h | 4 ----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7b1aacc..1d17dcf 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -215,7 +215,7 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -229,13 +229,12 @@ static int sdhci_pltfm_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
+#endif
 
 const struct dev_pm_ops sdhci_pltfm_pmops = {
-	.suspend	= sdhci_pltfm_suspend,
-	.resume		= sdhci_pltfm_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
 };
 EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
-#endif	/* CONFIG_PM */
 
 static int __init sdhci_pltfm_drv_init(void)
 {
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 6c99210..0883a2a 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -109,11 +109,7 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 	return (void *)host->private;
 }
 
-#ifdef CONFIG_PM
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
 #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
-#else
-#define SDHCI_PLTFM_PMOPS NULL
-#endif
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
1.9.1

