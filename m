From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/11] mmc: sdhci-sirf: Remove non needed #ifdef CONFIG_PM* for dev_pm_ops
Date: Wed, 27 Jul 2016 13:32:02 +0200
Message-ID: <1469619127-29283-7-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35914 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbcG0LcW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:22 -0400
Received: by mail-lf0-f49.google.com with SMTP id g62so25074816lfe.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:21 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

The SIMPLE_DEV_PM_OPS macro deals with the CONFIG_PM options when
assigning the PM callbacks, thus it's not needed to control this when
using the macro. By removing the non needed #ifdef, the code becomes a
bit cleaner.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-sirf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 34866f6..5d06863 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -260,9 +260,9 @@ static int sdhci_sirf_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
+#endif
 
 static SIMPLE_DEV_PM_OPS(sdhci_sirf_pm_ops, sdhci_sirf_suspend, sdhci_sirf_resume);
-#endif
 
 static const struct of_device_id sdhci_sirf_of_match[] = {
 	{ .compatible = "sirf,prima2-sdhc" },
@@ -274,9 +274,7 @@ static struct platform_driver sdhci_sirf_driver = {
 	.driver		= {
 		.name	= "sdhci-sirf",
 		.of_match_table = sdhci_sirf_of_match,
-#ifdef CONFIG_PM_SLEEP
 		.pm	= &sdhci_sirf_pm_ops,
-#endif
 	},
 	.probe		= sdhci_sirf_probe,
 	.remove		= sdhci_pltfm_unregister,
-- 
1.9.1

