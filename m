From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/11] mmc: sdhci-acpi: Simplify code by using SET_SYSTEM_SLEEP_PM_OPS
Date: Wed, 27 Jul 2016 13:31:58 +0200
Message-ID: <1469619127-29283-3-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33894 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676AbcG0LcQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:16 -0400
Received: by mail-lf0-f52.google.com with SMTP id l69so25157736lfg.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:15 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

By using the SET_SYSTEM_SLEEP_PM_OPS when assigning the system PM
callbacks, we can remove some #ifdefs so code becomes a bit cleaner.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-acpi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 458ffb7..5bf4bcf 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -531,11 +531,6 @@ static int sdhci_acpi_resume(struct device *dev)
 	return sdhci_resume_host(c->host);
 }
 
-#else
-
-#define sdhci_acpi_suspend	NULL
-#define sdhci_acpi_resume	NULL
-
 #endif
 
 #ifdef CONFIG_PM
@@ -559,8 +554,7 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops sdhci_acpi_pm_ops = {
-	.suspend		= sdhci_acpi_suspend,
-	.resume			= sdhci_acpi_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
 	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
 			sdhci_acpi_runtime_resume, NULL)
 };
-- 
1.9.1

