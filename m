From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/11] mmc: sdhci-pltfm: Make sdhci_pltfm_suspend|resume() static
Date: Wed, 27 Jul 2016 13:32:05 +0200
Message-ID: <1469619127-29283-10-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35699 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbcG0Lc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:27 -0400
Received: by mail-lf0-f48.google.com with SMTP id f93so25148889lfi.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:26 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

There are no users left of these exported APIs, so let's make them static.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 6 ++----
 drivers/mmc/host/sdhci-pltfm.h | 2 --
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 64f287a..7b1aacc 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -216,21 +216,19 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
 #ifdef CONFIG_PM
-int sdhci_pltfm_suspend(struct device *dev)
+static int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	return sdhci_suspend_host(host);
 }
-EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
 
-int sdhci_pltfm_resume(struct device *dev)
+static int sdhci_pltfm_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	return sdhci_resume_host(host);
 }
-EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
 
 const struct dev_pm_ops sdhci_pltfm_pmops = {
 	.suspend	= sdhci_pltfm_suspend,
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index d38053b..6c99210 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -110,8 +110,6 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 }
 
 #ifdef CONFIG_PM
-extern int sdhci_pltfm_suspend(struct device *dev);
-extern int sdhci_pltfm_resume(struct device *dev);
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
 #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
 #else
-- 
1.9.1

