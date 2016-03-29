From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/8] mmc: mmci: Remove redundant runtime PM calls
Date: Tue, 29 Mar 2016 09:31:07 +0200
Message-ID: <1459236673-5639-2-git-send-email-ulf.hansson@linaro.org>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34168 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbcC2HbZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 03:31:25 -0400
Received: by mail-lb0-f171.google.com with SMTP id vo2so4699567lbb.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2016 00:31:24 -0700 (PDT)
In-Reply-To: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2e6c968..df990bb 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -226,16 +226,11 @@ static int mmci_card_busy(struct mmc_host *mmc)
 	unsigned long flags;
 	int busy = 0;
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	spin_lock_irqsave(&host->lock, flags);
 	if (readl(host->base + MMCISTATUS) & MCI_ST_CARDBUSY)
 		busy = 1;
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
-
 	return busy;
 }
 
@@ -381,9 +376,6 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	host->cmd = NULL;
 
 	mmc_request_done(host->mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
-	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
@@ -1290,8 +1282,6 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	spin_lock_irqsave(&host->lock, flags);
 
 	host->mrq = mrq;
@@ -1318,8 +1308,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long flags;
 	int ret;
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	if (host->plat->ios_handler &&
 		host->plat->ios_handler(mmc_dev(mmc), ios))
 			dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
@@ -1414,9 +1402,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
-
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int mmci_get_cd(struct mmc_host *mmc)
@@ -1440,8 +1425,6 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
 
-		pm_runtime_get_sync(mmc_dev(mmc));
-
 		switch (ios->signal_voltage) {
 		case MMC_SIGNAL_VOLTAGE_330:
 			ret = regulator_set_voltage(mmc->supply.vqmmc,
@@ -1459,9 +1442,6 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		if (ret)
 			dev_warn(mmc_dev(mmc), "Voltage switch failed\n");
-
-		pm_runtime_mark_last_busy(mmc_dev(mmc));
-		pm_runtime_put_autosuspend(mmc_dev(mmc));
 	}
 
 	return ret;
-- 
1.9.1

