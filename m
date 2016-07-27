From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/11] mmc: sdhci-of-esdhc: Simplify code by using SIMPLE_DEV_PM_OPS
Date: Wed, 27 Jul 2016 13:31:59 +0200
Message-ID: <1469619127-29283-4-git-send-email-ulf.hansson@linaro.org>
References: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33545 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676AbcG0LcR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 07:32:17 -0400
Received: by mail-lf0-f47.google.com with SMTP id b199so25205773lfe.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jul 2016 04:32:16 -0700 (PDT)
In-Reply-To: <1469619127-29283-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Let's use the SIMPLE_DEV_PM_OPS macro when declaring/assigning the system
PM callbacks, as the code gets simplified.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 3f34d35..239be2f 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -481,7 +481,7 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static u32 esdhc_proctl;
 static int esdhc_of_suspend(struct device *dev)
 {
@@ -504,16 +504,12 @@ static int esdhc_of_resume(struct device *dev)
 	}
 	return ret;
 }
-
-static const struct dev_pm_ops esdhc_pmops = {
-	.suspend	= esdhc_of_suspend,
-	.resume		= esdhc_of_resume,
-};
-#define ESDHC_PMOPS (&esdhc_pmops)
-#else
-#define ESDHC_PMOPS NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(esdhc_of_dev_pm_ops,
+			esdhc_of_suspend,
+			esdhc_of_resume);
+
 static const struct sdhci_ops sdhci_esdhc_be_ops = {
 	.read_l = esdhc_be_readl,
 	.read_w = esdhc_be_readw,
@@ -657,7 +653,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 	.driver = {
 		.name = "sdhci-esdhc",
 		.of_match_table = sdhci_esdhc_of_match,
-		.pm = ESDHC_PMOPS,
+		.pm = &esdhc_of_dev_pm_ops,
 	},
 	.probe = sdhci_esdhc_probe,
 	.remove = sdhci_pltfm_unregister,
-- 
1.9.1

