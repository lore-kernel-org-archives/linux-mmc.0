From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-acpi: Remove redundant runtime PM idle callback
Date: Fri,  2 Jan 2015 15:15:48 +0100
Message-ID: <1420208148-28907-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:47019 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbABOP4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jan 2015 09:15:56 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so14793088lbv.40
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jan 2015 06:15:54 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-acpi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index e3e56d3..8f6c228 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -446,18 +446,13 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 	return sdhci_runtime_resume_host(c->host);
 }
 
-static int sdhci_acpi_runtime_idle(struct device *dev)
-{
-	return 0;
-}
-
 #endif
 
 static const struct dev_pm_ops sdhci_acpi_pm_ops = {
 	.suspend		= sdhci_acpi_suspend,
 	.resume			= sdhci_acpi_resume,
 	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
-			sdhci_acpi_runtime_resume, sdhci_acpi_runtime_idle)
+			sdhci_acpi_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_acpi_driver = {
-- 
1.9.1

