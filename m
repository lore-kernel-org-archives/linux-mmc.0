From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/11] mmc: sdhci-pxav3: Remove non needed #ifdef CONFIG_PM for dev_pm_ops
Date: Wed, 27 Jul 2016 13:32:00 +0200
Message-ID: <1469619127-29283-5-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35643 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718AbcG0LcT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:19 -0400
Received: by mail-lf0-f46.google.com with SMTP id f93so25146406lfi.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:18 -0700 (PDT)
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
 drivers/mmc/host/sdhci-pxav3.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3013250..dd1938d 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -583,24 +583,17 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM
 static const struct dev_pm_ops sdhci_pxav3_pmops = {
 	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
 	SET_RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend,
 		sdhci_pxav3_runtime_resume, NULL)
 };
 
-#define SDHCI_PXAV3_PMOPS (&sdhci_pxav3_pmops)
-
-#else
-#define SDHCI_PXAV3_PMOPS NULL
-#endif
-
 static struct platform_driver sdhci_pxav3_driver = {
 	.driver		= {
 		.name	= "sdhci-pxav3",
 		.of_match_table = of_match_ptr(sdhci_pxav3_of_match),
-		.pm	= SDHCI_PXAV3_PMOPS,
+		.pm	= &sdhci_pxav3_pmops,
 	},
 	.probe		= sdhci_pxav3_probe,
 	.remove		= sdhci_pxav3_remove,
-- 
1.9.1

