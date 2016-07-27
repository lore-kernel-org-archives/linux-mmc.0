From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/11] mmc: sdhci-s3c: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
Date: Wed, 27 Jul 2016 13:32:01 +0200
Message-ID: <1469619127-29283-6-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33565 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbcG0LcU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:20 -0400
Received: by mail-lf0-f48.google.com with SMTP id b199so25206654lfe.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:19 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

As the SET_SYSTEM_SLEEP_PM_OPS and the SET_RUNTIME_PM_OPS macro deals with
the CONFIG_PM options when assigning the callbacks, it becomes redundant
to control this when declaring the struct dev_pm_ops. Instead let's always
declare it as it simplifies the code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 70c724b..784c5a8 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -714,19 +714,12 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM
 static const struct dev_pm_ops sdhci_s3c_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
 	SET_RUNTIME_PM_OPS(sdhci_s3c_runtime_suspend, sdhci_s3c_runtime_resume,
 			   NULL)
 };
 
-#define SDHCI_S3C_PMOPS (&sdhci_s3c_pmops)
-
-#else
-#define SDHCI_S3C_PMOPS NULL
-#endif
-
 #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
 static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
 	.no_divider = true,
@@ -765,7 +758,7 @@ static struct platform_driver sdhci_s3c_driver = {
 	.driver		= {
 		.name	= "s3c-sdhci",
 		.of_match_table = of_match_ptr(sdhci_s3c_dt_match),
-		.pm	= SDHCI_S3C_PMOPS,
+		.pm	= &sdhci_s3c_pmops,
 	},
 };
 
-- 
1.9.1

