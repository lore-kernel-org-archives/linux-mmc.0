From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] mmc: sdhci: Remove unused ret variables
Date: Wed,  4 Jun 2014 15:24:29 +0200
Message-ID: <1401888269-15564-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47041 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaFDNYq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 09:24:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

Remove those unused ret variables to make it obvious that these function
will not return any errors in the current implementation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/mmc/host/sdhci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..77c1c27 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2643,7 +2643,6 @@ static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 int sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	/* Disable tuning since we are suspending */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER) {
@@ -2663,14 +2662,14 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	host->runtime_suspended = true;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
 int sdhci_runtime_resume_host(struct sdhci_host *host)
 {
 	unsigned long flags;
-	int ret = 0, host_flags = host->flags;
+	int host_flags = host->flags;
 
 	if (host_flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
@@ -2709,7 +2708,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
 
-- 
2.0.0.rc2

