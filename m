From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Move sdhci_runtime_pm_bus_off|on() to avoid pre-definition
Date: Mon, 11 Apr 2016 15:32:41 +0200
Message-ID: <1460381561-12511-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32892 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933050AbcDKNcs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2016 09:32:48 -0400
Received: by mail-lf0-f48.google.com with SMTP id e190so155215119lfe.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2016 06:32:47 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

There are no need to have two versions of sdhci_runtime_pm_bus_off|on(),
depending on whether CONFIG_PM is set or unset. Thus it's easy to move the
implementation of these functions a bit earlier to avoid the unnecessary
pre-definition of them, so let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 44 ++++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8e74e75..c6dbe65 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -55,18 +55,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 static int sdhci_do_get_cd(struct sdhci_host *host);
 
-#ifdef CONFIG_PM
-static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
-#else
-static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
-{
-}
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
-{
-}
-#endif
-
 static void sdhci_dumpregs(struct sdhci_host *host)
 {
 	pr_debug(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
@@ -161,6 +149,22 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }
 
+static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
+{
+	if (host->bus_on)
+		return;
+	host->bus_on = true;
+	pm_runtime_get_noresume(host->mmc->parent);
+}
+
+static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+{
+	if (!host->bus_on)
+		return;
+	host->bus_on = false;
+	pm_runtime_put_noidle(host->mmc->parent);
+}
+
 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
@@ -2667,22 +2671,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
-static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
-{
-	if (host->bus_on)
-		return;
-	host->bus_on = true;
-	pm_runtime_get_noresume(host->mmc->parent);
-}
-
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
-{
-	if (!host->bus_on)
-		return;
-	host->bus_on = false;
-	pm_runtime_put_noidle(host->mmc->parent);
-}
-
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
 	unsigned long flags;
-- 
1.9.1

